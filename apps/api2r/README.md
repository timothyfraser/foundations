# README `/api2r`
## API2R: Plumber API Backend for mtcars

This folder contains a simple REST API built with R's `plumber` package. It serves filtered data from the classic `mtcars` dataset.

## Purpose
- Provides a `/filter` endpoint to return rows from `mtcars.csv` matching the requested number of cylinders (`cyl`) and gears (`gear`).
- Can be used as a backend for any frontend app (R Shiny, Python Shiny, etc.) that needs filtered car data.

## Folder Contents
- `app.R` — Main Plumber API script. Defines the `/filter` endpoint.
- `run.R` — Example code to start the API in R.
- `README.md` — This file.

## How to Run
1. **Install dependencies:**
   - In R, run:
     ```r
     install.packages(c("plumber", "jsonlite", "dplyr", "readr"))
     ```
2. **Start the API:**
   - In R console, run:
     ```r
     source("app.R")
     # or, if using run.R:
     source("run.R")
     ```
   - The API will be available at [http://localhost:8000/filter](http://localhost:8000/filter)

## Dependencies
- R (4.0+ recommended)
- plumber
- jsonlite
- dplyr
- readr

---
For more details, see the main project README. 