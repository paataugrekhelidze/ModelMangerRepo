*------------------------------------------------------------*;
* Macro Variables for input, output data and files;
  %let dm_datalib       =;                 /* Libref associated with the CAS training table */
  %let dm_output_lib    = &dm_datalib;     /* Libref associated with the output CAS tables */
  %let dm_data_caslib   =;                 /* CASLIB associated with the training table */
  %let dm_output_caslib = &dm_data_caslib; /* CASLIB associated with the output tables */
  %let dm_inputTable=;  /* Input Table */
  %let dm_memName=_input_3Z92HC9YI6ZHE5UN574K8Z7X8;
  %let dm_memNameNLit='_input_3Z92HC9YI6ZHE5UN574K8Z7X8'n;
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
%mend dm_assessforbias;
%global dm_num_assessforbias;
%let dm_num_assessforbias = 0;
%macro dm_unary_input;
%mend dm_unary_input;
%global dm_num_unary_input;
%let dm_num_unary_input = 0;
%macro dm_interval_input;
'cpy_int_med_imp_Age'n 'cpy_int_med_imp_HospAdmTime'n 'cpy_int_med_imp_Hour'n
'cpy_int_med_imp_ICULOS'n 'cpy_int_med_imp_O2Sat'n 'cpy_int_med_imp_Var1'n
'nhoks_nloks_pow_n1_DBP'n 'nhoks_nloks_pow_n1_HR'n 'nhoks_nloks_pow_n1_MAP'n
'nhoks_nloks_pow_n1_Resp'n 'nhoks_nloks_pow_n1_SBP'n 'nhoks_nloks_pow_p2_DBP'n
%mend dm_interval_input;
%global dm_num_interval_input;
%let dm_num_interval_input = 12 ;
%macro dm_binary_input;
%mend dm_binary_input;
%global dm_num_binary_input;
%let dm_num_binary_input = 0;
%macro dm_nominal_input;
'all_l_oks_dtree_5_Age'n 'cpy_nom_miss_lev_lab_Unit1'n
'cpy_nom_miss_lev_lab_Unit2'n 'cpy_nom_mode_imp_lab_Gender'n 'miss_ind_DBP'n
'miss_ind_HR'n 'miss_ind_MAP'n 'miss_ind_O2Sat'n 'miss_ind_Resp'n
'miss_ind_SBP'n 'miss_ind_Unit1'n 'miss_ind_Unit2'n 'nhoks_nloks_dtree_5_HR'n
'nhoks_nloks_dtree_5_MAP'n 'nhoks_nloks_dtree_5_Resp'n
'nhoks_nloks_dtree_5_SBP'n
%mend dm_nominal_input;
%global dm_num_nominal_input;
%let dm_num_nominal_input = 16 ;
%macro dm_ordinal_input;
%mend dm_ordinal_input;
%global dm_num_ordinal_input;
%let dm_num_ordinal_input = 0;
%macro dm_class_input;
'all_l_oks_dtree_5_Age'n 'cpy_nom_miss_lev_lab_Unit1'n
'cpy_nom_miss_lev_lab_Unit2'n 'cpy_nom_mode_imp_lab_Gender'n 'miss_ind_DBP'n
'miss_ind_HR'n 'miss_ind_MAP'n 'miss_ind_O2Sat'n 'miss_ind_Resp'n
'miss_ind_SBP'n 'miss_ind_Unit1'n 'miss_ind_Unit2'n 'nhoks_nloks_dtree_5_HR'n
'nhoks_nloks_dtree_5_MAP'n 'nhoks_nloks_dtree_5_Resp'n
'nhoks_nloks_dtree_5_SBP'n
%mend dm_class_input;
%global dm_num_class_input;
%let dm_num_class_input = 16 ;
%macro dm_segment;
%mend dm_segment;
%global dm_num_segment;
%let dm_num_segment = 0;
%macro dm_id;
'Alkalinephos'n 'AST'n 'Bilirubin_direct'n 'Bilirubin_total'n 'Fibrinogen'n
'Patient_ID'n 'SaO2'n 'TroponinI'n
%mend dm_id;
%global dm_num_id;
%let dm_num_id = 8 ;
%macro dm_text;
%mend dm_text;
%global dm_num_text;
%let dm_num_text = 0;
%macro dm_strat_vars;
'SepsisLabel'n
%mend dm_strat_vars;
%global dm_num_strat_vars;
%let dm_num_strat_vars = 1 ;
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
     earlystop(tolerance=0 stagnation=5 minimum=NO metric=MCR)
     binmethod=QUANTILE
     maxbranch=2
     nomsearch(maxcategories=128)
     assignmissing=USEINSEARCH minuseinsearch=1
     minleafsize=5
     seed=12345
     printtarget
  ;
  partition rolevar='_PartInd_'n (TRAIN='1' VALIDATE='0' TEST='2');
  autotune  bestmodelactionhistory=&dm_output_lib..histtable historysyntax=LUA useparameters=CUSTOM tuningparameters=(
     lasso(LB=0 UB=10 INIT=0)
     learningrate(LB=0.01 UB=1 INIT=0.1)
     ntrees(LB=20 UB=150 INIT=100)
     ridge(LB=0 UB=10 INIT=1)
     samplingrate(LB=0.1 UB=1 INIT=0.5)
     maxdepth(LB=1 UB=10 INIT=4)
     numbin(LB=20 UB=100 INIT=50)
     vars_to_try(LB=1 UB=28 INIT=28)
     )
     searchmethod=GA objective=KS maxtime=3600
     maxevals=50 maxiters=5 popsize=10
     targetevent='1'
  ;
  target 'SepsisLabel'n / level=nominal;
  input %dm_interval_input / level=interval;
  input %dm_binary_input %dm_nominal_input %dm_ordinal_input %dm_unary_input  / level=nominal;
  ods output
     VariableImportance   = &dm_lib..varimportance
     Fitstatistics        = &dm_data_outfit
     PredProbName = &dm_lib..PredProbName
     PredIntoName = &dm_lib..PredIntoName
     TunerResults = &dm_lib..tuneresults
     BestConfiguration = &dm_lib..tunebest
  ;
  id 'Alkalinephos'n 'AST'n 'Bilirubin_direct'n 'Bilirubin_total'n 'Fibrinogen'n 'Patient_ID'n 'SaO2'n 'TroponinI'n;
  savestate rstore=&dm_output_lib.._3Z92HC9YI6ZHE5UN574K8Z7X8_ast;
run;
