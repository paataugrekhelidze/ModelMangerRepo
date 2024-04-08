#
# Copyright © 2021, SAS Institute Inc., Cary, NC, USA.  All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

import datetime
import json
import logging.config
import os
import time
import uuid
from io import StringIO, BytesIO
from pathlib import Path

import numpy as np
import pandas as pd

from flask import Flask, jsonify, request, g, abort, Response, stream_with_context
from flask import send_from_directory
from flasgger import Swagger

from app_logging import setup_transaction_logger
from app_setup import setup_app
from app_scoring import new_score, ScoreFunctionError
from schemas import DataFileSchema, ErrorResponseSchema, StatusSchema

import warnings
warnings.filterwarnings("ignore")

API_VERSION = "2"


class DevConfig:
    DEBUG = True


class ProdConfig:
    DEBUG = False


def get_env_conf():
    env_mode = os.getenv("MODE")
    return env_mode


app = Flask(__name__)

mode = get_env_conf()
if mode == "dev":
    app.config.from_object(DevConfig)
elif mode == "prod":
    app.config.from_object(ProdConfig)
else:
    app.config.from_object(ProdConfig)

log_file_path = Path(__file__).parent / "log.conf"
logging.config.fileConfig(log_file_path)

root_logger = logging.getLogger("root")
api_logger = logging.getLogger("api")
score_logger = logging.getLogger("score")
retrieval_logger = logging.getLogger("retrieval")
gunicorn_logger = logging.getLogger("gunicorn.error")

try:
    file_metadata, model_name, model_repo, input_schema, csv_schema, output_schema = \
        setup_app(root_logger)
except Exception as e:
    root_logger.exception("Unexpected exception during app setup: %s", e)
    raise  # Or use sys.exit(code) with an exit code

swagger_config = {
    "definitions": {
        "CSVContent": csv_schema,
        "DataFile": DataFileSchema,
        "ErrorResponse": ErrorResponseSchema,
        "PCRInput": input_schema,
        "PCROutput": output_schema,
        "Status": StatusSchema,
    },
    "headers": [

    ],
    "specs": [
        {
            "endpoint": f"SAS Python Runtime: {model_name}",
            "route": f"/{model_name}/apiMeta/api",
            "rule_filter": lambda rule: True,
            "model_filter": lambda tag: True,
        }
    ],
    "static_url_path": "/flasgger_static",
    "swagger_ui": app.config["DEBUG"],  # Turn off in non-dev environment
    "specs_route": "/apidocs/",
    "version": "2.0.0"
}
swagger = Swagger(app, config=swagger_config)


def scrub_folder(path, max_num, max_size, exclude=None):
    folder = Path(path)
    if not exclude:
        exclude = []

    files = sorted(folder.iterdir(), key=lambda f: f.stat().st_ctime)
    files = [file for file in files if file.name not in exclude]

    while len(files) > max_num:
        file_to_remove = folder / files.pop(0)
        file_to_remove.unlink()

    total_size = sum(file.stat().st_size for file in files) / 10**6
    while total_size > max_size:
        file_to_remove = folder / files.pop(0)
        total_size -= file_to_remove.stat().st_size
        file_to_remove.unlink()


def scrub_log_data_folders():
    log_path = Path("/tmp/log")
    data_path = Path("/tmp/data")

    scrub_folder(
        log_path, 10, 10, ["root.log", "api.log", "score.log", "retrieval.log"]
    )
    scrub_folder(data_path, 10, 100)


