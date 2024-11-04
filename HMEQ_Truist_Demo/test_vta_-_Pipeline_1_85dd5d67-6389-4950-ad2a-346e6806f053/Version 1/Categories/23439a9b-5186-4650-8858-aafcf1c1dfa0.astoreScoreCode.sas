/*****************************************************************
* SAS Visual Text Analytics
* Categories Astore Score Code
*
* Modify the following macro variables to match your needs.
*
* NOTE: The text variable on the input table must match the
* name and type of the text variable in the table that was used
* to create the analytic store (astore) table.
****************************************************************/

/* specifies CAS library information for the CAS table that you would like to score. You must modify the value to provide the name of the library that contains the table to be scored. */
%let input_caslib_name = "{input_caslib_name}";

/* specifies the CAS table you would like to score. You must modify the value to provide the name of the input table, such as "MyTable". Do not include an extension. */
/* NOTE: The text variable on the input table must match the name and type of the text variable that was used when the astore was created. */
%let input_table_name = "{input_cas_table_name}";

/* specifies the variables in the input table to copy to the output tables. You must modify the value to specify variables that you want to copy to the output tables, such as "doc_id". Copying the document identifier will map the results to the input data. */
%let copy_vars_variables = "{copy_vars_variables}";

/* specifies the fully qualified path to the categories model .astore file to upload for use in scoring. You must store the categories model .astore file from the downloaded score code in a location that is network-accessible by the SAS compute server. You must modify the value of local_astore_file_path to provide the path to the .astore file, such as "/vta/scoring/{categories model.astore file}". */
%let local_astore_file_path = "{local_astore_file_path}/{categories model.astore file}";

/* After uploading the categories model .astore file, you must specify a CAS library to write out the astore table to use in scoring. This library will be used in the CAS session during the ASTORE scoring action. You must modify the value to provide the name of the library that will contain the astore table. */
%let input_astore_caslib_name = "{input_astore_caslib}";

/* specifies the CAS astore table to use in scoring */
%let input_astore_name = "Categories_Astore";

/* specifies the CAS library to write the score output tables. You must modify the value to provide the name of the library that will contain the output tables that the score code produces. */
%let output_caslib_name = "{output_caslib_name}";

/* specifies the category result output CAS table to produce */
%let output_table_name = "out_cat_astore_results";

/* specifies the hostname for the CAS server. This should be set automatically to the host for the associated SAS Visual Text Analytics project. */
%let cas_server_hostname = "sas-cas-server-default-client";

/* specifies the port for the CAS server. This should be set automatically to the host for the associated SAS Visual Text Analytics project. */
%let cas_server_port = 5570;

/* creates a session and a library reference */
cas mysess host=&cas_server_hostname port=&cas_server_port sessopts=(caslib=&input_astore_caslib_name);
libname mycas cas sessref=mysess datalimit=all;

/* uploads the analytic store to the CAS server */
%let input_astore_name_unquoted = %qsysfunc(dequote(&input_astore_name));
proc astore;
upload rstore=mycas.&input_astore_name_unquoted
store=&local_astore_file_path;
quit;

/* calls the scoring action */
proc cas;
session mysess;
loadactionset "astore";

action astore.score;
param
table={caslib=&input_caslib_name, name=&input_table_name}
rstore={name=&input_astore_name}
options={{name="extend_out_char_var_bytes", value=1024}}
copyVars={&copy_vars_variables}
casout={caslib=&output_caslib_name, name=&output_table_name, replace=TRUE}
;
run;
quit;