# README `/app1r`

# R_APP1: R Shiny Frontend (Local Data)

This folder contains a simple interactive web app built with R's Shiny framework. It loads and filters the classic `mtcars` dataset locally (no API required).

## Purpose
- Lets users select number of cylinders and gears, then displays:
  - Row count of filtered cars
  - Scatterplot of MPG vs Horsepower
  - Previous row count
- Demonstrates a standalone R Shiny app using local data.

## Folder Contents
- `app.R` — Main Shiny app. Loads and filters data locally.
- `README.md` — This file.

## How to Run
1. **Install dependencies:**
   - In R, run:
     ```r
     install.packages("shiny")
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

---
For more details, see the main project README. 