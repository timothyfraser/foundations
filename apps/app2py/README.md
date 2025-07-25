# README `/app2py`
# APP2PY: Python Shiny Frontend (API-Driven)

This folder contains a simple interactive web app built with Python's Shiny framework. It fetches filtered car data from a backend API (such as FastAPI or Plumber).

## Purpose
- Lets users select number of cylinders and gears, then displays:
  - Row count of filtered cars
  - Scatterplot of MPG vs Horsepower
  - Previous row count
- Demonstrates how to connect a Python Shiny frontend to a REST API backend.

## Folder Contents
- `app.py` — Main Shiny app. Fetches data from the API and displays it interactively.
- `run.sh` — Bash script to start the app.
- `README.md` — This file.

## How to Run
1. **Install dependencies:**
   - Open Git Bash in this folder and run:
     ```bash
     pip install shiny pandas matplotlib requests
     ```
2. **Start the app:**
   - Run:
     ```bash
     bash run.sh
     ```
   - The app will open in your browser (usually at [http://localhost:8000](http://localhost:8000)).

## Dependencies
- Python 3.8+
- shiny
- pandas
- matplotlib
- requests

---
For more details, see the main project README. 