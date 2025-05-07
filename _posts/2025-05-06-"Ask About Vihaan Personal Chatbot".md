---
layout: post
title: 'Build a Personal Chatbot to Answer Questions About Yourself'
author: Vihaan Akshaay
tags: ['dev-log']
date: '2025-05-06 20:45:23 +0530'
category: Notes
summary: On how to build a personal chatbot to answer questions about yourself.
thumbnail: landslide.png
---

#### Chatter:
I guess this is going to be one of my first as well as entry level NLP projects. So, I'll keep it SUPER short and to the point.
Collect a bunch of pdfs you want the model to use, 

1) make chunks and vectorize them
2) convert query to vector, find most similar vector (of chunk) and get the chunk
3) input to model: query, good chunks; output: answer

DONE!
So let's dive in. I promise you, the slow step is going to be collecting the pdfs!!!

# Setups!
itemize
- data: put all pdfs in docs/ 
- accounts:
    - openai {for embeddings and model}: get OPENAI_API_KEY 
    - pinecone {for vector database of chunks}: get PINECONE_API_KEY; create a new index with the name "<your-name>-chatbot", and choose 'text-embedding-3-small' as the vector model (dimension should be 1536)
    - fork this repo: https://github.com/VihaanAkshaay/Vihaan-chatbot-api and change index name in embed_pdfs.py to "<your-name>-chatbot"
    - move docs/ to the forked repo
    - create render account (to host the app) and open a new web service (choose this forked repo)

# Steps!
0.1) create python env from requirements.txt

```
python -m venv venv \
source venv/bin/activate \
pip install -r requirements.txt
```

0.2) add OPENAI_API_KEY and PINECONE_API_KEY to your .zshrc file or .bashrc file to use it when you run the code.

```
export OPENAI_API_KEY="your_openai_api_key"
export PINECONE_API_KEY="your_pinecone_api_key"
```

1) run embed_pdfs.py

```
python embed_pdfs.py
```

What this does: 
    - embeds all pdfs in data/ and saves the embeddings in data/embeddings/
    - This particular code first chunks the pdfs, then uses "text-embedding-ada-002" to embed (ie create a vector to represent) each chunk to a pinecone vector database.

2) Create a render session
    - go to https://dashboard.render.com/
    - create a new web service
    - connect to github repo (potentially your fork of https://github.com/VihaanAkshaay/Vihaan-chatbot-api)
    - set env variables (add your OPENAI_API_KEY and PINECONE_API_KEY to the environment variables on the render dashboard)
    - add built command: ```pip install -r requirements.txt```
    - add start command : ```uvicorn app:app --host=0.0.0.0 --port=8000```
    - add instance type: free
    - add region: us-east-1
    - create session/deploy

What this does:
    - this acts as a host for the app, whenever you add a query, it will be sent to app here which is hosted on render.
    - the app will create a vector of your query and find the most similar vector in the pinecone vector database.
    - it will then use the most similar vector to **retrieve** the most relevant chunk from the pinecone vector database.
    - it will then add (**augment**) this chunk to the input of the model along with the query and ask the model to produce (**generation**) an answer.
    - THERE YOU GO! your chatbot (and probably your very first RAG application) is ready!

3) Test it out!
    - get the url of the app from the render dashboard
    - use the url to test the app (replace the example-api.onrender.com with your own url)

    ```
    curl -X POST https://example-api.onrender.com/query \
     -H "Content-Type: application/json" \
     -d '{"query": "What can you do?"}'
    ```

    - feel free to make a small chatbot on your own website and use this app as the backend!!! 



### Caution.
- This works bad, and definitely can be improved.

Example: 

```
    You: Does Vihaan know C++?
    Agent: I don\’t have that information in my current knowledge.

    You: Does he know C++?
    Agent: Yes, Vihaan Akshaay is proficient in C++17.
```

So yeah, don't expect this to impress the recruiter that's checking your portfolio to be impressed so much, that they'll be head over heels in love with you.
But yes, once you have this pipeline setup, you can work on improving it. Good luck!

