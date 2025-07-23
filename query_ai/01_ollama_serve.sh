#!/bin/bash

# 01_ollama_serve.sh
# This script kills any process running on Ollama's port before serving the model


# Load environment
if [ -f "../.bashrc" ]; then
    source ../.bashrc
elif [ -f ".bashrc" ]; then
    source .bashrc
fi

OLLAMA_PORT="11435"
OLLAMA_HOST="127.0.0.1"

echo "🔄 Preparing to serve Ollama model..."
echo "   Port: $OLLAMA_PORT"
echo "   Host: $OLLAMA_HOST"


# Make all helper scripts executable
chmod +x ../helpers/*.sh


# Kill any existing process on the port
../helpers/00_killport.sh -$OLLAMA_PORT


# Verify port is free
if check_port_free $OLLAMA_PORT; then
    echo ""
    echo "🚀 Starting Ollama server..."
    echo "   Press Ctrl+C to stop"
    echo ""
    
    # Start Ollama server
    ollama serve
else
    echo "❌ Could not free port $OLLAMA_PORT. Please check manually:"
    echo "   netstat -ano | grep :$OLLAMA_PORT"
    echo "   tasklist | grep ollama"
    echo ""
    echo "💡 Try stopping Ollama manually:"
    echo "   ollama stop"
    exit 1
fi 
