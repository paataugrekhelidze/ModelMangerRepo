/* create ds2 package */ 
/* use fileURI to retrieve score.xml */ 
filename orixml filesrvc '/files/files/1c041941-764c-4857-8912-f7bbcf7fb3b8' lrecl=32767 encoding='utf-8'; 
filename scrxml temp lrecl=32767 encoding='utf-8'; 
data _null_; 
rc = fcopy('orixml','scrxml'); 
if rc=0 then 
putlog 'NOTE: Copying file from File Service.' ; 
else do; 
msg=sysmsg(); 
putlog msg; 
end; 
run; 
proc dstrans dsi_to_ds2 out=ds2pkg xml=scrxml pkgargs nocomp; 
submit; 
/*----------------------------------------------------------------------------------*/
/* Product:            Visual Data Mining and Machine Learning                      */
/* Release Version:    V2020.1.4                                                    */
/* Component Version:  V2020.1.4                                                    */
/* CAS Version:        V.04.00M0P03042021                                           */
/* SAS Version:        V.04.00M0P030421                                             */
/* Site Number:        70180938                                                     */
/* Host:               sas-cas-server-default-client                                */
/* Encoding:           utf-8                                                        */
/* Java Encoding:      UTF8                                                         */
/* Locale:             en_US                                                        */
/* Project GUID:       1bc33459-9156-4dc9-8add-cdb099fede20                         */
/* Node GUID:          a2b068db-d36e-48ad-93ac-b0615e839b32                         */
/* Node Id:            9MQJE3ALZYLG7MV8HKBIVUR02                                    */
/* Algorithm:          Decision Tree                                                */
/* Generated by:       sasadm                                                       */
/* Date:               08MAR2021:21:55:23                                           */
/*----------------------------------------------------------------------------------*/
*------------------------------------------------------------*;
*Nodeid: _3RVR68WPXKF7Z5LEP6GOKERIG;
*------------------------------------------------------------*;

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

