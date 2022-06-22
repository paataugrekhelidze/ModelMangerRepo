*------------------------------------------------------------*;
* Macro Variables for input, output data and files;
  %let dm_datalib       =;                 /* Libref associated with the CAS training table */
  %let dm_output_lib    = &dm_datalib;     /* Libref associated with the output CAS tables */
  %let dm_data_caslib   =;                 /* CASLIB associated with the training table */
  %let dm_output_caslib = &dm_data_caslib; /* CASLIB associated with the output tables */
  %let dm_inputTable=;  /* Input Table */
  %let dm_memName=_input_B87L1L3JSYL8TIOR6SJ4C0NYE;
  %let dm_memNameNLit='_input_B87L1L3JSYL8TIOR6SJ4C0NYE'n;
  %let dm_lib     = WORK;
  %let dm_folder  = %sysfunc(pathname(work));
*------------------------------------------------------------*;
*------------------------------------------------------------*;
  * Preparing the training data for modeling;
*------------------------------------------------------------*;
%macro dm_rejected;
'AMOUNT_MCC_DEV'n 'AUTH_ACCOUNT_ID'n 'AUTH_ADVICE'n 'AUTH_AMOUNT'n
'AUTH_AVAIL_CREDIT'n 'AUTH_CARD_EXP_DATE'n 'AUTH_CARD_ZIP3_DIFF'n
'AUTH_CRED_LINE'n 'AUTH_CVV'n 'AUTH_DATE'n 'AUTH_DECISION'n 'AUTH_KEY_SWIPE'n
'AUTH_MERCHANT_ID'n 'AUTH_MERCH_CNTRY'n 'AUTH_PIN_VER'n 'AUTH_REASON_CODE'n
'AUTH_TERM_ID'n 'AUTH_TRAIN_FLAG'n 'AUTH_TRAN_TYPE'n 'AUTH_WHICH_CARD'n
'AUTH_ZIP3_CODE'n 'AUTH_ZIP_REST_CODE'n 'BIN_AUTH_ADVICE'n
'BIN_AUTH_TRAN_TYPE'n 'BIN_CARD_NUM_CARDS'n 'CARD_CRED_LINE'n
'CARD_EXPIRE_DATE'n 'CARD_NUM_CARDS'n 'CARD_OPEN_DATE'n 'CARD_REC_DATE'n
'CARD_ZIP3_CODE'n 'city'n 'daily_count'n 'daily_sum'n 'EXT_AUTH_BIN'n
'EXT_AUTH_DAY'n 'EXT_AUTH_MONTH'n 'EXT_AUTH_YEAR'n 'FRAUD_DATE_FIRST_FRAUD'n
'FRAUD_DETECTED_DATE'n 'FRAUD_STAGE'n 'FRAUD_TYPE'n 'INVSQRT_AMOUNT_MCC_DEV'n
'INV_AUTH_CARD_ZIP3_DIFF'n 'INV_MCC_RISK'n 'mcc'n 'MCC_RISK'n 'padzip'n
'sev_2500_to_5000'n 'sev_ge_5000'n 'SQRT_CARD_CRED_LINE'n 'state'n
'TRANSACTION_ID'n 'txtCode'n 'txtDesc'n 'weekly_count'n 'weekly_sum'n 'year'n
%mend dm_rejected;
%global dm_num_rejected;
%let dm_num_rejected = 58 ;

data &dm_datalib..&dm_memname/ SESSREF=&_SESSREF_;
   set &dm_datalib..&dm_inputTable;

* Transformation Method = INVSQRT ;
Label 'INVSQRT_AMOUNT_MCC_DEV'n = 'Transformed AMOUNT_MCC_DEV';
Length 'INVSQRT_AMOUNT_MCC_DEV'n 8;
if missing('AMOUNT_MCC_DEV'n) or ('AMOUNT_MCC_DEV'n + 3.12 <= 0) then 'INVSQRT_AMOUNT_MCC_DEV'n = .;
else 'INVSQRT_AMOUNT_MCC_DEV'n = 1/(SQRT('AMOUNT_MCC_DEV'n + 3.12));

