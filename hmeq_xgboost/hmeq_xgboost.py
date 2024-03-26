
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
    df[ohe.get_feature_names_out(encode_cols).tolist()] = pandas.DataFrame(enc, index=df.index)

    df.drop(encode_cols, axis = 1,inplace=True)

    df.dropna(inplace=True)
    
    return df





#inside input parameter goes all the predictor/input variables
def scoreModel(LOAN, MORTDUE, VALUE, REASON, JOB, YOJ, DEROG, DELINQ, CLAGE, NINQ, CLNO, DEBTINC):
    "Output: P_Bad1, msg"

    
    _pFile = open(settings.pickle_path + "hmeq_xgboost.pickle", "rb")
    _thisModelFit = pickle.load(_pFile)
    _pFile.close()
    
    index=None
    if not isinstance(LOAN, pandas.Series):
        index=[0]
    
    # Construct the input array for scoring (the first term is for the Intercept)
    # mapyour input parameters with associated column names in pandas table
    input_array = pandas.DataFrame({
        "LOAN": LOAN,
        "MORTDUE": MORTDUE,
        "VALUE": VALUE,
        "REASON": REASON,
        "JOB": JOB,
        "YOJ": YOJ,
        "DEROG": DEROG,
        "DELINQ": DELINQ,
        "CLAGE": CLAGE,
        "NINQ": NINQ,
        "CLNO": CLNO,
        "DEBTINC": DEBTINC
    }, index=index)
    
    # perform the same preprocessing procedure as it was done during training
    input_array.fillna(0, inplace=True)

    # custom preprocessing step
    input_array = preprocessing(input_array, ohe_loc = settings.pickle_path + "hmeq__encoder.pickle")

    # Calculate the predicted probabilities
    prediction = _thisModelFit.predict_proba(input_array).tolist()
    
    # if a single record then return a tuple
    if input_array.shape[0] == 1:
        return round(float(prediction[0][1]),3), "success"
	
	# batch data, return a dataframe
    prediction = pandas.DataFrame(prediction)
    prediction.drop(prediction.columns[0], axis=1, inplace=True)
    prediction["msg"] = ["success"] * len(prediction)
    prediction.rename(columns={ prediction.columns[0]: "P_Bad1" }, inplace = True)

    return prediction