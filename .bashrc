#!/bin/bash

# Local .bashrc for this repository
# This file contains project-specific bash configurations

# =============================================================================
# OLD WINDOWS ENVIRONMENT SETTINGS (COMMENTED OUT)
# =============================================================================

# Add LM Studio to PATH for this project (Windows - tmf77 user)
# export PATH="$PATH:/c/Users/tmf77/.lmstudio/bin"
# alias lms='/c/Users/tmf77/.lmstudio/bin/lms.exe'

# Add R to your Path for this project (Windows - tmf77 user)
# export PATH="$PATH:/c/Program Files/R/R-4.4.1/bin"
# alias Rscript='/c/Program Files/R/R-4.4.1/bin/Rscript.exe'
# Add R libraries to your path for this project (Windows - tmf77 user)
# export R_LIBS_USER="/c/Users/tmf77/AppData/Local/R/win-library/4.2"

# Add Python to your Path for this project (Windows - tmf77 user)
# export PATH="$PATH:/c/Python312"
# alias python='/c/Python312/python.exe'

# Add uvicorn to your Path for this project - if using Python for APIs (Windows - tmf77 user)
# export PATH="$PATH:/c/Users/tmf77/AppData/Roaming/Python/Python312/Scripts"

# =============================================================================
# CURRENT MACOS ENVIRONMENT SETTINGS (ginayp user)
# =============================================================================

# Add LM Studio to PATH for this project (macOS - ginayp user)
export PATH="$PATH:/Users/<username>/.lmstudio/bin"
alias lms='/Users/<username>/.lmstudio/bin/lms'

# Add R to your Path for this project (macOS - ginayp user)
# R is typically installed via Homebrew or CRAN on macOS
# export PATH="$PATH:/usr/local/bin"  # Uncomment if R is installed via Homebrew
# export PATH="$PATH:/Library/Frameworks/R.framework/Resources/bin"  # Uncomment if R is installed via CRAN

# Add Python to your Path for this project (macOS - ginayp user)
# Python is typically already in PATH on macOS
# If using pyenv or custom Python installation, uncomment and modify:
# export PATH="$PATH:/usr/local/bin"
# export PATH="$PATH:/opt/homebrew/bin"

# Add uvicorn to your Path for this project - if using Python for APIs (macOS - ginayp user)
# If using pipx or custom installation:
# export PATH="$PATH:/Users/ginayp/.local/bin"

echo "✅ Local .bashrc loaded."