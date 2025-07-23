#!/bin/bash

# activate.sh - Activate the project environment

echo "🔄 Activating project environment..."

# Source the local .bashrc
if [ -f ".bashrc" ]; then
    source .bashrc
    echo "✅ Environment activated! You can now use 'ollama' commands."
    echo "   Try: ollama --version"
else
    echo "❌ .bashrc file not found in current directory"
    echo "   Make sure you're in the project root directory"
fi 


# To run this entire script, run in the terminal:
# chmod +x setup/activate.sh && ./setup/activate.sh