* Transformation Method = BINRARE ;
Length 'BIN_AUTH_ADVICE'n $ 9;
Label 'BIN_AUTH_ADVICE'n = 'Transformed AUTH_ADVICE';
if missing('AUTH_ADVICE'n) then
   'BIN_AUTH_ADVICE'n = '_MISSING_';
else do;
   Length _bintmp3 $3;
   drop _bintmp3; _bintmp3='';
   _bintmp3 = ktrim(put('AUTH_ADVICE'n, $CHAR3.));
   if _bintmp3 IN( 'A'
   ) then
      'BIN_AUTH_ADVICE'n = '_OTHER_';
   else 'BIN_AUTH_ADVICE'n = _bintmp3;
end;

* Transformation Method = LOG ;
Label 'LOG_AUTH_AMOUNT'n = 'Transformed AUTH_AMOUNT';
Length 'LOG_AUTH_AMOUNT'n 8;
if missing('AUTH_AMOUNT'n) or ('AUTH_AMOUNT'n + 1 <= 0) then 'LOG_AUTH_AMOUNT'n = .;
else 'LOG_AUTH_AMOUNT'n = log('AUTH_AMOUNT'n + 1);

* Transformation Method = LOG ;
Label 'LOG_AUTH_AVAIL_CREDIT'n = 'Transformed AUTH_AVAIL_CREDIT';
Length 'LOG_AUTH_AVAIL_CREDIT'n 8;
if missing('AUTH_AVAIL_CREDIT'n) or ('AUTH_AVAIL_CREDIT'n + 2935 <= 0) then 'LOG_AUTH_AVAIL_CREDIT'n = .;
else 'LOG_AUTH_AVAIL_CREDIT'n = log('AUTH_AVAIL_CREDIT'n + 2935);

* Transformation Method = INVERSE ;
Label 'INV_AUTH_CARD_ZIP3_DIFF'n = 'Transformed AUTH_CARD_ZIP3_DIFF';
Length 'INV_AUTH_CARD_ZIP3_DIFF'n 8;
if missing('AUTH_CARD_ZIP3_DIFF'n) then 'INV_AUTH_CARD_ZIP3_DIFF'n = .;
else if 'AUTH_CARD_ZIP3_DIFF'n >= 0 then 'INV_AUTH_CARD_ZIP3_DIFF'n = 1/('AUTH_CARD_ZIP3_DIFF'n + 1);
else 'INV_AUTH_CARD_ZIP3_DIFF'n = 1/('AUTH_CARD_ZIP3_DIFF'n - 1);

* Transformation Method = SQRT ;
Label 'SQRT_AUTH_CRED_LINE'n = 'Transformed AUTH_CRED_LINE';
Length 'SQRT_AUTH_CRED_LINE'n 8;
if missing('AUTH_CRED_LINE'n) or ('AUTH_CRED_LINE'n + 1 <= 0) then 'SQRT_AUTH_CRED_LINE'n = .;
else 'SQRT_AUTH_CRED_LINE'n = SQRT('AUTH_CRED_LINE'n + 1);

* Transformation Method = BINRARE ;
Length 'BIN_AUTH_TRAN_TYPE'n $ 9;
Label 'BIN_AUTH_TRAN_TYPE'n = 'Transformed AUTH_TRAN_TYPE';
if missing('AUTH_TRAN_TYPE'n) then
   'BIN_AUTH_TRAN_TYPE'n = '_MISSING_';
else do;
   Length _bintmp3 $3;
   drop _bintmp3; _bintmp3='';
   _bintmp3 = ktrim(put('AUTH_TRAN_TYPE'n, $CHAR3.));
   if _bintmp3 IN( 'S'
   ) then
      'BIN_AUTH_TRAN_TYPE'n = '_OTHER_';
   else 'BIN_AUTH_TRAN_TYPE'n = _bintmp3;
end;