def create_request_metadata():
    api_logger.info(f"Request: {request.method} {request.url_rule}")
    api_logger.info(f"Request Headers: {request.headers}")
    if request.method == "POST" and request.is_json:
        api_logger.info(f"Request Data: {request.json}")
    elif request.method == "POST" and request.content_type == "multipart/form-data":
        if len(request.files) == 1:
            api_logger.info(f"Request File: {next(iter(request.files)).filename}")
        elif len(request.files) > 1:
            api_logger.error("Multiple files uploaded. Only one file allowed.")
            return abort(415, "Multiple files uploaded. Only one file allowed.")
        else:
            api_logger.error("No files uploaded in the POST request.")
            return abort(415, "No files uploaded in the POST request.")
    # Start a timer for the total request time
    g.start_time = time.perf_counter_ns()
    # Record the start time for the request
    g.time_stamp = datetime.datetime.now().isoformat()

    # Initialize flags for missing client or transaction ids
    g.rand_client = False
    g.rand_transaction = False
    # Check content_type, then look for/create metadata
    if not request.content_type:
        # GET requests typically don't include a content-type
        g.client_id = _check_headers_for_value("client_id")
        if not g.client_id:
            g.client_id = str(uuid.uuid4())
            api_logger.info(f"Randomly generated client id is {g.client_id}")
            g.rand_client = True
        else:
            api_logger.info(f"Provided client id is {g.client_id}")

        g.transaction_id = _check_headers_for_value("transaction_id")
        if not g.transaction_id:
            g.transaction_id = str(uuid.uuid4())
            api_logger.info(
                f"Randomly generated transaction id is {g.transaction_id}"
            )
            g.rand_transaction = True
        else:
            api_logger.info(f"Provided transaction id is {g.transaction_id}")
    elif request.content_type == "application/json":
        # Collect a client ID if provided, otherwise assign a random one
        g.client_id, g.rand_client = _check_json_for_metadata("client_id")

        # Collect a transaction ID if provided, otherwise assign a random one
        g.transaction_id, g.rand_transaction = _check_json_for_metadata(
            "transaction_id"
        )
    else:
        # Check for specific headers and assign a random value if not found
        g.client_id = _check_headers_for_value("client_id")
        if not g.client_id:
            g.client_id = str(uuid.uuid4())
            api_logger.info(f"Randomly generated client id is {g.client_id}")
            g.rand_client = True
        else:
            api_logger.info(f"Provided client id is {g.client_id}")

        g.transaction_id = _check_headers_for_value("transaction_id")
        if not g.transaction_id:
            g.transaction_id = str(uuid.uuid4())
            api_logger.info(
                f"Randomly generated transaction id is {g.transaction_id}"
            )
            g.rand_transaction = True
        else:
            api_logger.info(f"Provided transaction id is {g.transaction_id}")

    if request.path in ["/executions", f"/{model_name}", "/stream"]:
        g.transaction_logger = setup_transaction_logger(g.transaction_id)


@app.before_request
def before_request():
    scrub_log_data_folders()
    create_request_metadata()


@app.after_request
def after_request(response):
    if request.path in ["/executions", f"/{model_name}", "/stream"]:
        handler = g.transaction_logger.handlers[0]
        handler.close()
        g.transaction_logger.removeHandler(handler)
    return response


@app.route("/internal/live", methods=["GET"])
def liveness():
    """
    Internal kubernetes endpoint to determine liveliness of the container.

    ---
    tags:
        - "k-8s-probes-controller"
    operationId: liveness
    responses:
        200:
            description: OK
            content:
                "*/*":
                    schema:
                        $ref: "#/definitions/Status"
        400:
            description: Bad Request
            content:
                "*/*":
                    schema:
                        $ref: "#/definitions/ErrorResponse"
        500:
            description: Internal Server Error
            content:
                "*/*":
                    schema:
                        $ref: "#/definitions/ErrorResponse"
    """
    if is_alive():
        api_logger.info("Response: Status Code 200")
        api_logger.info("Response Data: \"UP\"")
        return status_response("UP", "It's alive"), 200
    else:
        return abort(500, message="It's dead")


