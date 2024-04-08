import os
import os.path
import sys

sys.path.append('/models/resources/viya/d67f78ca-d36c-4ded-80c2-f8187d8c2b38/')

import llm_guardrails_ollama

import settings_d67f78ca_d36c_4ded_80c2_f8187d8c2b38

settings_d67f78ca_d36c_4ded_80c2_f8187d8c2b38.pickle_path = '/models/resources/viya/d67f78ca-d36c-4ded-80c2-f8187d8c2b38/'

def score_record(prompt,system,history,model,embedder,collection,host,model_port,vector_port):
    "Output: response"
    return llm_guardrails_ollama.scoreModel(prompt,system,history,model,embedder,collection,host,model_port,vector_port)

print(score_record("","","","","","","",68.76,9.99))