* Transformation Method = SQRT ;
Label 'SQRT_CARD_CRED_LINE'n = 'Transformed CARD_CRED_LINE';
Length 'SQRT_CARD_CRED_LINE'n 8;
if missing('CARD_CRED_LINE'n) or ('CARD_CRED_LINE'n + 1 <= 0) then 'SQRT_CARD_CRED_LINE'n = .;
else 'SQRT_CARD_CRED_LINE'n = SQRT('CARD_CRED_LINE'n + 1);

* Transformation Method = BINRARE ;
Length 'BIN_CARD_NUM_CARDS'n $ 12;
Label 'BIN_CARD_NUM_CARDS'n = 'Transformed CARD_NUM_CARDS';
if missing('CARD_NUM_CARDS'n) then
   'BIN_CARD_NUM_CARDS'n = '_MISSING_';
else do;
   Length _bintmp12 $12;
   drop _bintmp12; _bintmp12='';
   _bintmp12 = kstrip(put('CARD_NUM_CARDS'n, BEST12.));
   if _bintmp12 IN( '0'
               , '5'
               , '6'
               , '7'
               , '8'
               , '9'
               , '10'
               , '11'
   ) then
      'BIN_CARD_NUM_CARDS'n = '_OTHER_';
   else 'BIN_CARD_NUM_CARDS'n = _bintmp12;
end;

* Transformation Method = INVERSE ;
Label 'INV_MCC_RISK'n = 'Transformed MCC_RISK';
Length 'INV_MCC_RISK'n 8;
if missing('MCC_RISK'n) then 'INV_MCC_RISK'n = .;
else if 'MCC_RISK'n >= 0 then 'INV_MCC_RISK'n = 1/('MCC_RISK'n + 1);
else 'INV_MCC_RISK'n = 1/('MCC_RISK'n - 1);

* Transformation Method = INVSQUARE ;
Label 'INVSQR_daily_count'n = 'Transformed daily_count';
Length 'INVSQR_daily_count'n 8;
if missing('daily_count'n) then 'INVSQR_daily_count'n = .;
else 'INVSQR_daily_count'n = 1/(('daily_count'n**2) + 1);

* Transformation Method = LOG ;
Label 'LOG_daily_sum'n = 'Transformed daily_sum';
Length 'LOG_daily_sum'n 8;
if missing('daily_sum'n) or ('daily_sum'n + 1 <= 0) then 'LOG_daily_sum'n = .;
else 'LOG_daily_sum'n = log('daily_sum'n + 1);

* Transformation Method = INVSQUARE ;
Label 'INVSQR_weekly_count'n = 'Transformed weekly_count';
Length 'INVSQR_weekly_count'n 8;
if missing('weekly_count'n) then 'INVSQR_weekly_count'n = .;
else 'INVSQR_weekly_count'n = 1/(('weekly_count'n**2) + 1);

* Transformation Method = LOG ;
Label 'LOG_weekly_sum'n = 'Transformed weekly_sum';
Length 'LOG_weekly_sum'n 8;
if missing('weekly_sum'n) or ('weekly_sum'n + 1 <= 0) then 'LOG_weekly_sum'n = .;
else 'LOG_weekly_sum'n = log('weekly_sum'n + 1);


/* Transformation Method = TARGETENCODE */
Length 'TARGENC_AUTH_CVV'n 8;
Label 'TARGENC_AUTH_CVV'n = 'Transformed AUTH_CVV';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = ktrim(put('AUTH_CVV'n,$CHAR3.));
select (_val_66750976);
 when ( ' ' )
    'TARGENC_AUTH_CVV'n = 0.1323492159;
 when ( 'I' )
    'TARGENC_AUTH_CVV'n = 0.3620689655;
 when ( 'V' )
    'TARGENC_AUTH_CVV'n = 0.0865576901;
 otherwise
    'TARGENC_AUTH_CVV'n = 0.1031242251;
end;

