import os
import os.path
import sys

sys.path.append('/models/resources/viya/306a7eb7-26d0-4e33-a539-5304dbd08d64/')

import hmeq_xgb

import settings_306a7eb7_26d0_4e33_a539_5304dbd08d64

settings_306a7eb7_26d0_4e33_a539_5304dbd08d64.pickle_path = '/models/resources/viya/306a7eb7-26d0-4e33-a539-5304dbd08d64/'

def score_record(LOAN,MORTDUE,VALUE,REASON,JOB,YOJ,DEROG,DELINQ,CLAGE,NINQ,CLNO,DEBTINC):
    "Output: P_Bad1,msg"
    return hmeq_xgb.score(LOAN,MORTDUE,VALUE,REASON,JOB,YOJ,DEROG,DELINQ,CLAGE,NINQ,CLNO,DEBTINC)

print(score_record(90.29,89.91,122.36,"","",161.49,199.57,174.93,196.26,90.72,152.64,2.8))
