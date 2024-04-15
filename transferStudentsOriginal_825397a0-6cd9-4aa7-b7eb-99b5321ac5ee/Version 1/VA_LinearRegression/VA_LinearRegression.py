
import numpy
import settings
import pandas
import pickle
from sklearn.preprocessing import OneHotEncoder
from sklearn.impute import SimpleImputer


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
def scoreModel(ACT_COMP, ACT_ENGL, ACT_MATH, ACT_READ, ACT_SCIENCE, ACT_WRITING, AGE, CNSS_TGPA, College, HS_GPA, Ratio_B_to_A, Ratio_C_to_A, Ratio_C_to_B, Ratio_D_to_A, Ratio_D_to_B, Ratio_D_to_C, Ratio_F_to_A, Ratio_F_to_B, Ratio_F_to_C, Ratio_F_to_D, SAT_ES_SUB, SAT_MATH, SAT_MUL_CHCE, SAT_VERBAL, SAT_WRITING, TOTAL_SAT, AFFIL_ALUM_R1, AFFIL_ALUM_R2, AFFIL_RELATION1, AFFIL_RELATION2, CNSS_LOAD):
    "Output: P_EOT_SGPA"

    
    _pFile = open(settings.pickle_path + "VA_LinearRegression.pickle", "rb")
    _thisModelFit = pickle.load(_pFile)
    _pFile.close()
    
    parameter_names = ["ACT_COMP", "ACT_ENGL", "ACT_MATH", "ACT_READ", "ACT_SCIENCE", "ACT_WRITING", "AGE", "CNSS_TGPA", "College", "HS_GPA", "Ratio_B_to_A", "Ratio_C_to_A", "Ratio_C_to_B", "Ratio_D_to_A", "Ratio_D_to_B", "Ratio_D_to_C", "Ratio_F_to_A", "Ratio_F_to_B", "Ratio_F_to_C", "Ratio_F_to_D", "SAT_ES_SUB", "SAT_MATH", "SAT_MUL_CHCE", "SAT_VERBAL", "SAT_WRITING", "TOTAL_SAT", "AFFIL_ALUM_R1", "AFFIL_ALUM_R2", "AFFIL_RELATION1", "AFFIL_RELATION2", "CNSS_LOAD"]
    
    # Check if any argument is a Series, implying multiple inputs
    multiple_inputs = any(isinstance(arg, pandas.Series) for arg in [ACT_COMP, ACT_ENGL, ACT_MATH, ACT_READ, ACT_SCIENCE, ACT_WRITING, AGE, CNSS_TGPA, College, HS_GPA, Ratio_B_to_A, Ratio_C_to_A, Ratio_C_to_B, Ratio_D_to_A, Ratio_D_to_B, Ratio_D_to_C, Ratio_F_to_A, Ratio_F_to_B, Ratio_F_to_C, Ratio_F_to_D, SAT_ES_SUB, SAT_MATH, SAT_MUL_CHCE, SAT_VERBAL, SAT_WRITING, TOTAL_SAT, AFFIL_ALUM_R1, AFFIL_ALUM_R2, AFFIL_RELATION1, AFFIL_RELATION2, CNSS_LOAD])

    # Construct DataFrame from args
    if multiple_inputs:
        input_df = pandas.concat([ACT_COMP, ACT_ENGL, ACT_MATH, ACT_READ, ACT_SCIENCE, ACT_WRITING, AGE, CNSS_TGPA, College, HS_GPA, Ratio_B_to_A, Ratio_C_to_A, Ratio_C_to_B, Ratio_D_to_A, Ratio_D_to_B, Ratio_D_to_C, Ratio_F_to_A, Ratio_F_to_B, Ratio_F_to_C, Ratio_F_to_D, SAT_ES_SUB, SAT_MATH, SAT_MUL_CHCE, SAT_VERBAL, SAT_WRITING, TOTAL_SAT, AFFIL_ALUM_R1, AFFIL_ALUM_R2, AFFIL_RELATION1, AFFIL_RELATION2, CNSS_LOAD], axis=1)
        input_df.columns = parameter_names
    else:
        input_df = pandas.DataFrame([[ACT_COMP, ACT_ENGL, ACT_MATH, ACT_READ, ACT_SCIENCE, ACT_WRITING, AGE, CNSS_TGPA, College, HS_GPA, Ratio_B_to_A, Ratio_C_to_A, Ratio_C_to_B, Ratio_D_to_A, Ratio_D_to_B, Ratio_D_to_C, Ratio_F_to_A, Ratio_F_to_B, Ratio_F_to_C, Ratio_F_to_D, SAT_ES_SUB, SAT_MATH, SAT_MUL_CHCE, SAT_VERBAL, SAT_WRITING, TOTAL_SAT, AFFIL_ALUM_R1, AFFIL_ALUM_R2, AFFIL_RELATION1, AFFIL_RELATION2, CNSS_LOAD]], columns=parameter_names, index=[0])
    
    
    
    # perform the same preprocessing procedure as it was done during training
    with open(settings.pickle_path + "VA_num_imputer.pkl", 'rb') as f:
        num_imputer_loaded = pickle.load(f)
    with open(settings.pickle_path + "VA_cat_imputer.pkl", 'rb') as f:
        cat_imputer_loaded = pickle.load(f)

    numeric_cols = ["ACT_COMP", "ACT_ENGL", "ACT_MATH", "ACT_READ", "ACT_SCIENCE",
                     "ACT_WRITING", "AGE", "CNSS_TGPA", "College", "HS_GPA",
                     "Ratio_B_to_A", "Ratio_C_to_A", "Ratio_C_to_B", "Ratio_D_to_A",
                     "Ratio_D_to_B", "Ratio_D_to_C", "Ratio_F_to_A", "Ratio_F_to_B",
                     "Ratio_F_to_C", "Ratio_F_to_D", "SAT_ES_SUB", "SAT_MATH",
                     "SAT_MUL_CHCE", "SAT_VERBAL", "SAT_WRITING", "TOTAL_SAT"]
                     
    categorical_cols = ["AFFIL_ALUM_R1", "AFFIL_ALUM_R2", "AFFIL_RELATION1", "AFFIL_RELATION2", "CNSS_LOAD"]

    # Apply loaded imputers to new data
    input_df[numeric_cols] = num_imputer_loaded.transform(input_df[numeric_cols])
    input_df[categorical_cols] = cat_imputer_loaded.transform(input_df[categorical_cols])

    # custom preprocessing step
    input_array = preprocessing(input_df, ohe_loc = settings.pickle_path + "VA__encoder.pickle")


    # Calculate the predicted probabilities
    prediction = _thisModelFit.predict(input_array).tolist()
    
    # if a single record then return a tuple
    if input_array.shape[0] == 1:
        return round(float(prediction[0]),3)
	
	# batch data, return a dataframe
    prediction = pandas.DataFrame(prediction)
    prediction.rename(columns={ prediction.columns[0]: "P_EOT_SGPA" }, inplace = True)

    return prediction