@app.route("/internal/ready", methods=["GET"])
def readiness():
    """
    Internal kubernetes endpoint to determine readiness of the container.

    ---
    tags:
        - "k-8s-probes-controller"
    operationId: readiness
    responses:
        200:
            description: OK
            content:
                "*/*":
                    schema:
                        $ref: "#/definitions/Status"
        400:
            description: Bad Request
            content:
                "*/*":
                    schema:
                        $ref: "#/definitions/ErrorResponse"
        500:
            description: Internal Server Error
            content:
                "*/*":
                    schema:
                        $ref: "#/definitions/ErrorResponse"

    """
    if is_ready():
        api_logger.info("Response: Status Code 200")
        api_logger.info("Response Data: \"UP\"")
        return status_response("UP", "It's ready"), 200
    else:
        return abort(503, message="It's not ready")

def consume_generator(generator):
    try:
        for item in generator:
            yield item  # Format as needed
    except StopIteration:
        pass

@app.route("/executions", methods=["POST"])
@app.route("/stream", methods=["POST"])
@app.route(f"/{model_name}", methods=["POST"])
def score_model():
    """
    Model score execution endpoint.

    The /{model_name} endpoint executes a single call score execution that returns the
    results of the score in the API response. The /executions endpoint executes a two
    call score execution that returns the test_id in the API response. Collection of the
    results is handled by the /query/{test_id} endpoint.

    ---
    tags:
        - score
    operationId: score
    requestBody:
        required: true
        content:
            application/json:
                schema:
                    $ref: "#/definitions/PCRInput"
            multipart/form-data:
                schema:
                    $ref: "#/definitions/DataFile"
            text/csv:
                schema:
                    $ref: "#/definitions/CSVContent"

    responses:
        200:
            description: OK
            content:
                application/json:
                    schema:
                        $ref: "#/definitions/PCROutput"
                application/vnd.sas.python.container.runtime.output+json:
                    schema:
                        $ref: "#/definitions/PCROutput"
        201:
            description: CREATED
            content:
                application/json:
                    schema:
                        $ref: "#/definitions/PCROutput"
        400:
            description: BAD_REQUEST
            content:
                application/json:
                    schema:
                        $ref: "#/definitions/ErrorResponse"
                application/vnd.sas.python.container.runtime.error+json:
                    schema:
                        $ref: "#/definitions/ErrorResponse"
        500:
            description: INTERNAL_SERVER_ERROR
            content:
                application/json:
                    schema:
                        $ref: "#/definitions/ErrorResponse"
                application/vnd.sas.python.container.runtime.error+json:
                    schema:
                        $ref: "#/definitions/ErrorResponse"

    """
    try:
        g.transaction_logger.info(
            f"Score request received from {request.method} {request.url_rule}"
        )
        # Check the content type to determine how to read data to dataframe
        content_type = request.content_type
        g.transaction_logger.info(f"Score request content type: {content_type}")
        if not content_type:
            api_logger.info("Response: Status Code 400")
            api_logger.info("Response Data: \"No content type specified.\"")
            return abort(400, "No content type specified.")
        # pd.df.to_json() or SCR format (see https://go.documentation.sas.com/doc/en
        # /mascrtcdc/v_016/mascrtag/n12e5o7e0j8nipn1vtpjhuvcfdse
        # .htm#p0jb64vih6rqpun1rn3ivuts4oul)
        elif content_type == "application/json":
            json_data = _format_json_data()
            # Nested dicts indicates the PCRInput format of the jsonified data
            data = _check_json_input_type(json_data)
        # CSV data sent in as a string; data = """key1,value1,key2,value2"""
        elif content_type == "text/csv":
            data = pd.read_csv(StringIO(request.data.decode("utf-8")))
        # File data; files = {"file": open("file.ext", "rb")}
        elif "multipart/form-data" in content_type:
            file = request.files.get("file")
            data = _read_file_data(file)
        else:
            api_logger.info("Response: Status Code 415")
            api_logger.info("Response Data: \"Invalid content type.\"")
            return abort(415, "Invalid content type.")

        g.transaction_logger.info(
            "The data was successfully formatted into a pandas DataFrame."
        )
        rule = request.url_rule.rule

        # Execution the model scoring method
        scores, g.score_file, g.score_function, score_time = new_score(
            data,
            model_repo,
            file_metadata,
            g.transaction_logger
        )
        g.transaction_logger.info(
            f"The model was successfully scored using the {g.score_function} function "
            f"from the {g.score_file} file in {score_time} seconds."
        )

        extra_metadata = {
            "score_execution_time": score_time,
        }

        # /executions endpoint uses 2 call logic & writes results to /tmp/data
        if "execution" in rule:
            output_df = pd.DataFrame(scores)
            output_df = pd.merge(
                data,
                output_df,
                how="inner",
                left_index=True,
                right_index=True
            )
            output_df.to_csv(f"/tmp/data/{g.transaction_id}.csv", sep=',', index=False)
            metadata = _create_metadata(extra_metadata)
            api_logger.info("Response: Status Code 201")
            api_logger.info(f"Response Data: \"{metadata}\"")
            return output_response(metadata=metadata, status=201), 201
        elif "stream" in rule:
            return Response(stream_with_context(consume_generator(scores)))
        else:
            metadata = _create_metadata(extra_metadata)
            api_logger.info("Response: Status Code 200")
            api_logger.info(f"Response Data: \"{metadata}\"")
            return output_response(data=scores, metadata=metadata, status=200), 200
    except ScoreFunctionError as error:
        g.transaction_logger.error(
            f"Error occurred in the model scoring function: {error}"
        )
        g.remediation = f"Contact an administrator to view the full traceback logs. " \
                        f"The transaction id is {g.transaction_id}."
        return abort(422, error.args[0])
    except Exception as error:
        g.transaction_logger.error(
            f"Error occurred in the score execution endpoint: {error}"
        )
        if "Score function could not be found." in error.args[0]:
            return abort(422, error.args[0])
        elif "Data for the following columns was not found" in error.args[0]:
            return abort(422, error.args[0])
        elif "cannot process any additional data provided" in error.args[0]:
            return abort(422, error.args[0])
        elif "Not all data columns are the same length" in error.args[0]:
            return abort(422, error.args[0])
        elif "Unknown data type" in error.args[0]:
            return abort(422, error.args[0])
        elif "The provided data in column" in error.args[0]:
            return abort(422, error.args[0])
        else:
            return abort(400, error.args[0])


