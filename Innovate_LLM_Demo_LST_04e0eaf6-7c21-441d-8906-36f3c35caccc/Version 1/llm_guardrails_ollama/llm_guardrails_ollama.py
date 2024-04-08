
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
import queue
import threading
from langchain.memory import ConversationSummaryBufferMemory
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_community.chat_models import ChatOllama
from langchain.chains import ConversationChain
import json
__import__('pysqlite3')
import sys
import os
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3')
import chromadb 
from langchain_community.embeddings import OllamaEmbeddings
from langchain_community.vectorstores import Chroma
from sentence_transformers.cross_encoder import CrossEncoder
from nemoguardrails import LLMRails, RailsConfig
import asyncio
from concurrent.futures import ThreadPoolExecutor
import pandas as pd

class ThreadedGenerator:
    def __init__(self):
        self.queue = queue.Queue()

    def __iter__(self):
        return self

    def __next__(self):
        item = self.queue.get()
        if item is StopIteration: raise item
        return item

    def send(self, data):
        self.queue.put(data)

    def close(self):
        self.queue.put(StopIteration)

class ChainStreamHandler(StreamingStdOutCallbackHandler):
    def __init__(self, gen):
        super().__init__()
        self.gen = gen

    def on_llm_new_token(self, token: str, **kwargs):
        self.gen.send(token)

def llm_thread(g, model, history, prompt, base_url, stream):
    try:
        config = {}
        if stream:
            config = {
                'callbacks' : [ChainStreamHandler(g)]
            }
        chatPromptMemory = ConversationSummaryBufferMemory(
            llm = ChatOllama(model = model, base_url = base_url), 
            max_token_limit = 100, 
            return_messages = True)
        
        for i in range(2, len(history)-1, 2):
            chatPromptMemory.save_context({ "input": history[i]['content'] }, { "output": history[i + 1]["content"] })
        
        chatPrompt = ChatPromptTemplate.from_messages(
            [
                ("system", history[0]["content"]),
                MessagesPlaceholder(variable_name="history"),
                ("human", "{input}"),
            ]
        )
        
        llm = ChatOllama(model=model, base_url = base_url)
        
        
        chain = ConversationChain(
            llm=llm, 
            memory=chatPromptMemory,
            prompt=chatPrompt,
            verbose=False
        )
        
        return chain.invoke({"input":prompt}, config=config)['response']
    finally:
        if stream:
            g.close()


def chain(model, history, prompt, base_url, stream):
    history = json.loads(history)
    if stream:
        g = ThreadedGenerator()
        threading.Thread(target=llm_thread, args=(g, model, history, prompt, stream)).start()
        return g
    return llm_thread(None, model, history, prompt, base_url, stream)

async def retrieve(query: str, collection: str, vector_host: str, vector_port: int, model_url: str, model: str) -> list:
    print("> Retriever Called.............")
    #print((query, collection, vector_host, vector_port, model_host, model_port, model))
    chroma_client = chromadb.HttpClient(host = vector_host, port = vector_port)
    embeddings = OllamaEmbeddings(model = model,  base_url = model_url)
    vectore_store = Chroma(
        embedding_function = embeddings,
        client = chroma_client,
        collection_name = collection
    )
    cross_encoder = CrossEncoder('cross-encoder/ms-marco-MiniLM-L-6-v2')
    
    # get relevant contexts from chroma using bi-encoder method
    res = vectore_store.similarity_search(query = query, k = 10)
    chunks = [x.page_content for x in res]
    
    # rerank and only keep top 3 chunks using more accurate, cross-encoder method
    pairs = []
    for doc in chunks:
        pairs.append([query, doc])
    scores = cross_encoder.predict(pairs)

    scored_docs = zip(scores, chunks)
    sorted_docs = sorted(scored_docs, reverse=True)[:3] # grab top 3
        
    # get list of retrieved texts
    reranked_chunks = [doc for _, doc in sorted_docs]
    return reranked_chunks

async def rag(model: str, history: str, query: str, model_url: str, contexts: list) -> str:
    print("> RAG Called.............")  # we'll add this so we can see when this is being used
    
    context_str = "\n".join(contexts)
    
    # place query and contexts into RAG prompt
    prompt = "Contexts: " + context_str + " \n Query: " + query
    
    return chain(model, history, prompt, model_url, False)

config = RailsConfig.from_path("./data")

# Define an async function that contains your current async logic
async def async_scoreModel(prompt, system, history, model, embedder, collection, host, model_port, vector_port):
    llm = ChatOllama(model=model, base_url=f'http://{host}:{model_port}')
    rag_rails = LLMRails(config, llm=llm, verbose=False)
    messages = [
        {"role": "system", "content": system},
        {"role": "context", "content": {"collection": collection, "vector_host": host, "vector_port": vector_port, "model_url": f'http://{host}:{model_port}', "embedder": embedder, "model": model, "history": history}},
        {"role": "user", "content": prompt}
    ]
    resp = await rag_rails.generate_async(messages=messages)
    return resp["content"]

# Modify the scoreModel function to be synchronous by using ThreadPoolExecutor to run the asynchronous code
def scoreModel(prompt, system, history, model, embedder, collection, host, model_port, vector_port):
    "Output: response"
    if isinstance(prompt, pd.Series):
        prompt, system, history, model, embedder, collection, host, model_port, vector_port = prompt[0], system[0], history[0], model[0], embedder[0], collection[0], host[0], model_port[0], vector_port[0]
        
    # Use ThreadPoolExecutor to run the async function in a separate thread
    with ThreadPoolExecutor() as executor:
        # Wrap async function call with asyncio.run() within the executor
        future = executor.submit(
            asyncio.run,
            async_scoreModel(prompt, system, history, model, embedder, collection, host, model_port, vector_port)
        )
        return pd.DataFrame({"response": [future.result()]})
