# README `/api2py`

## API2PY: FastAPI Backend for mtcars

This folder contains a simple REST API built with Python's FastAPI. It serves filtered data from the classic `mtcars` dataset.

## Purpose
- Provides a `/filter` endpoint to return rows from `mtcars.csv` matching the requested number of cylinders (`cyl`) and gears (`gear`).
- Can be used as a backend for any frontend app (R Shiny, Python Shiny, etc.) that needs filtered car data.

## Folder Contents
- `app.py` — Main FastAPI app. Defines the `/filter` endpoint.
- `mtcars.csv` — The dataset served by the API.
- `run.sh` — Bash script to start the API using `uvicorn`.
- `testme.sh` — Script to test the API with a sample `curl` request.
- `README.md` — This file.

## How to Run
1. **Install dependencies:**
   - Open Git Bash in this folder and run:
     ```bash
     pip install fastapi uvicorn pydantic pandas
     ```
2. **Start the API:**
   - Run:
     ```bash
     bash run.sh
     ```
   - The API will be available at [http://localhost:8000/filter](http://localhost:8000/filter)

3. **Test the API:**
   - In a new terminal, run:
     ```bash
     bash testme.sh
     ```

## Dependencies
- Python 3.8+
- fastapi
- uvicorn
- pydantic
- pandas

---
For more details, see the main project README.

