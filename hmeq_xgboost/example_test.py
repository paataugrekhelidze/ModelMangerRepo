import os
import os.path
import sys

sys.path.append('/models/resources/viya/e9d6db04-c548-460d-8739-d78c17c42cc7/')

import hmeq_xgboost

import settings_e9d6db04_c548_460d_8739_d78c17c42cc7

settings_e9d6db04_c548_460d_8739_d78c17c42cc7.pickle_path = '/models/resources/viya/e9d6db04-c548-460d-8739-d78c17c42cc7/'

def score_record(LOAN,MORTDUE,VALUE,REASON,JOB,YOJ,DEROG,DELINQ,CLAGE,NINQ,CLNO,DEBTINC):
    "Output: P_Bad1,msg"
    return hmeq_xgboost.scoreModel(LOAN,MORTDUE,VALUE,REASON,JOB,YOJ,DEROG,DELINQ,CLAGE,NINQ,CLNO,DEBTINC)

print(score_record(110.02,99.85,95.43,"","",111.74,173.54,106.12,51.72,156.23,153.63,194.22))
