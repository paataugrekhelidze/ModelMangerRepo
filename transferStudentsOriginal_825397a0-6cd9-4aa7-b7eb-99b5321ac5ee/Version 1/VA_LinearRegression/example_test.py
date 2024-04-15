import os
import os.path
import sys

sys.path.append('/models/resources/viya/be2af62c-66cc-4e23-8825-c4d514108530/')

import VA_LinearRegression

import settings_be2af62c_66cc_4e23_8825_c4d514108530

settings_be2af62c_66cc_4e23_8825_c4d514108530.pickle_path = '/models/resources/viya/be2af62c-66cc-4e23-8825-c4d514108530/'

def score_record(ACT_COMP,ACT_ENGL,ACT_MATH,ACT_READ,ACT_SCIENCE,ACT_WRITING,AGE,CNSS_TGPA,College,HS_GPA,Ratio_B_to_A,Ratio_C_to_A,Ratio_C_to_B,Ratio_D_to_A,Ratio_D_to_B,Ratio_D_to_C,Ratio_F_to_A,Ratio_F_to_B,Ratio_F_to_C,Ratio_F_to_D,SAT_ES_SUB,SAT_MATH,SAT_MUL_CHCE,SAT_VERBAL,SAT_WRITING,TOTAL_SAT,AFFIL_ALUM_R1,AFFIL_ALUM_R2,AFFIL_RELATION1,AFFIL_RELATION2,CNSS_LOAD):
    "Output: P_EOT_SGPA"
    return VA_LinearRegression.scoreModel(ACT_COMP,ACT_ENGL,ACT_MATH,ACT_READ,ACT_SCIENCE,ACT_WRITING,AGE,CNSS_TGPA,College,HS_GPA,Ratio_B_to_A,Ratio_C_to_A,Ratio_C_to_B,Ratio_D_to_A,Ratio_D_to_B,Ratio_D_to_C,Ratio_F_to_A,Ratio_F_to_B,Ratio_F_to_C,Ratio_F_to_D,SAT_ES_SUB,SAT_MATH,SAT_MUL_CHCE,SAT_VERBAL,SAT_WRITING,TOTAL_SAT,AFFIL_ALUM_R1,AFFIL_ALUM_R2,AFFIL_RELATION1,AFFIL_RELATION2,CNSS_LOAD)

print(score_record(151.81,180.32,29.42,128.64,90.36,91.53,19.89,196.51,140.85,105.12,120.09,2.69,150.38,146.80,35.26,0.88,79.02,184.12,95.27,137.70,79.10,89.91,143.79,59.80,154.20,182.89,"","","","",""))
