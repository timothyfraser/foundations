# foundations

*Course repository for SYSEN 5151: Foundations of Systems Engineering at Cornell University*

This repository contains starter materials and scaffolding for Foundations of Systems Engineering. Students will build end-to-end skills for modern systems development by completing exercises in several key areas, each located in a separate folder.

You may use Python, R, or another language/framework of your choosing. Lessons and starter code are provided in R and/or Python. You may even mix and match at times, writing an API in Python and an App in R, etc.

---

# 📁 Repository Structure & Quick Links

Below are the main components of this repository. Click any folder or script name to view it on GitHub.

- [setup/](https://github.com/timothyfraser/foundations/tree/main/setup) — **Setup Scripts & Instructions**
  - [dependencies.sh](https://github.com/timothyfraser/foundations/tree/main/setup/dependencies.sh) — Installs all R and Python dependencies
  - [README.md](https://github.com/timothyfraser/foundations/tree/main/setup/README.md) — Setup checklist

- [query_db/](https://github.com/timothyfraser/foundations/tree/main/query_db) — **Query a Live Database**
  - Scripts to read and clean data from a live Google Sheet (public or private)
  - [01_read_db.py](https://github.com/timothyfraser/foundations/tree/main/query_db/01_read_db.py) — Python example
  - [01_read_from_db.R](https://github.com/timothyfraser/foundations/tree/main/query_db/01_read_from_db.R) — R example
  - [02_read_db_private.R](https://github.com/timothyfraser/foundations/tree/main/query_db/02_read_db_private.R) — R (private sheet, with authentication)
  - [responses.csv](https://github.com/timothyfraser/foundations/tree/main/query_db/responses.csv) — Example data
  - See [query_db/README.md](https://github.com/timothyfraser/foundations/tree/main/query_db/README.md) for details.

- [query_api/](https://github.com/timothyfraser/foundations/tree/main/query_api) — **Query an API**
  - Example scripts for making API calls using curl, Python, and R
  - [01_example_curl.sh](https://github.com/timothyfraser/foundations/tree/main/query_api/01_example_curl.sh)
  - [02_example_python.py](https://github.com/timothyfraser/foundations/tree/main/query_api/02_example_python.py)
  - [02_example_r.R](https://github.com/timothyfraser/foundations/tree/main/query_api/02_example_r.R)
  - See [query_api/README.md](https://github.com/timothyfraser/foundations/tree/main/query_api/README.md) for usage.

- [query_ai/](https://github.com/timothyfraser/foundations/tree/main/query_ai) — **Query a Local LLM (AI Model)**
  - Scripts to run and query a local LLM (e.g., Gemma) via LM Studio
  - [00_your_first_query.sh](https://github.com/timothyfraser/foundations/tree/main/query_ai/00_your_first_query.sh)
  - [01_startup.sh](https://github.com/timothyfraser/foundations/tree/main/query_ai/01_startup.sh)
  - [01_workflow.py](https://github.com/timothyfraser/foundations/tree/main/query_ai/01_workflow.py)
  - [01_workflow.R](https://github.com/timothyfraser/foundations/tree/main/query_ai/01_workflow.R)
  - See [query_ai/README.md](https://github.com/timothyfraser/foundations/tree/main/query_ai/README.md) for setup and usage.

- [apps/](https://github.com/timothyfraser/foundations/tree/main/apps) — **Interoperable Shiny & API Demos**
  - See the [apps/README.md](https://github.com/timothyfraser/foundations/tree/main/apps/README.md) for the interoperability matrix and detailed usage.
  - Contains all frontend and backend mini-apps for the `mtcars` demo, including:

    - **Construct a REST API**
        - [api2py/](https://github.com/timothyfraser/foundations/tree/main/apps/api2py) — FastAPI backend ([app.py](https://github.com/timothyfraser/foundations/tree/main/apps/api2py/app.py))
        - [api2r/](https://github.com/timothyfraser/foundations/tree/main/apps/api2r) — R Plumber backend ([app.R](https://github.com/timothyfraser/foundations/tree/main/apps/api2r/app.R))

    - **Construct a Shiny App**
        - [app1py/](https://github.com/timothyfraser/foundations/tree/main/apps/app1py) — Python Shiny (local data) ([app.py](https://github.com/timothyfraser/foundations/tree/main/apps/app1py/app.py))
        - [app1r/](https://github.com/timothyfraser/foundations/tree/main/apps/app1r) — R Shiny (local data) ([app.R](https://github.com/timothyfraser/foundations/tree/main/apps/app1r/app.R))

    - **Build a Shiny App connected to an API**
        - [app2py/](https://github.com/timothyfraser/foundations/tree/main/apps/app2py) — Python Shiny (API-driven) ([app.py](https://github.com/timothyfraser/foundations/tree/main/apps/app2py/app.py))
        - [app2r/](https://github.com/timothyfraser/foundations/tree/main/apps/app2r) — R Shiny (API-driven) ([app.R](https://github.com/timothyfraser/foundations/tree/main/apps/app2r/app.R))


- [images/](https://github.com/timothyfraser/foundations/tree/main/images) — Images for documentation

---

## 🚀 Project Areas

### 1. Query a Database
Learn how to retrieve data from dynamically updated databases, e.g., Google Sheets, SQLite, MySQL, PostgreSQL, etc. See [query_db/](https://github.com/timothyfraser/foundations/tree/main/query_db).

### 2. Query a Generative AI Model
Learn to interact with LLM APIs, including local models (Gemma, LLaMA) and cloud APIs (OpenAI, Gemini). See [query_ai/](https://github.com/timothyfraser/foundations/tree/main/query_ai).

### 3. Build a REST API to Query Results
Connect your data and models through a local or hosted REST API. See [apps/](https://github.com/timothyfraser/foundations/tree/main/apps) for both Python (FastAPI) and R (plumber) examples.

### 4. Show Results in a Front-End App
Design a simple front-end interface to display or interact with results. See [apps/](https://github.com/timothyfraser/foundations/tree/main/apps) for Shiny (Python/R) examples.

---

# 🔁 Interoperability Matrix

See the [apps/README.md interoperability matrix](https://github.com/timothyfraser/foundations/tree/main/apps/README.md#-interoperability-matrix) for which frontends and backends are compatible.

---

# 🚨 Requirements

| Requirement | Type | Notes |
|-------------|------|-------|
| A PC, Mac, or Linux computer | Required | For running code |
| Basic knowledge of R or Python | Required | Core programming skills |
| Google account for Google Sheets access | Required | For database exercises |
| GitHub account, local dev environment | Recommended | For version control and development |

---

# 💬 Questions?

Reach out via Canvas or use EdDiscussion. You're not expected to know everything upfront — the point is to **try**, **fail**, **fix**, and **learn**!


