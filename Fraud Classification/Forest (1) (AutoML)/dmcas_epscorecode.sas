/*----------------------------------------------------------------------------------*/
/* Product:            Visual Data Mining and Machine Learning                      */
/* Release Version:    V2021.2.5                                                    */
/* Component Version:  V2021.2.5                                                    */
/* CAS Version:        V.04.00M0P03142022                                           */
/* SAS Version:        V.04.00M0P031422                                             */
/* Site Number:        70180938                                                     */
/* Host:               sas-cas-server-default-client                                */
/* Encoding:           utf-8                                                        */
/* Java Encoding:      UTF8                                                         */
/* Locale:             en_US                                                        */
/* Project GUID:       550ada56-1aa1-4b06-8a93-1aa27760e01e                         */
/* Node GUID:          bda7d9cd-37e4-4ebd-9a63-ec201e6dc546                         */
/* Node Id:            B87L1L3JSYL8TIOR6SJ4C0NYE                                    */
/* Algorithm:          Forest                                                       */
/* Generated by:       Sophia.Rowland@sas.com                                       */
/* Date:               10JUN2022:21:36:10                                           */
/*----------------------------------------------------------------------------------*/
data sasep.out;
   dcl double "AMOUNT_MCC_DEV";
   dcl nchar(3) "AUTH_ADVICE";
   dcl double "AUTH_AMOUNT";
   dcl double "AUTH_AVAIL_CREDIT";
   dcl double "AUTH_CARD_ZIP3_DIFF";
   dcl double "AUTH_CRED_LINE";
   dcl nchar(3) "AUTH_TRAN_TYPE";
   dcl double "CARD_CRED_LINE";
   dcl double "CARD_NUM_CARDS";
   dcl double "daily_count";
   dcl double "daily_sum";
   dcl double "MCC_RISK";
   dcl double "weekly_count";
   dcl double "weekly_sum";
   dcl double "INVSQRT_AMOUNT_MCC_DEV" having label n'Transformed AMOUNT_MCC_DEV';
   dcl nchar(9) "BIN_AUTH_ADVICE" having label n'Transformed AUTH_ADVICE';
   dcl double "INV_AUTH_CARD_ZIP3_DIFF" having label n'Transformed AUTH_CARD_ZIP3_DIFF';
   dcl nchar(9) "BIN_AUTH_TRAN_TYPE" having label n'Transformed AUTH_TRAN_TYPE';
   dcl double "SQRT_CARD_CRED_LINE" having label n'Transformed CARD_CRED_LINE';
   dcl nchar(12) "BIN_CARD_NUM_CARDS" having label n'Transformed CARD_NUM_CARDS';
   dcl double "INV_MCC_RISK" having label n'Transformed MCC_RISK';
   dcl nchar(3) "AUTH_CVV";
   dcl nchar(3) "AUTH_KEY_SWIPE";
   dcl nchar(3) "AUTH_PIN_VER";
   dcl nchar(3) "CARD_TYPE";
   dcl double "sev_2500_to_5000";
   dcl double "sev_ge_5000";
   dcl double "TARGENC_sev_2500_to_5000" having label n'Transformed sev_2500_to_5000';
   dcl double "TARGENC_sev_ge_5000" having label n'Transformed sev_ge_5000';
   dcl package score _B87L1L3JSYL8TIOR6SJ4C0NYE();
   dcl double EM_EVENTPROBABILITY;
   dcl double "AUTH_HOUR";
   dcl nchar(12) EM_CLASSIFICATION;
   dcl double EM_PROBABILITY;
   dcl double "IMP_INVSQRT_AMOUNT_MCC_DEV" having label n'Imputed Transformed AMOUNT_MCC_DEV';
   dcl double "IMP_INV_AUTH_CARD_ZIP3_DIFF" having label n'Imputed Transformed AUTH_CARD_ZIP3_DIFF';
   dcl double "IMP_INV_MCC_RISK" having label n'Imputed Transformed MCC_RISK';
   dcl double "IMP_SQRT_CARD_CRED_LINE" having label n'Imputed Transformed CARD_CRED_LINE';
   dcl double "INVSQR_daily_count" having label n'Transformed daily_count';
   dcl double "INVSQR_weekly_count" having label n'Transformed weekly_count';
   dcl double "LOG_AUTH_AMOUNT" having label n'Transformed AUTH_AMOUNT';
   dcl double "LOG_AUTH_AVAIL_CREDIT" having label n'Transformed AUTH_AVAIL_CREDIT';
   dcl double "LOG_daily_sum" having label n'Transformed daily_sum';
   dcl double "LOG_weekly_sum" having label n'Transformed weekly_sum';
   dcl double "SQRT_AUTH_CRED_LINE" having label n'Transformed AUTH_CRED_LINE';
   dcl double "TARGENC_AUTH_CVV" having label n'Transformed AUTH_CVV';
   dcl double "TARGENC_AUTH_KEY_SWIPE" having label n'Transformed AUTH_KEY_SWIPE';
   dcl double "TARGENC_AUTH_PIN_VER" having label n'Transformed AUTH_PIN_VER';
   dcl double "TARGENC_BIN_AUTH_ADVICE" having label n'Transformed Transformed AUTH_ADVICE';
   dcl double "TARGENC_BIN_AUTH_TRAN_TYPE" having label n'Transformed Transformed AUTH_TRAN_TYPE';
   dcl double "TARGENC_BIN_CARD_NUM_CARDS" having label n'Transformed Transformed CARD_NUM_CARDS';
   dcl double "TARGENC_CARD_TYPE" having label n'Transformed CARD_TYPE';
   dcl double "week_number";
   dcl double "M_AUTH_CURR_RATE" having label n'Missing Indicator for AUTH_CURR_RATE';
   dcl double "M_CARD_USE" having label n'Missing Indicator for CARD_USE';
   dcl double "M_INVSQRT_AMOUNT_MCC_DEV" having label n'Missing Indicator for INVSQRT_AMOUNT_MCC_DEV';
   dcl double "M_INV_AUTH_CARD_ZIP3_DIFF" having label n'Missing Indicator for INV_AUTH_CARD_ZIP3_DIFF';
   dcl double "M_INV_MCC_RISK" having label n'Missing Indicator for INV_MCC_RISK';
   dcl double "M_SQRT_CARD_CRED_LINE" having label n'Missing Indicator for SQRT_CARD_CRED_LINE';
   dcl double "AUTH_CURR_RATE";
   dcl nchar(3) "CARD_USE";
   dcl double "P_FRAUD_LABEL_1" having label n'Predicted: FRAUD_LABEL=-1';
   dcl double "P_FRAUD_LABEL1" having label n'Predicted: FRAUD_LABEL=1';
   dcl nchar(32) "I_FRAUD_LABEL" having label n'Into: FRAUD_LABEL';
   dcl nchar(4) "_WARN_" having label n'Warnings';
   varlist allvars [_all_];
 
    
   method init();
      _B87L1L3JSYL8TIOR6SJ4C0NYE.setvars(allvars);
      _B87L1L3JSYL8TIOR6SJ4C0NYE.setkey(n'881D2D80BBD1B229937457AF4166238EF53C4CAF');
   end;
    
   method _9SAUVGS62EPFJOD8DK15IS8BT();
      dcl nchar(3) _BINTMP3;
      dcl nchar(12) _BINTMP12;
       
      if MISSING("AMOUNT_MCC_DEV") | ("AMOUNT_MCC_DEV" + 3.12 <= 0.0) then "INVSQRT_AMOUNT_MCC_DEV"
      = .;
      else "INVSQRT_AMOUNT_MCC_DEV" = 1.0 / (SQRT("AMOUNT_MCC_DEV" + 3.12));
      if MISSING("AUTH_ADVICE") then "BIN_AUTH_ADVICE" = '_MISSING_';
      else do ;
      _BINTMP3 = '';
      _BINTMP3 = KTRIM(put("AUTH_ADVICE", $CHAR3.));
      if _BINTMP3 in ('A') then "BIN_AUTH_ADVICE" = '_OTHER_';
      else "BIN_AUTH_ADVICE" = _BINTMP3;
      end;
      if MISSING("AUTH_AMOUNT") | ("AUTH_AMOUNT" + 1.0 <= 0.0) then "LOG_AUTH_AMOUNT"
      = .;
      else "LOG_AUTH_AMOUNT" = LOG("AUTH_AMOUNT" + 1.0);
      if MISSING("AUTH_AVAIL_CREDIT") | ("AUTH_AVAIL_CREDIT" + 2935.0 <= 0.0)
      then "LOG_AUTH_AVAIL_CREDIT" = .;
      else "LOG_AUTH_AVAIL_CREDIT" = LOG("AUTH_AVAIL_CREDIT" + 2935.0);
      if MISSING("AUTH_CARD_ZIP3_DIFF") then "INV_AUTH_CARD_ZIP3_DIFF" = .;
      else if "AUTH_CARD_ZIP3_DIFF" >= 0.0 then "INV_AUTH_CARD_ZIP3_DIFF" =
      1.0 / ("AUTH_CARD_ZIP3_DIFF" + 1.0);
      else "INV_AUTH_CARD_ZIP3_DIFF" = 1.0 / ("AUTH_CARD_ZIP3_DIFF" - 1.0);
      if MISSING("AUTH_CRED_LINE") | ("AUTH_CRED_LINE" + 1.0 <= 0.0) then "SQRT_AUTH_CRED_LINE"
      = .;
      else "SQRT_AUTH_CRED_LINE" = SQRT("AUTH_CRED_LINE" + 1.0);
      if MISSING("AUTH_TRAN_TYPE") then "BIN_AUTH_TRAN_TYPE" = '_MISSING_';
      else do ;
      _BINTMP3 = '';
      _BINTMP3 = KTRIM(put("AUTH_TRAN_TYPE", $CHAR3.));
      if _BINTMP3 in ('S') then "BIN_AUTH_TRAN_TYPE" = '_OTHER_';
      else "BIN_AUTH_TRAN_TYPE" = _BINTMP3;
      end;
      if MISSING("CARD_CRED_LINE") | ("CARD_CRED_LINE" + 1.0 <= 0.0) then "SQRT_CARD_CRED_LINE"
      = .;
      else "SQRT_CARD_CRED_LINE" = SQRT("CARD_CRED_LINE" + 1.0);
      if MISSING("CARD_NUM_CARDS") then "BIN_CARD_NUM_CARDS" = '_MISSING_';
      else do ;
      _BINTMP12 = '';
      _BINTMP12 = KSTRIP(put("CARD_NUM_CARDS", BEST12.));
      if _BINTMP12 in ('0', '5', '6', '7', '8', '9', '10', '11') then "BIN_CARD_NUM_CARDS"
      = '_OTHER_';
      else "BIN_CARD_NUM_CARDS" = _BINTMP12;
      end;
      if MISSING("MCC_RISK") then "INV_MCC_RISK" = .;
      else if "MCC_RISK" >= 0.0 then "INV_MCC_RISK" = 1.0 / ("MCC_RISK" + 1.0);
      else "INV_MCC_RISK" = 1.0 / ("MCC_RISK" - 1.0);
      if MISSING("DAILY_COUNT") then "INVSQR_DAILY_COUNT" = .;
      else "INVSQR_DAILY_COUNT" = 1.0 / (("DAILY_COUNT" ** 2.0) + 1.0);
      if MISSING("DAILY_SUM") | ("DAILY_SUM" + 1.0 <= 0.0) then "LOG_DAILY_SUM"
      = .;
      else "LOG_DAILY_SUM" = LOG("DAILY_SUM" + 1.0);
      if MISSING("WEEKLY_COUNT") then "INVSQR_WEEKLY_COUNT" = .;
      else "INVSQR_WEEKLY_COUNT" = 1.0 / (("WEEKLY_COUNT" ** 2.0) + 1.0);
      if MISSING("WEEKLY_SUM") | ("WEEKLY_SUM" + 1.0 <= 0.0) then "LOG_WEEKLY_SUM"
      = .;
      else "LOG_WEEKLY_SUM" = LOG("WEEKLY_SUM" + 1.0);
    
   end;
    
   method _CRDJQ0II467DP71ILFOLU8MNO();
      dcl nchar(12) _VAL_66750976;
       
      _VAL_66750976 = KTRIM(put("AUTH_CVV", $CHAR3.));
      select (_VAL_66750976);
      when (' ') "TARGENC_AUTH_CVV" = 0.1323492159;
      when ('I') "TARGENC_AUTH_CVV" = 0.3620689655;
      when ('V') "TARGENC_AUTH_CVV" = 0.0865576901;
      otherwise "TARGENC_AUTH_CVV" = 0.1031242251;
      end;
      _VAL_66750976 = KTRIM(put("AUTH_KEY_SWIPE", $CHAR3.));
      select (_VAL_66750976);
      when (' ') "TARGENC_AUTH_KEY_SWIPE" = 0.3100929615;
      when ('K') "TARGENC_AUTH_KEY_SWIPE" = 0.1280709357;
      when ('S') "TARGENC_AUTH_KEY_SWIPE" = 0.1050694527;
      when ('U') "TARGENC_AUTH_KEY_SWIPE" = 0.0898448101;
      otherwise "TARGENC_AUTH_KEY_SWIPE" = 0.1031242251;
      end;
      _VAL_66750976 = KTRIM(put("AUTH_PIN_VER", $CHAR3.));
      select (_VAL_66750976);
      when (' ') "TARGENC_AUTH_PIN_VER" = 0.1071154899;
      when ('I') "TARGENC_AUTH_PIN_VER" = 0.1950828434;
      when ('V') "TARGENC_AUTH_PIN_VER" = 0.0970470696;
      otherwise "TARGENC_AUTH_PIN_VER" = 0.1031242251;
      end;
      _VAL_66750976 = KTRIM(put("BIN_AUTH_ADVICE", $CHAR9.));
      select (_VAL_66750976);
      when ('_MISSING_') "TARGENC_BIN_AUTH_ADVICE" = 0.0697212994;
      when ('_OTHER_') "TARGENC_BIN_AUTH_ADVICE" = 0.1111111111;
      when ('N') "TARGENC_BIN_AUTH_ADVICE" = 0.1110780073;
      when ('Y') "TARGENC_BIN_AUTH_ADVICE" = 0.0775862069;
      otherwise "TARGENC_BIN_AUTH_ADVICE" = 0.1031242251;
      end;
      _VAL_66750976 = KTRIM(put("BIN_AUTH_TRAN_TYPE", $CHAR9.));
      select (_VAL_66750976);
      when ('_MISSING_') "TARGENC_BIN_AUTH_TRAN_TYPE" = 0.0;
      when ('_OTHER_') "TARGENC_BIN_AUTH_TRAN_TYPE" = 0.6666666667;
      when ('A') "TARGENC_BIN_AUTH_TRAN_TYPE" = 0.1418812401;
      when ('C') "TARGENC_BIN_AUTH_TRAN_TYPE" = 0.254873359;
      when ('M') "TARGENC_BIN_AUTH_TRAN_TYPE" = 0.0932488218;
      when ('V') "TARGENC_BIN_AUTH_TRAN_TYPE" = 0.0356445313;
      otherwise "TARGENC_BIN_AUTH_TRAN_TYPE" = 0.1031242251;
      end;
      _VAL_66750976 = KTRIM(put("BIN_CARD_NUM_CARDS", $CHAR12.));
      select (_VAL_66750976);
      when ('_MISSING_') "TARGENC_BIN_CARD_NUM_CARDS" = 0.1745253495;
      when ('_OTHER_') "TARGENC_BIN_CARD_NUM_CARDS" = 0.0712328767;
      when ('1') "TARGENC_BIN_CARD_NUM_CARDS" = 0.1087112751;
      when ('2') "TARGENC_BIN_CARD_NUM_CARDS" = 0.0845167294;
      when ('3') "TARGENC_BIN_CARD_NUM_CARDS" = 0.100933126;
      when ('4') "TARGENC_BIN_CARD_NUM_CARDS" = 0.102027027;
      otherwise "TARGENC_BIN_CARD_NUM_CARDS" = 0.1031242251;
      end;
      _VAL_66750976 = KTRIM(put("CARD_TYPE", $CHAR3.));
      select (_VAL_66750976);
      when (' ') "TARGENC_CARD_TYPE" = 0.15089688;
      when ('G') "TARGENC_CARD_TYPE" = 0.1078650461;
      when ('S') "TARGENC_CARD_TYPE" = 0.0929783685;
      otherwise "TARGENC_CARD_TYPE" = 0.1031242251;
      end;
      _VAL_66750976 = KSTRIP(put("SEV_2500_TO_5000", BEST12.));
      select (_VAL_66750976);
      when ('0') "TARGENC_SEV_2500_TO_5000" = 0.1028693074;
      when ('1') "TARGENC_SEV_2500_TO_5000" = 0.2196969697;
      otherwise "TARGENC_SEV_2500_TO_5000" = 0.1031242251;
      end;
      _VAL_66750976 = KSTRIP(put("SEV_GE_5000", BEST12.));
      select (_VAL_66750976);
      when ('0') "TARGENC_SEV_GE_5000" = 0.1030967048;
      when ('1') "TARGENC_SEV_GE_5000" = 0.1636363636;
      otherwise "TARGENC_SEV_GE_5000" = 0.1031242251;
      end;
    
   end;
    
   method _5NLB271TJ1V0DMRKFWBBOXEPA();
       
      if MISSING("INVSQRT_AMOUNT_MCC_DEV") then do ;
      "IMP_INVSQRT_AMOUNT_MCC_DEV" = 0.5792844464;
      end;
      else "IMP_INVSQRT_AMOUNT_MCC_DEV" = "INVSQRT_AMOUNT_MCC_DEV";
      if MISSING("INV_AUTH_CARD_ZIP3_DIFF") then do ;
      "IMP_INV_AUTH_CARD_ZIP3_DIFF" = 0.5;
      end;
      else "IMP_INV_AUTH_CARD_ZIP3_DIFF" = "INV_AUTH_CARD_ZIP3_DIFF";
      if MISSING("INV_MCC_RISK") then do ;
      "IMP_INV_MCC_RISK" = 0.8928571429;
      end;
      else "IMP_INV_MCC_RISK" = "INV_MCC_RISK";
      if MISSING("SQRT_CARD_CRED_LINE") then do ;
      "IMP_SQRT_CARD_CRED_LINE" = 86.608313689;
      end;
      else "IMP_SQRT_CARD_CRED_LINE" = "SQRT_CARD_CRED_LINE";
      if MISSING("AUTH_CURR_RATE") then "M_AUTH_CURR_RATE" = 1.0;
      else "M_AUTH_CURR_RATE" = 0.0;
      if MISSING("CARD_USE") then "M_CARD_USE" = 1.0;
      else "M_CARD_USE" = 0.0;
      if MISSING("INVSQRT_AMOUNT_MCC_DEV") then "M_INVSQRT_AMOUNT_MCC_DEV" =
      1.0;
      else "M_INVSQRT_AMOUNT_MCC_DEV" = 0.0;
      if MISSING("INV_AUTH_CARD_ZIP3_DIFF") then "M_INV_AUTH_CARD_ZIP3_DIFF"
      = 1.0;
      else "M_INV_AUTH_CARD_ZIP3_DIFF" = 0.0;
      if MISSING("INV_MCC_RISK") then "M_INV_MCC_RISK" = 1.0;
      else "M_INV_MCC_RISK" = 0.0;
      if MISSING("SQRT_CARD_CRED_LINE") then "M_SQRT_CARD_CRED_LINE" = 1.0;
      else "M_SQRT_CARD_CRED_LINE" = 0.0;
    
   end;
    
   method post_B87L1L3JSYL8TIOR6SJ4C0NYE();
      dcl double _P_;
       
      if "P_FRAUD_LABEL_1" = . then "P_FRAUD_LABEL_1" = 0.8968757749;
      if "P_FRAUD_LABEL1" = . then "P_FRAUD_LABEL1" = 0.1031242251;
      if MISSING("I_FRAUD_LABEL") then do ;
      _P_ = 0.0;
      if "P_FRAUD_LABEL1" > _P_ then do ;
      _P_ = "P_FRAUD_LABEL1";
      "I_FRAUD_LABEL" = '           1';
      end;
      if "P_FRAUD_LABEL_1" > _P_ then do ;
      _P_ = "P_FRAUD_LABEL_1";
      "I_FRAUD_LABEL" = '          -1';
      end;
      end;
      EM_EVENTPROBABILITY = "P_FRAUD_LABEL1";
      EM_CLASSIFICATION = "I_FRAUD_LABEL";
      EM_PROBABILITY = MAX("P_FRAUD_LABEL1", "P_FRAUD_LABEL_1");
    
   end;
    
 
   method run();
      set SASEP.IN;
      _9SAUVGS62EPFJOD8DK15IS8BT();
      _CRDJQ0II467DP71ILFOLU8MNO();
      _5NLB271TJ1V0DMRKFWBBOXEPA();
      _B87L1L3JSYL8TIOR6SJ4C0NYE.scoreRecord();
      post_B87L1L3JSYL8TIOR6SJ4C0NYE();
   end;
 
   method term();
   end;
 
enddata;
