#!/bin/bash

# Local .bashrc for this repository
# This file contains project-specific bash configurations

# Add LM Studio to PATH for this project (here's mine)
export PATH="$PATH:/c/Users/tmf77/.lmstudio/bin"
alias lms='/c/Users/tmf77/.lmstudio/bin/lms.exe'

# Add R to your Path for this project (here's mine)
export PATH="$PATH:/c/Program Files/R/R-4.4.1/bin"
alias Rscript='/c/Program Files/R/R-4.4.1/bin/Rscript.exe'
# Add R libraries to your path for this project (here's mine)
export R_LIBS_USER="/c/Users/tmf77/AppData/Local/R/win-library/4.2"

# Add Python to your Path for this project (here's mine)
export PATH="$PATH:/c/Python312"
alias python='/c/Python312/python.exe'

# Add uvicorn to your Path for this project - if using Python for APIs (here's mine)
export PATH="$PATH:/c/Users/tmf77/AppData/Roaming/Python/Python312/Scripts"

echo "✅ Local .bashrc loaded."