*------------------------------------------------------------*;
*Nodeid: _27RAQUA700WBD49DFXMUCN8WL;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
*Nodeid: _EIF8MWZM62YMJGR9HTF6175MI;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
*Nodeid: _9MQJE3ALZYLG7MV8HKBIVUR02;
*------------------------------------------------------------*;
   length _strfmt_ $12; drop _strfmt_;
   _strfmt_ = ' ';

   array _tlevname_5012850_{2} $12 _temporary_ ( '           1'
   '           0');

   array _dt_fi_5012850_{2} _temporary_;

   _node_id_ =  0;
   _new_id_  = -1;
   nextnode_5012850:
   if _node_id_ eq 0 then do;
         _strfmt_ = left(trim(put(IMP_DELINQ,BEST12.)));
         if _strfmt_ in ('12',
         '15',
         '5',
         '4',
         '7',
         '6',
         '1',
         '3',
         '2',
         '8') then do;

         _new_id_ = 1;
         end;
         else if _strfmt_ in ('0') then do;

         _new_id_ = 2;
         end;
         else do;
         _new_id_ = 2;
         end;
   end;
   else if _node_id_ eq 1 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 3;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 33.7622401663464) then do;

            _new_id_ = 3;
         end;
         else if (_numval_ ge 33.7622401663464 and _numval_ lt 203.31214869) then do;

            _new_id_ = 4;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 3;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 4;
         end;
         else do;
         _new_id_ = 3;
         end;
   end;
   else if _node_id_ eq 2 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 6;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 33.6705273399606) then do;

            _new_id_ = 5;
         end;
         else if (_numval_ ge 33.6705273399606 and _numval_ lt 203.31214869) then do;

            _new_id_ = 6;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 5;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 6;
         end;
         else do;
         _new_id_ = 6;
         end;
   end;
   else if _node_id_ eq 3 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 8;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 33.4934797649212) then do;

            _new_id_ = 7;
         end;
         else if (_numval_ ge 33.4934797649212 and _numval_ lt 203.31214869) then do;

            _new_id_ = 8;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 7;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 8;
         end;
         else do;
         _new_id_ = 8;
         end;
   end;
   else if _node_id_ eq 4 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _numval_ = -1.7976931348623E308;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 43.9169958330393) then do;

            _new_id_ = 9;
         end;
         else if (_numval_ ge 43.9169958330393 and _numval_ lt 203.31214869) then do;

            _new_id_ = 10;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 9;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 10;
         end;
         else do;
         _new_id_ = 9;
         end;
   end;
   else if _node_id_ eq 5 then do;
         _leaf_id_ = 5;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.95742667928098;
         _dt_fi_5012850_{1} =     0.04257332071901;
         _dt_fi_5012850_{2} =     0.95742667928098;
   end;
   else if _node_id_ eq 6 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 12;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 33.7622401663464) then do;

            _new_id_ = 11;
         end;
         else if (_numval_ ge 33.7622401663464 and _numval_ lt 203.31214869) then do;

            _new_id_ = 12;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 11;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 12;
         end;
         else do;
         _new_id_ = 12;
         end;
   end;
   else if _node_id_ eq 7 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _numval_ = -1.7976931348623E308;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 12.4081538974724) then do;

            _new_id_ = 13;
         end;
         else if (_numval_ ge 12.4081538974724 and _numval_ lt 203.31214869) then do;

            _new_id_ = 14;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 13;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 14;
         end;
         else do;
         _new_id_ = 14;
         end;
   end;
   else if _node_id_ eq 8 then do;
         _leaf_id_ = 8;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =     0.81227436823104;
         _dt_fi_5012850_{1} =     0.81227436823104;
         _dt_fi_5012850_{2} =     0.18772563176895;
   end;
   else if _node_id_ eq 9 then do;
         _strfmt_ = left(trim(put(IMP_DELINQ,BEST12.)));
         if _strfmt_ in ('4',
         '1',
         '3',
         '2') then do;

         _new_id_ = 15;
         end;
         else if _strfmt_ in ('7',
         '6',
         '8') then do;

         _new_id_ = 16;
         end;
         else do;
         _new_id_ = 15;
         end;
   end;
   else if _node_id_ eq 10 then do;
         _leaf_id_ = 10;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =                    1;
         _dt_fi_5012850_{1} =                    1;
         _dt_fi_5012850_{2} =                    0;
   end;
   else if _node_id_ eq 11 then do;
         _numval_ = IMP_CLAGE;
         if missing(_numval_) then do;
            _node_id_ = 17;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0 and _numval_ lt 186.996275468425) then do;

            _new_id_ = 17;
         end;
         else if (_numval_ ge 186.996275468425 and _numval_ lt 1168.2335609) then do;

            _new_id_ = 18;
         end;
         else if (_numval_ lt 0) then do;
            _new_id_ = 17;
         end;
         else if (_numval_ ge 1168.2335609) then do;
            _new_id_ = 18;
         end;
         else do;
         _new_id_ = 17;
         end;
   end;
   else if _node_id_ eq 12 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 19;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 43.9169958330393) then do;

            _new_id_ = 19;
         end;
         else if (_numval_ ge 43.9169958330393 and _numval_ lt 203.31214869) then do;

            _new_id_ = 20;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 19;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 20;
         end;
         else do;
         _new_id_ = 19;
         end;
   end;
   else if _node_id_ eq 13 then do;
         _leaf_id_ = 13;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =                    1;
         _dt_fi_5012850_{1} =                    1;
         _dt_fi_5012850_{2} =                    0;
   end;
   else if _node_id_ eq 14 then do;
         _leaf_id_ = 14;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.86046511627906;
         _dt_fi_5012850_{1} =     0.13953488372093;
         _dt_fi_5012850_{2} =     0.86046511627906;
   end;
   else if _node_id_ eq 15 then do;
         _leaf_id_ = 15;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.83464566929133;
         _dt_fi_5012850_{1} =     0.16535433070866;
         _dt_fi_5012850_{2} =     0.83464566929133;
   end;
   else if _node_id_ eq 16 then do;
         _leaf_id_ = 16;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =                    1;
         _dt_fi_5012850_{1} =                    1;
         _dt_fi_5012850_{2} =                    0;
   end;
   else if _node_id_ eq 17 then do;
         _leaf_id_ = 17;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =     0.57758620689655;
         _dt_fi_5012850_{1} =     0.57758620689655;
         _dt_fi_5012850_{2} =     0.42241379310344;
   end;
   else if _node_id_ eq 18 then do;
         _leaf_id_ = 18;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.68840579710144;
         _dt_fi_5012850_{1} =     0.31159420289855;
         _dt_fi_5012850_{2} =     0.68840579710144;
   end;
   else if _node_id_ eq 19 then do;
         _leaf_id_ = 19;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.94206349206349;
         _dt_fi_5012850_{1} =      0.0579365079365;
         _dt_fi_5012850_{2} =     0.94206349206349;
   end;
   else if _node_id_ eq 20 then do;
         _leaf_id_ = 20;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =                 0.75;
         _dt_fi_5012850_{1} =                 0.75;
         _dt_fi_5012850_{2} =                 0.25;
   end;
   if _new_id_ >= 0 then do;
       _node_id_ = _new_id_;
      goto nextnode_5012850;
   end;

   length I_BAD $12;
   I_BAD = _tlevname_5012850_{_dt_pred_lev_+1};
   label I_BAD = 'Into: BAD';
   _i_ = 1;
   _dt_predp_ = _dt_fi_5012850_{_i_};
   P_BAD1 = _dt_predp_;
   label P_BAD1 = 'Predicted: BAD=1';
   _i_+1;
   _dt_predp_ = _dt_fi_5012850_{_i_};
   P_BAD0 = _dt_predp_;
   label P_BAD0 = 'Predicted: BAD=0';
   _i_+1;
   drop _dt_predp_;
   drop _i_;
   drop _dt_pred_lev_;
   drop _dt_pred_prob_;
   drop _numval_;
   drop _node_id_;
   drop _new_id_;



   *------------------------------------------------------------*;
   * Initializing missing posterior and classification variables ;
   *------------------------------------------------------------*;
   label "P_BAD0"n ='Predicted: BAD=0';
   if "P_BAD0"n = . then "P_BAD0"n =0.8005033557;
   label "P_BAD1"n ='Predicted: BAD=1';
   if "P_BAD1"n = . then "P_BAD1"n =0.1994966443;
   label "I_BAD"n ='Into: BAD';
   if missing('I_BAD'n) then do;
      drop _P_;
      _P_= 0.0 ;
      if 'P_BAD1'n > _P_ then do;
      _P_ = 'P_BAD1'n;
      'I_BAD'n = '           1';
      end;
      if 'P_BAD0'n > _P_ then do;
      _P_ = 'P_BAD0'n;
      'I_BAD'n = '           0';
      end;
   end;
