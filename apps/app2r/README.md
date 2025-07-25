# README `/app2r`
# APP2R: R Shiny Frontend (API-Driven)

This folder contains a simple interactive web app built with R's Shiny framework. It fetches filtered car data from a backend API (such as Plumber or FastAPI).

## Purpose
- Lets users select number of cylinders and gears, then displays:
  - Row count of filtered cars
  - Scatterplot of MPG vs Horsepower
  - Previous row count
- Demonstrates how to connect an R Shiny frontend to a REST API backend.

## Folder Contents
- `app.R` — Main Shiny app. Fetches data from the API and displays it interactively.
- `README.md` — This file.

## How to Run
1. **Install dependencies:**
   - In R, run:
     ```r
     install.packages(c("shiny", "httr", "jsonlite"))
     ```
2. **Start the app:**
   - In R console or RStudio, run:
     ```r
     shiny::runApp("app.R")
     ```
   - The app will open in your browser (usually at [http://localhost:8000](http://localhost:8000)).

## Dependencies
- R (4.0+ recommended)
- shiny
- httr
- jsonlite

---
For more details, see the main project README. 