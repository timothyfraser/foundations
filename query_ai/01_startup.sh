#!/bin/bash

# 01_startup.sh

# This script starts up your LLM service. 
# Must be run **before** workflow.py or workflow.R.

# This script is run from the project root folder, eg. foundations/

# Load your local paths and variables
source .bashrc

# SELECT MODEL
MODEL="gemma-3-1b"

# Load a model (may take a moment)
lms load $MODEL

# Start the server on port 1234
lms server start --port 1234

# Now run one of these scripts below, which queries your model!
# Pick one and comment the other out. Both are shown at the moment.

# Option 1: Run in Python 01_workflow.py
python query_ai/01_workflow.py

# OR

# Option 2: Run in R 01_workflow.R, quietly (-q) with this expression (-e), 
R -q -e 'source("query_ai/01_workflow.R")'

# Close down the service (if desired)
lms server stop

# At end of session, unload any llm models (if desired)
lms unload --all
