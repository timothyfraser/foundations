#!/bin/bash

# 00_your_first_query.sh

# Load your local paths and variables
source .bashrc

# Learn about the Command Line Interface
# https://lmstudio.ai/docs/cli

# Enable us to use the REST API without having to start LMSTUDIO
# https://lmstudio.ai/docs/app/api/headless

# Learn the endpoints and how to use them
# https://lmstudio.ai/docs/app/api/endpoints/rest

# First, open up LM Studio, select a model, and download it.
# Then, specify the model name here, assigning it to the variable 'MODEL'
MODEL="gemma-3-1b"

# Start the server on port 1234
lms server start --port 1234

# Check server status
lms server status

# Check available models on your system
curl http://localhost:1234/api/v0/models 

# Load a model (may take a moment)
lms load $MODEL

# Send your first CURL request to the model via REST API!
curl http://localhost:1234/api/v0/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma-3-1b",
    "messages": [
      { "role": "system", "content": "Always answer in rhymes." },
      { "role": "user", "content": "Introduce yourself." }
    ],
    "temperature": 0.7,
    "max_tokens": -1,
    "stream": false
  }'

# View the response in your terminal

# At end of session, unload any llm models
lms unload --all

# Close down the service
lms server stop