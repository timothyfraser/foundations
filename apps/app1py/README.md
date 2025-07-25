# README `/app1py`

# APP1PY: Python Shiny Frontend (Local Data)

This folder contains a simple interactive web app built with Python's Shiny framework. It loads and filters the classic `mtcars` dataset locally (no API required).

## Purpose
- Lets users select number of cylinders and gears, then displays:
  - Row count of filtered cars
  - Scatterplot of MPG vs Horsepower
  - Previous row count
- Demonstrates a standalone Python Shiny app using local data.

## Folder Contents
- `app.py` — Main Shiny app. Loads and filters data locally.
- `run.sh` — Bash script to start the app.
- `README.md` — This file.

## How to Run
1. **Install dependencies:**
   - Open Git Bash in this folder and run:
     ```bash
     pip install shiny pandas matplotlib
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

---
For more details, see the main project README. 