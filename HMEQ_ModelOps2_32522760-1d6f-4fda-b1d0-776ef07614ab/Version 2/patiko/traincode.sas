*------------------------------------------------------------*;
* Macro Variables for input, output data and files;
  %let dm_datalib       =;                 /* Libref associated with the CAS training table */
  %let dm_output_lib    = &dm_datalib;     /* Libref associated with the output CAS tables */
  %let dm_data_caslib   =;                 /* CASLIB associated with the training table */
  %let dm_output_caslib = &dm_data_caslib; /* CASLIB associated with the output tables */
  %let dm_inputTable=;  /* Input Table */
  %let dm_memName=_input_9MQJE3ALZYLG7MV8HKBIVUR02;
  %let dm_memNameNLit='_input_9MQJE3ALZYLG7MV8HKBIVUR02'n;
  %let dm_lib     = WORK;
  %let dm_folder  = %sysfunc(pathname(work));
*------------------------------------------------------------*;
*------------------------------------------------------------*;
  * Preparing the training data for modeling;
*------------------------------------------------------------*;
%macro dm_rejected;
'CLAGE'n 'CLNO'n 'DEBTINC'n 'DELINQ'n 'DEROG'n 'IMP_CLNO'n 'IMP_MORTDUE'n
   'JOB'n 'MORTDUE'n 'NINQ'n 'REASON'n 'VALUE'n 'YOJ'n
%mend dm_rejected;

data &dm_datalib..&dm_memname/ SESSREF=&_SESSREF_;
   set &dm_datalib..&dm_inputTable;

* Imputation Method = MEAN ;
Label 'IMP_CLAGE'n = 'Imputed CLAGE';
Length 'IMP_CLAGE'n 8;
if missing('CLAGE'n) then do;
   'IMP_CLAGE'n = 180.06572076;
end;
else 'IMP_CLAGE'n = 'CLAGE'n;

* Imputation Method = MEAN ;
Label 'IMP_CLNO'n = 'Imputed CLNO';
Length 'IMP_CLNO'n 8;
if missing('CLNO'n) then do;
   'IMP_CLNO'n = 21.413983174;
end;
else 'IMP_CLNO'n = 'CLNO'n;

* Imputation Method = MEAN ;
Label 'IMP_DEBTINC'n = 'Imputed DEBTINC';
Length 'IMP_DEBTINC'n 8;
if missing('DEBTINC'n) then do;
   'IMP_DEBTINC'n = 33.702060536;
end;
else 'IMP_DEBTINC'n = 'DEBTINC'n;

* Imputation Method = COUNT ;
Label 'IMP_DELINQ'n = 'Imputed DELINQ';
Length 'IMP_DELINQ'n 8;
if missing('DELINQ'n) then do;
   'IMP_DELINQ'n = 0;
end;
else 'IMP_DELINQ'n = 'DELINQ'n;

* Imputation Method = COUNT ;
Label 'IMP_DEROG'n = 'Imputed DEROG';
Length 'IMP_DEROG'n 8;
if missing('DEROG'n) then do;
   'IMP_DEROG'n = 0;
end;
else 'IMP_DEROG'n = 'DEROG'n;

* Imputation Method = COUNT ;
Label 'IMP_JOB'n = 'Imputed JOB';
Length 'IMP_JOB'n $7;
if missing('JOB'n) then do;
   'IMP_JOB'n = 'Other';
end;
else 'IMP_JOB'n = 'JOB'n;

* Imputation Method = MEAN ;
Label 'IMP_MORTDUE'n = 'Imputed MORTDUE';
Length 'IMP_MORTDUE'n 8;
if missing('MORTDUE'n) then do;
   'IMP_MORTDUE'n = 74833.24575;
end;
else 'IMP_MORTDUE'n = 'MORTDUE'n;

* Imputation Method = COUNT ;
Label 'IMP_NINQ'n = 'Imputed NINQ';
Length 'IMP_NINQ'n 8;
if missing('NINQ'n) then do;
   'IMP_NINQ'n = 0;