/* Transformation Method = TARGETENCODE */
Length 'TARGENC_AUTH_KEY_SWIPE'n 8;
Label 'TARGENC_AUTH_KEY_SWIPE'n = 'Transformed AUTH_KEY_SWIPE';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = ktrim(put('AUTH_KEY_SWIPE'n,$CHAR3.));
select (_val_66750976);
 when ( ' ' )
    'TARGENC_AUTH_KEY_SWIPE'n = 0.3100929615;
 when ( 'K' )
    'TARGENC_AUTH_KEY_SWIPE'n = 0.1280709357;
 when ( 'S' )
    'TARGENC_AUTH_KEY_SWIPE'n = 0.1050694527;
 when ( 'U' )
    'TARGENC_AUTH_KEY_SWIPE'n = 0.0898448101;
 otherwise
    'TARGENC_AUTH_KEY_SWIPE'n = 0.1031242251;
end;

/* Transformation Method = TARGETENCODE */
Length 'TARGENC_AUTH_PIN_VER'n 8;
Label 'TARGENC_AUTH_PIN_VER'n = 'Transformed AUTH_PIN_VER';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = ktrim(put('AUTH_PIN_VER'n,$CHAR3.));
select (_val_66750976);
 when ( ' ' )
    'TARGENC_AUTH_PIN_VER'n = 0.1071154899;
 when ( 'I' )
    'TARGENC_AUTH_PIN_VER'n = 0.1950828434;
 when ( 'V' )
    'TARGENC_AUTH_PIN_VER'n = 0.0970470696;
 otherwise
    'TARGENC_AUTH_PIN_VER'n = 0.1031242251;
end;

/* Transformation Method = TARGETENCODE */
Length 'TARGENC_BIN_AUTH_ADVICE'n 8;
Label 'TARGENC_BIN_AUTH_ADVICE'n = 'Transformed Transformed AUTH_ADVICE';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = ktrim(put('BIN_AUTH_ADVICE'n,$CHAR9.));
select (_val_66750976);
 when ( '_MISSING_' )
    'TARGENC_BIN_AUTH_ADVICE'n = 0.0697212994;
 when ( '_OTHER_' )
    'TARGENC_BIN_AUTH_ADVICE'n = 0.1111111111;
 when ( 'N' )
    'TARGENC_BIN_AUTH_ADVICE'n = 0.1110780073;
 when ( 'Y' )
    'TARGENC_BIN_AUTH_ADVICE'n = 0.0775862069;
 otherwise
    'TARGENC_BIN_AUTH_ADVICE'n = 0.1031242251;
end;

/* Transformation Method = TARGETENCODE */
Length 'TARGENC_BIN_AUTH_TRAN_TYPE'n 8;
Label 'TARGENC_BIN_AUTH_TRAN_TYPE'n = 'Transformed Transformed AUTH_TRAN_TYPE';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = ktrim(put('BIN_AUTH_TRAN_TYPE'n,$CHAR9.));
select (_val_66750976);
 when ( '_MISSING_' )
    'TARGENC_BIN_AUTH_TRAN_TYPE'n = 0;
 when ( '_OTHER_' )
    'TARGENC_BIN_AUTH_TRAN_TYPE'n = 0.6666666667;
 when ( 'A' )
    'TARGENC_BIN_AUTH_TRAN_TYPE'n = 0.1418812401;
 when ( 'C' )
    'TARGENC_BIN_AUTH_TRAN_TYPE'n = 0.254873359;
 when ( 'M' )
    'TARGENC_BIN_AUTH_TRAN_TYPE'n = 0.0932488218;
 when ( 'V' )
    'TARGENC_BIN_AUTH_TRAN_TYPE'n = 0.0356445313;
 otherwise
    'TARGENC_BIN_AUTH_TRAN_TYPE'n = 0.1031242251;
end;

