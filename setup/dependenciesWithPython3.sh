#!/bin/bash

# dependencies.sh

# Installs all R and python3 dependencies for this repository
# Run this script from the project root: bash setup/dependencies.sh

# --- SYSTEM DEPENDENCIES ---
# python3 and R must be installed manually on Windows.
# Download python3: https://www.python3.org/downloads/
# Download R: https://cran.r-project.org/bin/windows/base/
# (Recommended: python3 3.12, R 4.4.1)

# --- python3 DEPENDENCIES ---
# Ensure python3 is available
python3 --version || echo "⚠️ python3 not found. Please install python3 manually."


# --- PIP INSTALLATION (if missing) ---
# Try to install pip if not found
if ! command -v pip &> /dev/null; then
  echo "⚠️ pip not found. Attempting to install pip..."
  # Download get-pip.py
  curl -O https://bootstrap.pypa.io/get-pip.py
  # Try to use python3 to install pip
  python3 get-pip.py
  # Clean up
  rm get-pip.py
  # Re-check pip
  pip3 --version || echo "❌ pip installation failed. Please install pip manually: https://pip.pypa.io/en/stable/installation/"
else
  echo "✅ pip is already installed."
fi

# Ensure pip is available
pip3 --version || echo "⚠️ pip not found. Please ensure pip is installed."

# Install python3 packages
pip3 install --upgrade pip
pip3 install fastapi uvicorn pydantic pandas requests matplotlib shiny

# --- R DEPENDENCIES ---
# Ensure R is available
R --version || echo "⚠️ R not found. Please install R manually."

# Install R packages (run in R)
R -q -e 'install.packages(c(
  "shiny", "plumber", "jsonlite", "httr", "httr2", "dplyr", "readr", "googlesheets4"
), repos="https://cloud.r-project.org")'

# --- DONE ---
echo "✅ All dependencies installation commands have been run. If you see errors above, please install python3 and R manually first."

