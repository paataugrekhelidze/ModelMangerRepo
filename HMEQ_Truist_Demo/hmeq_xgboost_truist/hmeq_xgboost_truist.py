
import numpy
import settings
import pandas
import pickle
from sklearn.preprocessing import OneHotEncoder


def preprocessing(df, ohe_loc = None):
    encode_cols = df.loc[:, df.dtypes == "object"].columns.tolist()
    
    with open(ohe_loc, "rb") as ohe_file:
        ohe = pickle.load(ohe_file) 
    enc = ohe.transform(df[encode_cols])
    df[ohe.get_feature_names(encode_cols).tolist()] = pandas.DataFrame(enc, index=df.index)

    df.drop(encode_cols,1,inplace=True)

    df.dropna(inplace=True)
    
    return df





#inside input parameter goes all the predictor/input variables
def scoreModel(LOAN, MORTDUE, VALUE, REASON, JOB, YOJ, DEROG, DELINQ, CLAGE, NINQ, CLNO, DEBTINC):
    "Output: P_Bad1, msg"

    
    _pFile = open(settings.pickle_path + "hmeq_xgboost_truist.pickle", "rb")
    _thisModelFit = pickle.load(_pFile)
    _pFile.close()


    try:    
        # Construct the input array for scoring (the first term is for the Intercept)
        # mapyour input parameters with associated column names in pandas table
        input_array = pandas.DataFrame([[LOAN, MORTDUE, VALUE, REASON, JOB, YOJ, DEROG, DELINQ, CLAGE, NINQ, CLNO, DEBTINC]],
                                   
                                   columns = ["LOAN", "MORTDUE", "VALUE", "REASON", "JOB", "YOJ", "DEROG", "DELINQ", "CLAGE", "NINQ", "CLNO", "DEBTINC"], 
                                   dtype = float)
        
        # perform the same preprocessing procedure as it was done during training
        input_array.fillna(0, inplace=True)

        # custom preprocessing step
        input_array = preprocessing(input_array, ohe_loc = settings.pickle_path + "hmeq__encoder.pickle")


        # Calculate the predicted probabilities
        _predProb = _thisModelFit.predict_proba(input_array)
        # Retrieve the event probability
        P_Bad1 = round(float(_predProb[0][1]),3)
        msg = "success"
    except Exception as e:
        P_Bad1 = float(-1)
        msg = str(e)
    return P_Bad1, msg