/* Transformation Method = TARGETENCODE */
Length 'TARGENC_BIN_CARD_NUM_CARDS'n 8;
Label 'TARGENC_BIN_CARD_NUM_CARDS'n = 'Transformed Transformed CARD_NUM_CARDS';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = ktrim(put('BIN_CARD_NUM_CARDS'n,$CHAR12.));
select (_val_66750976);
 when ( '_MISSING_' )
    'TARGENC_BIN_CARD_NUM_CARDS'n = 0.1745253495;
 when ( '_OTHER_' )
    'TARGENC_BIN_CARD_NUM_CARDS'n = 0.0712328767;
 when ( '1' )
    'TARGENC_BIN_CARD_NUM_CARDS'n = 0.1087112751;
 when ( '2' )
    'TARGENC_BIN_CARD_NUM_CARDS'n = 0.0845167294;
 when ( '3' )
    'TARGENC_BIN_CARD_NUM_CARDS'n = 0.100933126;
 when ( '4' )
    'TARGENC_BIN_CARD_NUM_CARDS'n = 0.102027027;
 otherwise
    'TARGENC_BIN_CARD_NUM_CARDS'n = 0.1031242251;
end;

/* Transformation Method = TARGETENCODE */
Length 'TARGENC_CARD_TYPE'n 8;
Label 'TARGENC_CARD_TYPE'n = 'Transformed CARD_TYPE';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = ktrim(put('CARD_TYPE'n,$CHAR3.));
select (_val_66750976);
 when ( ' ' )
    'TARGENC_CARD_TYPE'n = 0.15089688;
 when ( 'G' )
    'TARGENC_CARD_TYPE'n = 0.1078650461;
 when ( 'S' )
    'TARGENC_CARD_TYPE'n = 0.0929783685;
 otherwise
    'TARGENC_CARD_TYPE'n = 0.1031242251;
end;

/* Transformation Method = TARGETENCODE */
Length 'TARGENC_sev_2500_to_5000'n 8;
Label 'TARGENC_sev_2500_to_5000'n = 'Transformed sev_2500_to_5000';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = kstrip(put('sev_2500_to_5000'n,BEST12.));
select (_val_66750976);
 when ( '0' )
    'TARGENC_sev_2500_to_5000'n = 0.1028693074;
 when ( '1' )
    'TARGENC_sev_2500_to_5000'n = 0.2196969697;
 otherwise
    'TARGENC_sev_2500_to_5000'n = 0.1031242251;
end;

/* Transformation Method = TARGETENCODE */
Length 'TARGENC_sev_ge_5000'n 8;
Label 'TARGENC_sev_ge_5000'n = 'Transformed sev_ge_5000';
Length _val_66750976 $12;
Drop _val_66750976;
_val_66750976 = kstrip(put('sev_ge_5000'n,BEST12.));
select (_val_66750976);
 when ( '0' )
    'TARGENC_sev_ge_5000'n = 0.1030967048;
 when ( '1' )
    'TARGENC_sev_ge_5000'n = 0.1636363636;
 otherwise
    'TARGENC_sev_ge_5000'n = 0.1031242251;
end;


* Imputation Method = MEDIAN ;
Label 'IMP_INVSQRT_AMOUNT_MCC_DEV'n = 'Imputed Transformed AMOUNT_MCC_DEV';
Length 'IMP_INVSQRT_AMOUNT_MCC_DEV'n 8;
if missing('INVSQRT_AMOUNT_MCC_DEV'n) then do;
   'IMP_INVSQRT_AMOUNT_MCC_DEV'n = 0.5792844464;
end;
else 'IMP_INVSQRT_AMOUNT_MCC_DEV'n = 'INVSQRT_AMOUNT_MCC_DEV'n;

* Imputation Method = MEDIAN ;
Label 'IMP_INV_AUTH_CARD_ZIP3_DIFF'n = 'Imputed Transformed AUTH_CARD_ZIP3_DIFF';
Length 'IMP_INV_AUTH_CARD_ZIP3_DIFF'n 8;
if missing('INV_AUTH_CARD_ZIP3_DIFF'n) then do;
   'IMP_INV_AUTH_CARD_ZIP3_DIFF'n = 0.5;
