import os
import os.path
import sys

sys.path.append('/models/resources/viya/55f99693-b2ac-444e-a7b4-3b7f741c0255/')

import hmeq_xgboost_truist

import settings_55f99693_b2ac_444e_a7b4_3b7f741c0255

settings_55f99693_b2ac_444e_a7b4_3b7f741c0255.pickle_path = '/models/resources/viya/55f99693-b2ac-444e-a7b4-3b7f741c0255/'

def score_record(LOAN,MORTDUE,VALUE,REASON,JOB,YOJ,DEROG,DELINQ,CLAGE,NINQ,CLNO,DEBTINC):
    "Output: P_Bad1,msg"
    return hmeq_xgboost_truist.scoreModel(LOAN,MORTDUE,VALUE,REASON,JOB,YOJ,DEROG,DELINQ,CLAGE,NINQ,CLNO,DEBTINC)

print(score_record(145.45,31.33,158.99,"","",71.98,7.77,52.53,121.16,35.21,69.32,116.25))
