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

print(score_record(82.68,119.01,198.99,"","",44.47,99.74,176.73,21.56,14.62,48.50,167.92))
