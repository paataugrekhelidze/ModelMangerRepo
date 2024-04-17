/*----------------------------------------------------------------------------------*/
/* Product:            Visual Data Mining and Machine Learning                      */
/* Release Version:    V2024.03                                                     */
/* Component Version:  V2024.03                                                     */
/* CAS Version:        V.04.00M0P03182024                                           */
/* SAS Version:        V.04.00M0P031824                                             */
/* Site Number:        70180938                                                     */
/* Host:               sas-cas-server-default-client                                */
/* Encoding:           utf-8                                                        */
/* Java Encoding:      UTF8                                                         */
/* Locale:             en_US                                                        */
/* Project GUID:       9642ef8e-fa53-45db-8038-e75a349a5db3                         */
/* Node GUID:          89b730a3-317a-4c8d-8d4d-c127353c779e                         */
/* Node Id:            85IEUGY549H5E7NCD0WE775PA                                    */
/* Algorithm:          Gradient Boosting                                            */
/* Generated by:       Robert.Blanchard@sas.com                                     */
/* Date:               09APR2024:20:01:00                                           */
/*----------------------------------------------------------------------------------*/
package MS_89b730a3317a4c8d8d4dc127353c779e_09APR2024200100100 / overwrite=yes;
   dcl package score _85IEUGY549H5E7NCD0WE775PA();
   dcl double EM_PREDICTION;
   dcl double "ACT_COMP";
   dcl double "ACT_ENGL";
   dcl double "ACT_MATH";
   dcl double "ACT_READ";
   dcl double "ACT_SCIENCE";
   dcl double "ACT_WRITING";
   dcl double "AGE";
   dcl double "CNSS_TGPA";
   dcl double "College";
   dcl double "HS_GPA";
   dcl double "Ratio_B_to_A";
   dcl double "Ratio_C_to_A";
   dcl double "Ratio_C_to_B";
   dcl double "Ratio_D_to_A";
   dcl double "Ratio_D_to_B";
   dcl double "Ratio_D_to_C";
   dcl double "Ratio_F_to_A";
   dcl double "Ratio_F_to_B";
   dcl double "Ratio_F_to_C";
   dcl double "Ratio_F_to_D";
   dcl double "SAT_ES_SUB";
   dcl double "SAT_MATH";
   dcl double "SAT_MUL_CHCE";
   dcl double "SAT_VERBAL";
   dcl double "SAT_WRITING";
   dcl double "TOTAL_SAT";
   dcl varchar(5) "AFFIL_ALUM_R1";
   dcl varchar(5) "AFFIL_ALUM_R2";
   dcl varchar(14) "AFFIL_RELATION1";
   dcl varchar(13) "AFFIL_RELATION2";
   dcl varchar(19) "CNSS_LOAD";
   dcl double "P_EOT_SGPA" having label n'Predicted: EOT_SGPA';
   dcl nchar(4) "_WARN_" having label n'Warnings';
   varlist allvars [_all_];
 
    
   method init();
      _85IEUGY549H5E7NCD0WE775PA.setvars(allvars);
      _85IEUGY549H5E7NCD0WE775PA.setkey(n'27060123B8E010DFF8C9F6993A510620A13F53CE');
   end;
    
   method post_85IEUGY549H5E7NCD0WE775PA();
      dcl double _P_;
       
      if "P_EOT_SGPA" = . then "P_EOT_SGPA" = 2.9544617579;
      EM_PREDICTION = "P_EOT_SGPA";
    
   end;
    
 
   method score(
      double "ACT_COMP",
      double "ACT_ENGL",
      double "ACT_MATH",
      double "ACT_READ",
      double "ACT_SCIENCE",
      double "ACT_WRITING",
      varchar(5) "AFFIL_ALUM_R1",
      varchar(5) "AFFIL_ALUM_R2",
      varchar(14) "AFFIL_RELATION1",
      varchar(13) "AFFIL_RELATION2",
      double "AGE",
      varchar(19) "CNSS_LOAD",
      double "CNSS_TGPA",
      double "College",
      double "HS_GPA",
      double "Ratio_B_to_A",
      double "Ratio_C_to_A",
      double "Ratio_C_to_B",
      double "Ratio_D_to_A",
      double "Ratio_D_to_B",
      double "Ratio_D_to_C",
      double "Ratio_F_to_A",
      double "Ratio_F_to_B",
      double "Ratio_F_to_C",
      double "Ratio_F_to_D",
      double "SAT_ES_SUB",
      double "SAT_MATH",
      double "SAT_MUL_CHCE",
      double "SAT_VERBAL",
      double "SAT_WRITING",
      double "TOTAL_SAT",
      IN_OUT double "EM_PREDICTION",
      IN_OUT double "P_EOT_SGPA",
      IN_OUT char(4) "_WARN_"
   );
      this."ACT_COMP"= "ACT_COMP";
      this."ACT_ENGL"= "ACT_ENGL";
      this."ACT_MATH"= "ACT_MATH";
      this."ACT_READ"= "ACT_READ";
      this."ACT_SCIENCE"= "ACT_SCIENCE";
      this."ACT_WRITING"= "ACT_WRITING";
      this."AFFIL_ALUM_R1"= "AFFIL_ALUM_R1";
      this."AFFIL_ALUM_R2"= "AFFIL_ALUM_R2";
      this."AFFIL_RELATION1"= "AFFIL_RELATION1";
      this."AFFIL_RELATION2"= "AFFIL_RELATION2";
      this."AGE"= "AGE";
      this."CNSS_LOAD"= "CNSS_LOAD";
      this."CNSS_TGPA"= "CNSS_TGPA";
      this."College"= "College";
      this."HS_GPA"= "HS_GPA";
      this."Ratio_B_to_A"= "Ratio_B_to_A";
      this."Ratio_C_to_A"= "Ratio_C_to_A";
      this."Ratio_C_to_B"= "Ratio_C_to_B";
      this."Ratio_D_to_A"= "Ratio_D_to_A";
      this."Ratio_D_to_B"= "Ratio_D_to_B";
      this."Ratio_D_to_C"= "Ratio_D_to_C";
      this."Ratio_F_to_A"= "Ratio_F_to_A";
      this."Ratio_F_to_B"= "Ratio_F_to_B";
      this."Ratio_F_to_C"= "Ratio_F_to_C";
      this."Ratio_F_to_D"= "Ratio_F_to_D";
      this."SAT_ES_SUB"= "SAT_ES_SUB";
      this."SAT_MATH"= "SAT_MATH";
      this."SAT_MUL_CHCE"= "SAT_MUL_CHCE";
      this."SAT_VERBAL"= "SAT_VERBAL";
      this."SAT_WRITING"= "SAT_WRITING";
      this."TOTAL_SAT"= "TOTAL_SAT";
 
      _85IEUGY549H5E7NCD0WE775PA.scoreRecord();
      post_85IEUGY549H5E7NCD0WE775PA();
 
      "EM_PREDICTION"= this."EM_PREDICTION";
      "P_EOT_SGPA"= this."P_EOT_SGPA";
      "_WARN_"= this."_WARN_";
   end;
 
 
   method predictedscore(
      double "ACT_COMP",
      double "ACT_ENGL",
      double "ACT_MATH",
      double "ACT_READ",
      double "ACT_SCIENCE",
      double "ACT_WRITING",
      varchar(5) "AFFIL_ALUM_R1",
      varchar(5) "AFFIL_ALUM_R2",
      varchar(14) "AFFIL_RELATION1",
      varchar(13) "AFFIL_RELATION2",
      double "AGE",
      varchar(19) "CNSS_LOAD",
      double "CNSS_TGPA",
      double "College",
      double "HS_GPA",
      double "Ratio_B_to_A",
      double "Ratio_C_to_A",
      double "Ratio_C_to_B",
      double "Ratio_D_to_A",
      double "Ratio_D_to_B",
      double "Ratio_D_to_C",
      double "Ratio_F_to_A",
      double "Ratio_F_to_B",
      double "Ratio_F_to_C",
      double "Ratio_F_to_D",
      double "SAT_ES_SUB",
      double "SAT_MATH",
      double "SAT_MUL_CHCE",
      double "SAT_VERBAL",
      double "SAT_WRITING",
      double "TOTAL_SAT",
      IN_OUT double "EM_PREDICTION",
      IN_OUT double "P_EOT_SGPA",
      IN_OUT char(4) "_WARN_"
   );
      this."ACT_COMP"= "ACT_COMP";
      this."ACT_ENGL"= "ACT_ENGL";
      this."ACT_MATH"= "ACT_MATH";
      this."ACT_READ"= "ACT_READ";
      this."ACT_SCIENCE"= "ACT_SCIENCE";
      this."ACT_WRITING"= "ACT_WRITING";
      this."AFFIL_ALUM_R1"= "AFFIL_ALUM_R1";
      this."AFFIL_ALUM_R2"= "AFFIL_ALUM_R2";
      this."AFFIL_RELATION1"= "AFFIL_RELATION1";
      this."AFFIL_RELATION2"= "AFFIL_RELATION2";
      this."AGE"= "AGE";
      this."CNSS_LOAD"= "CNSS_LOAD";
      this."CNSS_TGPA"= "CNSS_TGPA";
      this."College"= "College";
      this."HS_GPA"= "HS_GPA";
      this."Ratio_B_to_A"= "Ratio_B_to_A";
      this."Ratio_C_to_A"= "Ratio_C_to_A";
      this."Ratio_C_to_B"= "Ratio_C_to_B";
      this."Ratio_D_to_A"= "Ratio_D_to_A";
      this."Ratio_D_to_B"= "Ratio_D_to_B";
      this."Ratio_D_to_C"= "Ratio_D_to_C";
      this."Ratio_F_to_A"= "Ratio_F_to_A";
      this."Ratio_F_to_B"= "Ratio_F_to_B";
      this."Ratio_F_to_C"= "Ratio_F_to_C";
      this."Ratio_F_to_D"= "Ratio_F_to_D";
      this."SAT_ES_SUB"= "SAT_ES_SUB";
      this."SAT_MATH"= "SAT_MATH";
      this."SAT_MUL_CHCE"= "SAT_MUL_CHCE";
      this."SAT_VERBAL"= "SAT_VERBAL";
      this."SAT_WRITING"= "SAT_WRITING";
      this."TOTAL_SAT"= "TOTAL_SAT";
 
      _85IEUGY549H5E7NCD0WE775PA.scoreRecord();
      post_85IEUGY549H5E7NCD0WE775PA();
 
      "EM_PREDICTION"= this."EM_PREDICTION";
      "P_EOT_SGPA"= this."P_EOT_SGPA";
      "_WARN_"= this."_WARN_";
   end;
 
endpackage;