*------------------------------------------------------------*;
* Macro Variables for input, output data and files;
  %let dm_datalib       =;                 /* Libref associated with the CAS training table */
  %let dm_output_lib    = &dm_datalib;     /* Libref associated with the output CAS tables */
  %let dm_data_caslib   =;                 /* CASLIB associated with the training table */
  %let dm_output_caslib = &dm_data_caslib; /* CASLIB associated with the output tables */
  %let dm_memName= ;    /* Training Table name */
  %let dm_memnameNlit = %sysfunc(nliteral(&dm_memname));
  %let dm_lib     = WORK;
  %let dm_folder  = %sysfunc(pathname(work));
*------------------------------------------------------------*;
*------------------------------------------------------------*;
  * Training for gradboost;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
  * Initializing Variable Macros;
*------------------------------------------------------------*;
%macro dm_assessforbias;
'GENDER'n 'RACE_NEW'n
%mend dm_assessforbias;
%global dm_num_assessforbias;
%let dm_num_assessforbias = 2 ;
%macro dm_unary_input;
%mend dm_unary_input;
%global dm_num_unary_input;
%let dm_num_unary_input = 0;
%macro dm_interval_input;
'ACT_COMP'n 'ACT_ENGL'n 'ACT_MATH'n 'ACT_READ'n 'ACT_SCIENCE'n 'ACT_WRITING'n
'AGE'n 'CNSS_TGPA'n 'College'n 'HS_GPA'n 'Ratio_B_to_A'n 'Ratio_C_to_A'n
'Ratio_C_to_B'n 'Ratio_D_to_A'n 'Ratio_D_to_B'n 'Ratio_D_to_C'n 'Ratio_F_to_A'n
'Ratio_F_to_B'n 'Ratio_F_to_C'n 'Ratio_F_to_D'n 'SAT_ES_SUB'n 'SAT_MATH'n
'SAT_MUL_CHCE'n 'SAT_VERBAL'n 'SAT_WRITING'n 'TOTAL_SAT'n
%mend dm_interval_input;
%global dm_num_interval_input;
%let dm_num_interval_input = 26 ;
%macro dm_binary_input;
%mend dm_binary_input;
%global dm_num_binary_input;
%let dm_num_binary_input = 0;
%macro dm_nominal_input;
'AFFIL_ALUM_R1'n 'AFFIL_ALUM_R2'n 'AFFIL_RELATION1'n 'AFFIL_RELATION2'n
'CNSS_LOAD'n
%mend dm_nominal_input;
%global dm_num_nominal_input;
%let dm_num_nominal_input = 5 ;
%macro dm_ordinal_input;
%mend dm_ordinal_input;
%global dm_num_ordinal_input;
%let dm_num_ordinal_input = 0;
%macro dm_class_input;
'AFFIL_ALUM_R1'n 'AFFIL_ALUM_R2'n 'AFFIL_RELATION1'n 'AFFIL_RELATION2'n
'CNSS_LOAD'n
%mend dm_class_input;
%global dm_num_class_input;
%let dm_num_class_input = 5 ;
%macro dm_segment;
%mend dm_segment;
%global dm_num_segment;
%let dm_num_segment = 0;
%macro dm_id;
%mend dm_id;
%global dm_num_id;
%let dm_num_id = 0;
%macro dm_text;
%mend dm_text;
%global dm_num_text;
%let dm_num_text = 0;
%macro dm_strat_vars;
%mend dm_strat_vars;
%global dm_num_strat_vars;
%let dm_num_strat_vars = 0;
*------------------------------------------------------------*;
  * Initializing Macro Variables *;
*------------------------------------------------------------*;
  %let dm_data_outfit = &dm_lib..outfit;
  %let dm_file_scorecode = &dm_folder/scorecode.sas;
  %let dm_caslibOption =;
  data _null_;
     if index(symget('dm_data_caslib'), '(') or index(symget('dm_data_caslib'), ')' ) or (symget('dm_data_caslib')=' ') then do;
        call symput('dm_caslibOption', ' ');
     end;
     else do;
        call symput('dm_caslibOption', 'caslib="'!!ktrim(symget('dm_data_caslib'))!!'"');
     end;
  run;


*------------------------------------------------------------*;
  * Component Code;
*------------------------------------------------------------*;
proc gradboost data=&dm_datalib..&dm_memnameNlit(&dm_caslibOption)
     earlystop(tolerance=0 stagnation=5 minimum=NO )
     binmethod=QUANTILE
     maxbranch=2
     nomsearch(maxcategories=128)
     assignmissing=USEINSEARCH minuseinsearch=1
     minleafsize=5
     seed=12345
     printtarget
  ;
  partition rolevar='_PartInd_'n (TRAIN='1' VALIDATE='0');
  autotune  bestmodelactionhistory=&dm_output_lib..histtable historysyntax=LUA useparameters=CUSTOM tuningparameters=(
     lasso(LB=0 UB=10 INIT=0)
     learningrate(LB=0.01 UB=1 INIT=0.1)
     ntrees(LB=20 UB=150 INIT=100)
     ridge(LB=0 UB=10 INIT=1)
     samplingrate(LB=0.1 UB=1 INIT=0.5)
     maxdepth(LB=1 UB=6 INIT=4)
     numbin(LB=20 UB=100 INIT=50)
     vars_to_try(LB=1 UB=31 INIT=31)
     )
     searchmethod=GA objective=ASE maxtime=3600
     maxevals=50 maxiters=5 popsize=10
  ;
  target 'EOT_SGPA'n / level=interval;
  input %dm_interval_input / level=interval;
  input %dm_binary_input %dm_nominal_input %dm_ordinal_input %dm_unary_input  / level=nominal;
  ods output
     VariableImportance   = &dm_lib..varimportance
     Fitstatistics        = &dm_data_outfit
     PredName = &dm_lib..PredProbName
     TunerResults = &dm_lib..tuneresults
     BestConfiguration = &dm_lib..tunebest
     EvaluationHistory = &dm_lib..tuneevalhist
     IterationHistory = &dm_lib..tuneiterhist
  ;
  savestate rstore=&dm_output_lib.._85IEUGY549H5E7NCD0WE775PA_ast;
run;
