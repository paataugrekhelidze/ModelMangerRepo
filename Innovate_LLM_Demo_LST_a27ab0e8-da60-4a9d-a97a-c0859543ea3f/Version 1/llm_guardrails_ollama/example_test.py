import os
import os.path
import sys

sys.path.append('/models/resources/viya/020a3df1-d44b-4782-80e7-945fdd37cd78/')

import llm_guardrails_ollama

import settings_020a3df1_d44b_4782_80e7_945fdd37cd78

settings_020a3df1_d44b_4782_80e7_945fdd37cd78.pickle_path = '/models/resources/viya/020a3df1-d44b-4782-80e7-945fdd37cd78/'

def score_record(prompt,system,history,model,embedder,collection,host,model_port,vector_port):
    "Output: response"
    return llm_guardrails_ollama.scoreModel(prompt,system,history,model,embedder,collection,host,model_port,vector_port)

print(score_record("","","","","","","",116.10,196.47))
