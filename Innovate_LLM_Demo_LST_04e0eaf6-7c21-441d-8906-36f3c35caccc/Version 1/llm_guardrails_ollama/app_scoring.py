#
# Copyright © 2023, SAS Institute Inc., Cary, NC, USA.  All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

import importlib.util
import inspect
import logging
import os
import sys
import time
import traceback

import pandas as pd


class LoggerStream(object):
    def __init__(self, logger, log_level):
        self.logger = logger
        self.log_level = log_level
        self.buffer = ""

    def write(self, message):
        if message.strip() != "":
            self.buffer += message
            if "\n" in self.buffer:
                lines = self.buffer.split("\n")
                for line in lines[:-1]:
                    self.logger.log(self.log_level, line.strip())
                self.buffer = lines[-1]

    def get_buffer(self):
        return self.buffer

    def flush(self):
        pass


class ScoreFunctionError(Exception):
    pass


def new_score(data, model_repo, file_metadata, logger):
    orig_stdout = sys.stdout
    orig_stderr = sys.stderr
    stdout_stream = LoggerStream(logger, logging.INFO)
    stderr_stream = LoggerStream(logger, logging.ERROR)
    sys.stdout = stdout_stream
    sys.stderr = stderr_stream

    # change directory to model directory
    current_dir = os.getcwd()
    os.chdir(model_repo)

    # import settings from model directory
    sys.path.append(str(model_repo))
    import settings
    settings.pickle_path = "./"

    # search for score code defined in fileMetadata.json
    score_files = [meta["name"] for meta in file_metadata if "role" in meta
                   and meta["role"] == "score"]

    if len(score_files) == 0:
        # If no score role file was defined, use the first one with `score` as a prefix
        glob_list = list(model_repo.glob("score*.py"))
        score_file = glob_list[0]
    else:
        # If multiple files with the score role are present, use the first
        score_file = score_files[0]

    # Import score module from the model directory
    spec = importlib.util.spec_from_file_location(score_file, model_repo / score_file)
    score_module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(score_module)

    # Locate score function from the score module directory
    score_function = None
    for name, obj in inspect.getmembers(score_module):
        if inspect.isfunction(obj) and name.startswith("score"):
            score_function = getattr(score_module, name)
            break

    if score_function is None:
        raise ValueError("Score function could not be found.")

    # Check that data matches function arguments and prune as needed
    data_columns = data.columns.tolist()
    function_arguments = inspect.signature(score_function).parameters
    argument_names = set(function_arguments.keys())
    extra_data = list(set(data_columns) - set(argument_names))
    missing_data = list(set(argument_names) - set(data_columns))
    if len(missing_data) > 0:
        raise ValueError(
            f"The scoring function requires data for all of its specified columns. "
            f"Data for the following columns was not found: "
            f"{', '.join(missing_data)}."
        )
    elif len(extra_data) > 0:
        logger.info(
            f"The data provided included additional data columns than were expected "
            f"based off the model's input schema. The additional columns were "
            f"{', '.join(extra_data)}"
        )
        data = data.drop(extra_data, axis=1)

    score_start = time.time()
    # Pass data to score module and return scores
    try:
        scores = score_function(**data)
    except Exception:
        exc_type, exc_value, exc_tb = sys.exc_info()
        traceback_str = ''.join(traceback.format_exception(exc_type, exc_value, exc_tb))
        scrubbed_traceback = _scrub_traceback_paths(traceback_str)
        logger.error(
            f"An exception occurred within the {score_function.__name__} "
            f"function of the score code:\n{scrubbed_traceback}"
        )
        error = scrubbed_traceback.split("\n")[-2]
        raise ScoreFunctionError(error)
    finally:
        sys.stdout = orig_stdout
        sys.stderr = orig_stderr
    score_time = time.time() - score_start
    var_string = score_function.__doc__.split(':')[1].replace(' ', '')
    var_list = var_string.split(',')
    return_dict = {}
    if isinstance(scores, pd.DataFrame):
        return_dict = scores.to_dict(orient="list")
    elif isinstance(scores, tuple) or isinstance(scores, list):
        for var, var_score in zip(var_list, scores):
            return_dict[var] = var_score
    else:
        return_dict = scores

    os.chdir(current_dir)
    sys.stdout = orig_stdout
    sys.stderr = orig_stderr
    return return_dict, str(score_file), score_function.__name__, score_time


def _scrub_traceback_paths(traceback_str):
    lines = traceback_str.splitlines()
    scrubbed_lines = []

    for line in lines:
        # Check if the line contains a file path
        if "File" in line and "line" in line and '"' in line:
            parts = line.split('"')
            file_path = parts[1]
            file_name = os.path.basename(file_path)
            modified_line = line.replace(file_path, file_name)
            scrubbed_lines.append(modified_line)
        else:
            scrubbed_lines.append(line)

    return "\n".join(scrubbed_lines)