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

print(score_record(199.03,60.33,159.97,161.27,112.87,152.26,82.10,142.95,128.65,182.25,86.06,137.08,27.99,35.94,97.87,0.33,37.78,17.05,8.80,6.80,39.57,169.77,130.69,3.35,127.07,49.16,"","","","",""))
