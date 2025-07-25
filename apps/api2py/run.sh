#!/bin/bash

# run.sh

# Run FastAPI with Python in app.py

# If you haven't installed these dependencies yet, go ahead and install them in a git bash terminal
# !pip install uvicorn fastapi pydantic typing pandas 

# Get the github repository's main directory path
FOLDER="$(git rev-parse --show-toplevel)" && \
    # Set working directory to apps/app2py
    cd "$FOLDER/apps/api2py" && \
    # Launch app with uvicorn
    uvicorn app:app --reload --port 8000