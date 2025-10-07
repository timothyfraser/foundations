#!/bin/bash

# run.sh

# This script runs the LLM service, kicks off the API, and then runs the app.

# This script is run from the project root folder, eg. foundations/




# Load your local paths and variables, if necessary
# source .bashrc

# SELECT MODEL
MODEL="google/gemma-3-1b"

# Get the model (may take a moment)
lms get $MODEL

# Load a model (may take a moment)
lms load $MODEL

# Start the server on port 1234
lms server start --port 1234

# Start the API in Rs
R -q -e "print('Starting API in R'); source('example_project/api/run.R')"

# Start the App in R
R -q -e "print('Starting App in R'); source('example_project/app/app.R')"

# Close down the service (if desired)
# lms server stop

# At end of session, unload any llm models (if desired)
# lms unload --all