end;
else 'IMP_INV_AUTH_CARD_ZIP3_DIFF'n = 'INV_AUTH_CARD_ZIP3_DIFF'n;

* Imputation Method = MEDIAN ;
Label 'IMP_INV_MCC_RISK'n = 'Imputed Transformed MCC_RISK';
Length 'IMP_INV_MCC_RISK'n 8;
if missing('INV_MCC_RISK'n) then do;
   'IMP_INV_MCC_RISK'n = 0.8928571429;
end;
else 'IMP_INV_MCC_RISK'n = 'INV_MCC_RISK'n;

* Imputation Method = MEDIAN ;
Label 'IMP_SQRT_CARD_CRED_LINE'n = 'Imputed Transformed CARD_CRED_LINE';
Length 'IMP_SQRT_CARD_CRED_LINE'n 8;
if missing('SQRT_CARD_CRED_LINE'n) then do;
   'IMP_SQRT_CARD_CRED_LINE'n = 86.608313689;
end;
else 'IMP_SQRT_CARD_CRED_LINE'n = 'SQRT_CARD_CRED_LINE'n;

* Missing value indicator for AUTH_CURR_RATE ;
Label 'M_AUTH_CURR_RATE'n = 'Missing Indicator for AUTH_CURR_RATE';
Length 'M_AUTH_CURR_RATE'n 8 ;
if missing('AUTH_CURR_RATE'n) then
   'M_AUTH_CURR_RATE'n = 1;
else
   'M_AUTH_CURR_RATE'n = 0;

* Missing value indicator for CARD_USE ;
Label 'M_CARD_USE'n = 'Missing Indicator for CARD_USE';
Length 'M_CARD_USE'n 8 ;
if missing('CARD_USE'n) then
   'M_CARD_USE'n = 1;
else
   'M_CARD_USE'n = 0;

* Missing value indicator for INVSQRT_AMOUNT_MCC_DEV ;
Label 'M_INVSQRT_AMOUNT_MCC_DEV'n = 'Missing Indicator for INVSQRT_AMOUNT_MCC_DEV';
Length 'M_INVSQRT_AMOUNT_MCC_DEV'n 8 ;
if missing('INVSQRT_AMOUNT_MCC_DEV'n) then
   'M_INVSQRT_AMOUNT_MCC_DEV'n = 1;
else
   'M_INVSQRT_AMOUNT_MCC_DEV'n = 0;

* Missing value indicator for INV_AUTH_CARD_ZIP3_DIFF ;
Label 'M_INV_AUTH_CARD_ZIP3_DIFF'n = 'Missing Indicator for INV_AUTH_CARD_ZIP3_DIFF';
Length 'M_INV_AUTH_CARD_ZIP3_DIFF'n 8 ;
if missing('INV_AUTH_CARD_ZIP3_DIFF'n) then
   'M_INV_AUTH_CARD_ZIP3_DIFF'n = 1;
else
   'M_INV_AUTH_CARD_ZIP3_DIFF'n = 0;

* Missing value indicator for INV_MCC_RISK ;
Label 'M_INV_MCC_RISK'n = 'Missing Indicator for INV_MCC_RISK';
Length 'M_INV_MCC_RISK'n 8 ;
if missing('INV_MCC_RISK'n) then
   'M_INV_MCC_RISK'n = 1;
else
   'M_INV_MCC_RISK'n = 0;

* Missing value indicator for SQRT_CARD_CRED_LINE ;
Label 'M_SQRT_CARD_CRED_LINE'n = 'Missing Indicator for SQRT_CARD_CRED_LINE';
Length 'M_SQRT_CARD_CRED_LINE'n 8 ;
if missing('SQRT_CARD_CRED_LINE'n) then
   'M_SQRT_CARD_CRED_LINE'n = 1;
else
   'M_SQRT_CARD_CRED_LINE'n = 0;

   drop %dm_rejected;
run;
*------------------------------------------------------------*;
  * Training for forest;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
  * Initializing Variable Macros;
