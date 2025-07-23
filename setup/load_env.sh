#!/bin/bash

# load_env.sh - Load local environment configuration

echo "🔄 Loading local environment configuration..."

# Source the local .bashrc
if [ -f "../.bashrc" ]; then
    source ../.bashrc
    echo "✅ Local .bashrc loaded successfully"
else
    echo "⚠️  Local .bashrc not found. Creating one..."
    
    # Create local .bashrc if it doesn't exist
    cat > ../.bashrc << 'EOF'
# Local .bashrc for this repository
# This file contains project-specific bash configurations

# Add Ollama to PATH for this project
# Note: This is the path to my local installation of Ollama. You may need to change this to the path to your local installation of Ollama.
export PATH="$PATH:/c/Users/tmf77/AppData/Local/Programs/Ollama"

# You can add other project-specific configurations here
# For example:
# export PROJECT_ROOT="$(pwd)"
# export PYTHONPATH="$PROJECT_ROOT:$PYTHONPATH"

echo "✅ Local .bashrc loaded - Ollama is now available as 'ollama' command"
EOF
    
    source .bashrc
    echo "✅ Local .bashrc created and loaded"
fi

echo "🎯 You can now use 'ollama' commands directly!"
echo "   Try: ollama --version" 