# In the future we could extend this call to two calls
# one for checking status and the other for retrieving csv file
# Update: This is already built in for flask using the HEAD method
# TODO: errors for bad test_ids -- improper format and file not found
@app.route("/query/<uuid:test_id>", methods=["GET"])
def query(test_id):
    """
    read csv file from <test_id>.csv as an attachment
    """
    try:
        if str(test_id).endswith(".csv"):
            uuid_obj = uuid.UUID(str(test_id[:-4]))
        else:
            uuid_obj = uuid.UUID(str(test_id))
    except ValueError:
        return abort(400, "Invalid UUID provided.")

    full_output_file = Path("/tmp/data") / (str(uuid_obj) + ".csv")
    if not full_output_file.exists():
        return abort(404, "File not found.")

    return send_from_directory(
        Path("/tmp/data"),
        (str(uuid_obj) + ".csv"),
        as_attachment=True
    )


@app.route("/query/<uuid:test_id>/log", methods=["GET"])
def query_log(test_id):
    """
    read log file from <test_id>.log as an attachment
    """
    try:
        if str(test_id).endswith(".csv"):
            uuid_obj = uuid.UUID(str(test_id[:-4]))
        else:
            uuid_obj = uuid.UUID(str(test_id))
    except ValueError:
        return abort(400, "Invalid UUID provided.")

    full_output_file = Path("/tmp/log") / (str(uuid_obj) + ".log")
    if not full_output_file.exists():
        return not_found(full_output_file)

    return send_from_directory(Path("/tmp/log"), (str(uuid_obj) + ".log"), as_attachment=True)


