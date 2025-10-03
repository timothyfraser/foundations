#!/usr/bin/env bash
# 01_startup_ollama.sh
# Starts Ollama, ensures the model is present, then runs your R/Python workflow.

set -euo pipefail

# Optional: project .bashrc (paths, virtualenvs, etc.)
if [ -f ".bashrc" ]; then
  # shellcheck disable=SC1091
  source .bashrc
fi

# --- CONFIG ---
MODEL="gemma3:1b"
PORT="11434"                            # Ollama's default REST port
export OLLAMA_HOST="127.0.0.1:${PORT}"  # Bind + port (change if needed)

# 1) Ensure model is available (idempotent)
ollama pull "$MODEL"

# 2) Start server in background if not already running
if ! pgrep -f "ollama serve" >/dev/null 2>&1; then
  nohup ollama serve >/tmp/ollama.log 2>&1 &
  # Wait for health
  for i in {1..30}; do
    if curl -s "http://localhost:${PORT}/api/tags" >/dev/null; then
      break
    fi
    sleep 1
  done
fi

# 3) (Optional) Warm up the model (first token is faster later)
curl -s -X POST "http://localhost:${PORT}/api/chat" \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"${MODEL}\",\"messages\":[{\"role\":\"user\",\"content\":\"ping\"}],\"stream\":false}" >/dev/null || true

# 4) Run ONE of your workflows

# Option A: Python
python query_ai/01_workflow_ollama.py

# Option B: R
# R -q -e 'source("query_ai/01_workflow.R")'

# 5) (Optional) Stop server when done (comment out if you want it to keep running)
# pkill -f "ollama serve" || true