*------------------------------------------------------------*;
* Generating fixed output names;
*------------------------------------------------------------*;
Length EM_EVENTPROBABILITY 8;
LABEL EM_EVENTPROBABILITY = "Probability for BAD =1";
EM_EVENTPROBABILITY ='P_BAD1'n;
LENGTH EM_CLASSIFICATION $12;
LABEL EM_CLASSIFICATION= "Predicted for BAD";
EM_CLASSIFICATION ='I_BAD'n;
Length EM_PROBABILITY 8;
LABEL EM_PROBABILITY = "Probability of Classification";
EM_PROBABILITY = max(
'P_BAD1'n,
'P_BAD0'n);

endsubmit; 
run; 
proc dstrans dsi_to_ds2 out=ds2cd xml=scrxml ep nocomp; 
submit; 
/*----------------------------------------------------------------------------------*/
/* Product:            Visual Data Mining and Machine Learning                      */
/* Release Version:    V2020.1.4                                                    */
/* Component Version:  V2020.1.4                                                    */
/* CAS Version:        V.04.00M0P03042021                                           */
/* SAS Version:        V.04.00M0P030421                                             */
/* Site Number:        70180938                                                     */
/* Host:               sas-cas-server-default-client                                */
/* Encoding:           utf-8                                                        */
/* Java Encoding:      UTF8                                                         */
/* Locale:             en_US                                                        */
/* Project GUID:       1bc33459-9156-4dc9-8add-cdb099fede20                         */
/* Node GUID:          a2b068db-d36e-48ad-93ac-b0615e839b32                         */
/* Node Id:            9MQJE3ALZYLG7MV8HKBIVUR02                                    */
/* Algorithm:          Decision Tree                                                */
/* Generated by:       sasadm                                                       */
/* Date:               08MAR2021:21:55:23                                           */
/*----------------------------------------------------------------------------------*/
*------------------------------------------------------------*;
*Nodeid: _3RVR68WPXKF7Z5LEP6GOKERIG;
*------------------------------------------------------------*;

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