@app.errorhandler(400)
def bad_request(error, details="", remediation=""):
    response = dict(
        details=str(details),
        errorCode=400,
        errorMessage=str(error),
        httpStatus="400 BAD_REQUEST",
        remediation=str(remediation)
    )
    return jsonify(response), 400


@app.errorhandler(404)
def not_found(error, details="", remediation=""):
    response = dict(
        details=str(details),
        errorCode=404,
        errorMessage=str(error),
        httpStatus="404 NOT_FOUND",
        remediation=str(remediation)
    )
    return jsonify(response), 404


@app.errorhandler(405)
def method_not_allowed(error):
    response = dict(
        version=API_VERSION,
        httpStatus="405 METHOD_NOT_ALLOWED",
        errorMessage=f"Request method '{request.method}' not supported",
        errorCode=405
    )
    return jsonify(response), 405


@app.errorhandler(422)
def unprocessable_entity(error):
    if not g.get("remediation"):
        g.remediation = ""
    response = dict(
        version=API_VERSION,
        httpStatus="422 UNPROCESSABLE_ENTITY",
        errorMessage=f"{str(error)}",
        errorCode=422,
        remediation=str(g.remediation),
    )
    return jsonify(response), 422


def _read_file_data(file):
    extension = os.path.splitext(file.filename)[1].lstrip(".")
    try:
        # Check for a valid pandas import against the supplied file extension
        if extension == "":
            # Maintain backwards compatibility -- produce deprecation warning
            api_logger.warning(
                "File without an extension was processed by the scoring endpoint. "
                "Future versions of this container will deprecate the capacity to read "
                "in csv files without a file extension. Please include the file name "
                "with the extension in the body of the request: {'file': "
                "('data.ext', data}, or use the text/csv or application/json "
                "content-types."
            )
            try:
                file_bytes = file.read()
                with open(model_repo / "inputVar.json", "r") as file:
                    var_dict = json.load(file)
                var_names = []
                for var in var_dict:
                    var_names.append(var["name"])
                csv_data_old_method = pd.read_csv(BytesIO(file_bytes))
                missing_data = list(
                    set(var_names) - set(csv_data_old_method.columns.tolist())
                )
                assert len(missing_data) == 0
                return csv_data_old_method
            except AssertionError:
                abort(
                    415,
                    f"The scoring function requires data for all of its specified "
                    f"columns. Data for the following columns was not found: "
                    f"{', '.join(missing_data)}."
                )
            except:
                # If the file extension doesn't exist, abort the request
                return abort(
                    415,
                    "No file extension specified. Please include the file name with "
                    "the extension in the body of the request: {'file': "
                    "('data.ext', data}, or use the text/csv or application/json "
                    "content-types."
                )
        elif extension == "csv":
            return pd.read_csv(file)
        elif extension == "xls":
            try:
                import xlrd
            except ImportError:
                return abort(
                    415,
                    "The xlrd package >= 1.0.0 is required for reading *.xls files "
                    "into a Pandas DataFrame. Please include this package in the "
                    "requirements.json file when publishing to the container "
                    "destination."
                )
            return pd.read_excel(file)
        elif extension == "xlsx":
            return pd.read_excel(file)
        elif extension == "json":
            return pd.read_json(file)
        # TODO: database connection needed
        # elif extension in ["db", "sqlite", "sqlite3", "mysql", "postgresql"]:
        #     return pd.read_sql(file)
        elif extension == "parquet":
            return pd.read_parquet(file)
        elif extension == "feather":
            return pd.read_feather(file)
        # TODO: implement hdf file handling
        # elif extension in ["h5", "hdf"]:
        #     return pd.read_hdf(file)
        elif extension == "dta":
            try:
                return pd.read_stata(file).drop("index", axis=1)
            except KeyError:
                return pd.read_stata(file)
        elif extension == "sas7bdat":
            return pd.read_sas(file, format="sas7bdat")
        elif extension == "html":
            # read_html() returns a list of DataFrames
            try:
                return pd.read_html(file)[0].drop("Unnamed: 0", axis=1)
            except KeyError:
                return pd.read_html(file)[0]
        elif extension == "orc":
            return pd.read_orc(file)
        elif extension == "xml":
            return pd.read_xml(file)
        elif extension in ["sav", "zsav"]:
            return pd.read_spss(file)
        elif extension in ["pkl", "pickle"]:
            return pd.read_pickle(file)
        else:
            return abort(400, f"Unsupported file extension: {extension}")
    except AttributeError as err:
        if str(err).startswith("<module 'pandas'>"):
            return abort(400, f"Unsupported import for pandas version {pd.__version__}")
        else:
            raise
    except ImportError as err:
        return abort(400, err)