end;
else 'IMP_NINQ'n = 'NINQ'n;

* Imputation Method = COUNT ;
Label 'IMP_REASON'n = 'Imputed REASON';
Length 'IMP_REASON'n $7;
if missing('REASON'n) then do;
   'IMP_REASON'n = 'DebtCon';
end;
else 'IMP_REASON'n = 'REASON'n;

* Imputation Method = MEAN ;
Label 'IMP_YOJ'n = 'Imputed YOJ';
Length 'IMP_YOJ'n 8;
if missing('YOJ'n) then do;
   'IMP_YOJ'n = 9.0018179041;
end;
else 'IMP_YOJ'n = 'YOJ'n;

   drop %dm_rejected;
run;
*------------------------------------------------------------*;
  * Training for tree;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
  * Initializing Variable Macros;
*------------------------------------------------------------*;
%macro dm_unary_input;
%mend dm_unary_input;
%global dm_num_unary_input;
%let dm_num_unary_input = 0;
%macro dm_interval_input;
   'IMP_CLAGE'n 'IMP_DEBTINC'n 'IMP_YOJ'n 'LOAN'n
%mend dm_interval_input;
%global dm_num_interval_input;
%let dm_num_interval_input = 4 ;
%macro dm_binary_input;
   'IMP_REASON'n
%mend dm_binary_input;
%global dm_num_binary_input;
%let dm_num_binary_input = 1 ;
%macro dm_nominal_input;
   'IMP_DELINQ'n 'IMP_DEROG'n 'IMP_JOB'n 'IMP_NINQ'n
%mend dm_nominal_input;
%global dm_num_nominal_input;
%let dm_num_nominal_input = 4 ;
%macro dm_ordinal_input;
%mend dm_ordinal_input;
%global dm_num_ordinal_input;
%let dm_num_ordinal_input = 0;
%macro dm_class_input;
   'IMP_DELINQ'n 'IMP_DEROG'n 'IMP_JOB'n 'IMP_NINQ'n 'IMP_REASON'n
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
   'BAD'n
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
proc treesplit data=&dm_datalib..&dm_memnameNlit(&dm_caslibOption)
     minleafsize=5
     nsurrogates=0 maxbranch=2 assignmissing=USEINSEARCH binmethod=QUANTILE nomsearch(maxcategories=128)
     minuseinsearch=1
     pruningtable
     seed=12345
     outmodel=&dm_output_lib.._9MQJE3ALZYLG7MV8HKBIVUR02_model treeplot printtarget;
  autotune useparameters=CUSTOM tuningparameters=(
     maxdepth(LB=1 UB=19 INIT=10)
     numbin(LB=20 UB=200 INIT=50)
     criterion(VALUES=ENTROPY CHAID IGR GINI CHISQUARE INIT=ENTROPY)
     )
     searchmethod=GA objective=KS maxtime=3600
     maxevals=50 maxiters=5 popsize=10
     targetevent='1'
  ;
  target 'BAD'n / level=nominal;
  input %dm_interval_input / level=interval;
  input %dm_binary_input %dm_nominal_input %dm_ordinal_input %dm_unary_input / level=nominal;
  partition rolevar='_PartInd_'n (TRAIN='1' VALIDATE='0' TEST='2');
  prune costcomplexity;
  code file="&dm_file_scorecode." nocomppgm labelid=05012850;
  ods output
     CostComplexity = &dm_lib..pruning
     VariableImportance = &dm_lib..varimportance TreePlotTable = &dm_lib..treeplot TreePerformance = &dm_lib..TreePerf
     PredProbName = &dm_lib..PredProbName
     PredIntoName = &dm_lib..PredIntoName
     TunerResults = &dm_lib..tuneresults BestConfiguration = &dm_lib..tunebest(drop=name)
  ;
  ods exclude treeplottable OutputCasTables;
run;
