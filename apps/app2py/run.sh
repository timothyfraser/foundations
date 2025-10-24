#!/bin/bash

# run.sh

# Script to load shiny app

# Get the github repository's main directory path
FOLDER="$(git rev-parse --show-toplevel)" && \
    # Set working directory to apps/app2py
    cd "$FOLDER/apps/app2py" && \
    # Load the app
    shiny run --reload app.py --port 8010