*------------------------------------------------------------*;
%macro dm_assessforbias;
'CARD_TYPE'n
%mend dm_assessforbias;
%global dm_num_assessforbias;
%let dm_num_assessforbias = 1 ;
%macro dm_unary_input;
'AUTH_CURR_RATE'n 'CARD_USE'n
%mend dm_unary_input;
%global dm_num_unary_input;
%let dm_num_unary_input = 2 ;
%macro dm_interval_input;
'AUTH_HOUR'n 'IMP_INVSQRT_AMOUNT_MCC_DEV'n 'IMP_INV_AUTH_CARD_ZIP3_DIFF'n
'IMP_INV_MCC_RISK'n 'IMP_SQRT_CARD_CRED_LINE'n 'INVSQR_daily_count'n
'INVSQR_weekly_count'n 'LOG_AUTH_AMOUNT'n 'LOG_AUTH_AVAIL_CREDIT'n
'LOG_daily_sum'n 'LOG_weekly_sum'n 'SQRT_AUTH_CRED_LINE'n 'TARGENC_AUTH_CVV'n
'TARGENC_AUTH_KEY_SWIPE'n 'TARGENC_AUTH_PIN_VER'n 'TARGENC_BIN_AUTH_ADVICE'n
'TARGENC_BIN_AUTH_TRAN_TYPE'n 'TARGENC_BIN_CARD_NUM_CARDS'n
'TARGENC_CARD_TYPE'n 'TARGENC_sev_2500_to_5000'n 'TARGENC_sev_ge_5000'n
'week_number'n
%mend dm_interval_input;
%global dm_num_interval_input;
%let dm_num_interval_input = 22 ;
%macro dm_binary_input;
'M_AUTH_CURR_RATE'n 'M_CARD_USE'n 'M_INVSQRT_AMOUNT_MCC_DEV'n
'M_INV_AUTH_CARD_ZIP3_DIFF'n 'M_INV_MCC_RISK'n 'M_SQRT_CARD_CRED_LINE'n
%mend dm_binary_input;
%global dm_num_binary_input;
%let dm_num_binary_input = 6 ;
%macro dm_nominal_input;
%mend dm_nominal_input;
%global dm_num_nominal_input;
%let dm_num_nominal_input = 0;
%macro dm_ordinal_input;
%mend dm_ordinal_input;
%global dm_num_ordinal_input;
%let dm_num_ordinal_input = 0;
%macro dm_class_input;
'M_AUTH_CURR_RATE'n 'M_CARD_USE'n 'M_INVSQRT_AMOUNT_MCC_DEV'n
'M_INV_AUTH_CARD_ZIP3_DIFF'n 'M_INV_MCC_RISK'n 'M_SQRT_CARD_CRED_LINE'n
%mend dm_class_input;
%global dm_num_class_input;
%let dm_num_class_input = 6 ;
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
'FRAUD_LABEL'n
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
proc forest data=&dm_datalib..&dm_memnameNlit(&dm_caslibOption)
     seed=12345 loh=0 binmethod=QUANTILE maxbranch=2 nomsearch(maxcategories=128)
     assignmissing=USEINSEARCH minuseinsearch=1
     ntrees=100
     maxdepth=20
     inbagfraction=0.6
     minleafsize=5
     numbin=50
     vote=PROBABILITY printtarget
  ;
  partition rolevar='_PartInd_'n (TRAIN='1' VALIDATE='0' TEST='2');
  target 'FRAUD_LABEL'n / level=nominal;
  input %dm_interval_input / level=interval;
  input %dm_binary_input %dm_nominal_input %dm_ordinal_input %dm_unary_input / level=nominal;
  grow IGR;
  savestate rstore=&dm_output_lib.._B87L1L3JSYL8TIOR6SJ4C0NYE_ast;
  ODS output
     VariableImportance = &dm_lib..varimportance  FitStatistics = &dm_data_outfit
     PredProbName = &dm_lib..PredProbName
     PredIntoName = &dm_lib..PredIntoName
  ;
run;
