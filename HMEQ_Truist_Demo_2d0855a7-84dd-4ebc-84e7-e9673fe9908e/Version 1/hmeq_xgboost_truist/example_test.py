import os
import os.path
import sys

sys.path.append('/models/resources/viya/cd7f2716-57e6-426c-8e28-708fc4e19b74/')

import hmeq_xgboost_truist

import settings_cd7f2716_57e6_426c_8e28_708fc4e19b74

settings_cd7f2716_57e6_426c_8e28_708fc4e19b74.pickle_path = '/models/resources/viya/cd7f2716-57e6-426c-8e28-708fc4e19b74/'

def score_record(LOAN,MORTDUE,VALUE,REASON,JOB,YOJ,DEROG,DELINQ,CLAGE,NINQ,CLNO,DEBTINC):
    "Output: P_Bad1,msg"
    return hmeq_xgboost_truist.scoreModel(LOAN,MORTDUE,VALUE,REASON,JOB,YOJ,DEROG,DELINQ,CLAGE,NINQ,CLNO,DEBTINC)

print(score_record(109.66,68.54,112.68,"","",127.98,39.7,81.89,121.94,63.09,165.04,142.44))