*------------------------------------------------------------*;
*Nodeid: _27RAQUA700WBD49DFXMUCN8WL;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
*Nodeid: _EIF8MWZM62YMJGR9HTF6175MI;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
*Nodeid: _9MQJE3ALZYLG7MV8HKBIVUR02;
*------------------------------------------------------------*;
   length _strfmt_ $12; drop _strfmt_;
   _strfmt_ = ' ';

   array _tlevname_5012850_{2} $12 _temporary_ ( '           1'
   '           0');

   array _dt_fi_5012850_{2} _temporary_;

   _node_id_ =  0;
   _new_id_  = -1;
   nextnode_5012850:
   if _node_id_ eq 0 then do;
         _strfmt_ = left(trim(put(IMP_DELINQ,BEST12.)));
         if _strfmt_ in ('12',
         '15',
         '5',
         '4',
         '7',
         '6',
         '1',
         '3',
         '2',
         '8') then do;

         _new_id_ = 1;
         end;
         else if _strfmt_ in ('0') then do;

         _new_id_ = 2;
         end;
         else do;
         _new_id_ = 2;
         end;
   end;
   else if _node_id_ eq 1 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 3;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 33.7622401663464) then do;

            _new_id_ = 3;
         end;
         else if (_numval_ ge 33.7622401663464 and _numval_ lt 203.31214869) then do;

            _new_id_ = 4;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 3;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 4;
         end;
         else do;
         _new_id_ = 3;
         end;
   end;
   else if _node_id_ eq 2 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 6;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 33.6705273399606) then do;

            _new_id_ = 5;
         end;
         else if (_numval_ ge 33.6705273399606 and _numval_ lt 203.31214869) then do;

            _new_id_ = 6;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 5;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 6;
         end;
         else do;
         _new_id_ = 6;
         end;
   end;
   else if _node_id_ eq 3 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 8;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 33.4934797649212) then do;

            _new_id_ = 7;
         end;
         else if (_numval_ ge 33.4934797649212 and _numval_ lt 203.31214869) then do;

            _new_id_ = 8;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 7;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 8;
         end;
         else do;
         _new_id_ = 8;
         end;
   end;
   else if _node_id_ eq 4 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _numval_ = -1.7976931348623E308;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 43.9169958330393) then do;

            _new_id_ = 9;
         end;
         else if (_numval_ ge 43.9169958330393 and _numval_ lt 203.31214869) then do;

            _new_id_ = 10;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 9;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 10;
         end;
         else do;
         _new_id_ = 9;
         end;
   end;
   else if _node_id_ eq 5 then do;
         _leaf_id_ = 5;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.95742667928098;
         _dt_fi_5012850_{1} =     0.04257332071901;
         _dt_fi_5012850_{2} =     0.95742667928098;
   end;
   else if _node_id_ eq 6 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 12;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 33.7622401663464) then do;

            _new_id_ = 11;
         end;
         else if (_numval_ ge 33.7622401663464 and _numval_ lt 203.31214869) then do;

            _new_id_ = 12;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 11;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 12;
         end;
         else do;
         _new_id_ = 12;
         end;
   end;
   else if _node_id_ eq 7 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _numval_ = -1.7976931348623E308;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 12.4081538974724) then do;

            _new_id_ = 13;
         end;
         else if (_numval_ ge 12.4081538974724 and _numval_ lt 203.31214869) then do;

            _new_id_ = 14;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 13;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 14;
         end;
         else do;
         _new_id_ = 14;
         end;
   end;
   else if _node_id_ eq 8 then do;
         _leaf_id_ = 8;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =     0.81227436823104;
         _dt_fi_5012850_{1} =     0.81227436823104;
         _dt_fi_5012850_{2} =     0.18772563176895;
   end;
   else if _node_id_ eq 9 then do;
         _strfmt_ = left(trim(put(IMP_DELINQ,BEST12.)));
         if _strfmt_ in ('4',
         '1',
         '3',
         '2') then do;

         _new_id_ = 15;
         end;
         else if _strfmt_ in ('7',
         '6',
         '8') then do;

         _new_id_ = 16;
         end;
         else do;
         _new_id_ = 15;
         end;
   end;
   else if _node_id_ eq 10 then do;
         _leaf_id_ = 10;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =                    1;
         _dt_fi_5012850_{1} =                    1;
         _dt_fi_5012850_{2} =                    0;
   end;
   else if _node_id_ eq 11 then do;
         _numval_ = IMP_CLAGE;
         if missing(_numval_) then do;
            _node_id_ = 17;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0 and _numval_ lt 186.996275468425) then do;

            _new_id_ = 17;
         end;
         else if (_numval_ ge 186.996275468425 and _numval_ lt 1168.2335609) then do;

            _new_id_ = 18;
         end;
         else if (_numval_ lt 0) then do;
            _new_id_ = 17;
         end;
         else if (_numval_ ge 1168.2335609) then do;
            _new_id_ = 18;
         end;
         else do;
         _new_id_ = 17;
         end;
   end;
   else if _node_id_ eq 12 then do;
         _numval_ = IMP_DEBTINC;
         if missing(_numval_) then do;
            _node_id_ = 19;
            goto nextnode_5012850;
         end;
         if (_numval_ ge 0.5244992154 and _numval_ lt 43.9169958330393) then do;

            _new_id_ = 19;
         end;
         else if (_numval_ ge 43.9169958330393 and _numval_ lt 203.31214869) then do;

            _new_id_ = 20;
         end;
         else if (_numval_ lt 0.5244992154) then do;
            _new_id_ = 19;
         end;
         else if (_numval_ ge 203.31214869) then do;
            _new_id_ = 20;
         end;
         else do;
         _new_id_ = 19;
         end;
   end;
   else if _node_id_ eq 13 then do;
         _leaf_id_ = 13;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =                    1;
         _dt_fi_5012850_{1} =                    1;
         _dt_fi_5012850_{2} =                    0;
   end;
   else if _node_id_ eq 14 then do;
         _leaf_id_ = 14;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.86046511627906;
         _dt_fi_5012850_{1} =     0.13953488372093;
         _dt_fi_5012850_{2} =     0.86046511627906;
   end;
   else if _node_id_ eq 15 then do;
         _leaf_id_ = 15;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.83464566929133;
         _dt_fi_5012850_{1} =     0.16535433070866;
         _dt_fi_5012850_{2} =     0.83464566929133;
   end;
   else if _node_id_ eq 16 then do;
         _leaf_id_ = 16;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =                    1;
         _dt_fi_5012850_{1} =                    1;
         _dt_fi_5012850_{2} =                    0;
   end;
   else if _node_id_ eq 17 then do;
         _leaf_id_ = 17;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =     0.57758620689655;
         _dt_fi_5012850_{1} =     0.57758620689655;
         _dt_fi_5012850_{2} =     0.42241379310344;
   end;
   else if _node_id_ eq 18 then do;
         _leaf_id_ = 18;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.68840579710144;
         _dt_fi_5012850_{1} =     0.31159420289855;
         _dt_fi_5012850_{2} =     0.68840579710144;
   end;
   else if _node_id_ eq 19 then do;
         _leaf_id_ = 19;
         _new_id_ = -1;
         _dt_pred_lev_ = 1;
         _dt_pred_prob_ =     0.94206349206349;
         _dt_fi_5012850_{1} =      0.0579365079365;
         _dt_fi_5012850_{2} =     0.94206349206349;
   end;
   else if _node_id_ eq 20 then do;
         _leaf_id_ = 20;
         _new_id_ = -1;
         _dt_pred_lev_ = 0;
         _dt_pred_prob_ =                 0.75;
         _dt_fi_5012850_{1} =                 0.75;
         _dt_fi_5012850_{2} =                 0.25;
   end;
   if _new_id_ >= 0 then do;
       _node_id_ = _new_id_;
      goto nextnode_5012850;
   end;

   length I_BAD $12;
   I_BAD = _tlevname_5012850_{_dt_pred_lev_+1};
   label I_BAD = 'Into: BAD';
   _i_ = 1;
   _dt_predp_ = _dt_fi_5012850_{_i_};
   P_BAD1 = _dt_predp_;
   label P_BAD1 = 'Predicted: BAD=1';
   _i_+1;
   _dt_predp_ = _dt_fi_5012850_{_i_};
   P_BAD0 = _dt_predp_;
   label P_BAD0 = 'Predicted: BAD=0';
   _i_+1;
   drop _dt_predp_;
   drop _i_;
   drop _dt_pred_lev_;
   drop _dt_pred_prob_;
   drop _numval_;
   drop _node_id_;
   drop _new_id_;



   *------------------------------------------------------------*;
   * Initializing missing posterior and classification variables ;
   *------------------------------------------------------------*;
   label "P_BAD0"n ='Predicted: BAD=0';
   if "P_BAD0"n = . then "P_BAD0"n =0.8005033557;
   label "P_BAD1"n ='Predicted: BAD=1';
   if "P_BAD1"n = . then "P_BAD1"n =0.1994966443;
   label "I_BAD"n ='Into: BAD';
   if missing('I_BAD'n) then do;
      drop _P_;
      _P_= 0.0 ;
      if 'P_BAD1'n > _P_ then do;
      _P_ = 'P_BAD1'n;
      'I_BAD'n = '           1';
      end;
      if 'P_BAD0'n > _P_ then do;
      _P_ = 'P_BAD0'n;
      'I_BAD'n = '           0';
      end;
   end;
*------------------------------------------------------------*;
* Generating fixed output names;
*------------------------------------------------------------*;
Length EM_EVENTPROBABILITY 8;
LABEL EM_EVENTPROBABILITY = "Probability for BAD =1";
EM_EVENTPROBABILITY ='P_BAD1'n;
LENGTH EM_CLASSIFICATION $12;
LABEL EM_CLASSIFICATION= "Predicted for BAD";
EM_CLASSIFICATION ='I_BAD'n;
Length EM_PROBABILITY 8;
LABEL EM_PROBABILITY = "Probability of Classification";
EM_PROBABILITY = max(
'P_BAD1'n,
'P_BAD0'n);

endsubmit; 
run; 
