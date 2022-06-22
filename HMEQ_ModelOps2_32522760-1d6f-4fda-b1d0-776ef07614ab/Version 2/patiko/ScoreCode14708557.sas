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
