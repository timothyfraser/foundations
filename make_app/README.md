# README

---

📦 Intro & Project Description

# Interoperable Shiny & API Demo (mtcars Viewer)

This project demonstrates **interoperable frontends and backends** for a simple `mtcars` data viewer:

- Built-in filtering by number of cylinders and gears
- Outputs:
  - Row count (`renderText`)
  - Scatterplot of MPG vs Horsepower (`renderPlot`)
  - Previous row count using reactive memory

Each frontend app (R Shiny or Python Shiny) can be connected to either backend API (Plumber or FastAPI) using the **same API interface**:  
`GET /filter?cyl=<int>&gear=<int>`

---


---

🧱 Folder Structure

## 📁 Folder Structure

. ├── plumber.R          # R Plumber API (backend) ├── main.py            # Python FastAPI (backend) ├── app_r_local.R      # R Shiny app (local mtcars) ├── app_r_api.R        # R Shiny app (API-driven) ├── app_py_local.py    # Python Shiny app (local mtcars) ├── app_py_api.py      # Python Shiny app (API-driven) └── README.md

---


---

🔗 API Specification

## 🔗 API Specification

All backend APIs (Plumber or FastAPI) must implement:

**Endpoint:**

GET /filter?cyl=<int>&gear=<int>

**Returns:**
```json
[
  {
    "mpg": 22.8,
    "cyl": 4,
    "disp": 108.0,
    "hp": 93,
    ...
  },
  ...
]

Notes:

Response is a list of dictionaries/rows

No authentication required



---

---

### 🚀 Running the Apps

```markdown
## 🚀 How to Run the Apps

### 1. Run the Backend

#### Option A: R Plumber
```r
# plumber.R
library(plumber)
r <- plumb("plumber.R")
r$run(port = 8000)

Option B: Python FastAPI

uvicorn main:app --reload --port 8000


---

2. Run the Frontend

A. R Shiny (local)

shiny::runApp("app_r_local.R")

B. R Shiny (API)

shiny::runApp("app_r_api.R")  # expects backend at localhost:8000

C. Python Shiny (local)

shiny run --reload app_py_local.py

D. Python Shiny (API)

shiny run --reload app_py_api.py  # expects backend at localhost:8000


---

---

### 🔁 Interoperability Matrix

```markdown
## 🔁 Interoperability Matrix

You can combine any frontend with any backend.

| Frontend        | Backend       | Works? | Notes                      |
|-----------------|---------------|--------|----------------------------|
| R Shiny         | R Plumber     | ✅     | All in R                  |
| R Shiny         | Python FastAPI| ✅     | Compatible endpoint       |
| Python Shiny    | R Plumber     | ✅     | Requires HTTP request     |
| Python Shiny    | Python FastAPI| ✅     | Native integration        |


---