def _create_metadata(extra_meta):
    total_time = int((time.perf_counter_ns() - g.start_time))
    metadata = dict(
        client_id=g.client_id,
        elapsed_nanos=total_time,
        module_id=g.score_file,
        step_id=g.score_function,
        timestamp=g.time_stamp,
        transaction_id=g.transaction_id
    )
    metadata.update(extra_meta)
    api_logger.info(f"Elapsed time for {request.url_rule} was {total_time} nanoseconds")
    return metadata


def _check_headers_for_value(key):
    # Check headers for a metadata value or the key value
    if request.headers.get("metadata"):
        return request.headers.get("metadata").get(key)
    elif request.headers.get(key):
        return request.headers.get(key)
    else:
        return None


def _check_json_input_type(data):
    # Single row json format (pandas accepts multiple rows still)
    if data.get("data"):
        lengths = np.array(
            [np.squeeze(values).size for values in data["data"].values()]
        )
        if not np.all(lengths == lengths[0]):
            raise ValueError(
                "Not all data columns are the same length. Please provide a dataset "
                "with equivalent lengths for all data columns."
            )
        try:
            return pd.DataFrame(data["data"])
        except ValueError:
            return pd.DataFrame(data["data"], index=[0])
    # Multi row json format
    elif data.get("inputs"):
        lengths = np.array(
            [np.squeeze(val_dict["value"]).size for val_dict in data["inputs"]]
        )
        if not np.all(lengths == lengths[0]):
            raise ValueError(
                "Not all data columns are the same length. Please provide a dataset "
                "with equivalent lengths for all data columns."
            )
        df = pd.DataFrame(data["inputs"])
        if not isinstance(df["value"].tolist()[0], list):
            return pd.DataFrame(
                columns=df["name"].tolist(), data=[df["value"].tolist()]
            )
        else:
            return pd.DataFrame(
                index=df["name"].tolist(), data=df["value"].tolist()
            ).T.infer_objects()
    # Normal pandas DataFrame
    else:
        return pd.DataFrame(data)


def _check_json_for_metadata(key):
    # Collect a client ID if provided, otherwise assign a random one
    data = _format_json_data()
    if data.get("metadata"):
        value = data.get("metadata", {}).get(key)
    else:
        value = _check_headers_for_value(key)

    if not value:
        api_logger.info(f"Randomly generated {key} is {value}")
        value = str(uuid.uuid4())
        rand_key = True
    else:
        api_logger.info(f"Provided {key} is {value}")
        rand_key = False

    return value, rand_key


def _format_json_data():
    if isinstance(request.get_json(), dict):
        return request.get_json()
    elif isinstance(request.get_json(), str):
        return json.loads(request.get_json())


def status_response(code="200", description="OK"):
    response = {
        "code": code,
        "description": description
    }
    return jsonify(response)


def output_response(metadata, data=None, status=None):
    response = {
        "data": data,
        "metadata": metadata,
        "version": API_VERSION,
        "id": g.transaction_id,
        "codeFileUri": "",
        "status": status,
    }
    return jsonify(response)


def is_alive():
    return True


def is_ready():
    return True