#!/bin/bash

# Local .bashrc for this repository
# This file contains project-specific bash configurations

# Add Ollama to PATH for this project
export PATH="$PATH:/c/Users/tmf77/AppData/Local/Programs/Ollama"

# Ollama environment variables
# Set the host and port for Ollama API
export OLLAMA_HOST="127.0.0.1:11435"
# Allow all origins (useful for web interfaces)
export OLLAMA_ORIGINS="*"
# Set the models directory
# export OLLAMA_MODELS="/path/to/your/models"
# Enable debug logging
export OLLAMA_DEBUG=1

# You can add other project-specific configurations here
# For example:
# export PROJECT_ROOT="$(pwd)"
# export PYTHONPATH="$PROJECT_ROOT:$PYTHONPATH"

echo "✅ Local .bashrc loaded - Ollama is now available as 'ollama' command"
echo "   OLLAMA_HOST set to: $OLLAMA_HOST" 