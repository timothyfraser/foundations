# foundations

*Course repository for SYSEN 5151: Foundations of Systems Engineering at Cornell University*

This repository contains starter materials and scaffolding for Foundations of Systems Engineering. Students will build end-to-end skills for modern systems development by completing exercises in four key areas, each located in a separate folder.

You may use Python, R, or another language/framework of your choosing. Lessons and starter code will be provided in R and/or Python. You may even mix and match at times, writing an API in python and an App in R, etc.

---

# 🔍 1. Query a Database

Learn how to retrieve data from dynamically updated databases, eg. Google Sheets, SQLite, MySQL, PostgreSQL, etc.

You'll write scripts that connect, retrieve, and clean the data for further use. Our examples will focus on Google Sheets, due to its ease of use.

---

# 🤖 2. Query a Generative AI Model

Learn to interact with LLM APIs. Choose from:

| Option | Setup Difficulty | Cost | Notes |
|--------|------------------|------|-------|
| **Meta's LLaMA** | Harder | Free | Open-source, but you'll need to configure models yourself |
| **OpenAI/Gemini APIs** | Easy | Paid per call | Students must pay per call — this is your textbook cost. Requires a credit card. 

---

# 🔌 3. Run a REST API

Connect your data and models through a local or hosted REST API:

| Language | Framework | Description |
|----------|-----------|-------------|
| **Python** | FastAPI | Modern, fast web framework for building APIs |
| **R** | `plumber` | R package for creating web APIs |

This is the bridge between your data logic and front-end or other systems.

---

# 💻 4. Show the Results in a Front-End App

You'll design a simple front-end interface to display or interact with results. Options include:

| Option | Difficulty | Performance | Best For |
|--------|------------|-------------|----------|
| **ShinyApps** | Easy | Less performant | Quick prototypes |
| **'Reporter' static site** | Easiest | Fast | Simple documentation |
| **Command-line chatbot** | Mid-level | Fast | Backend-focused projects |
| **ReactJS app** | Most work | High performance | Public-facing projects with polish |

---

# 📁 Repository Structure

```
/foundations/
├── 01_query_database/
├── 02_query_ai_model/
├── 03_rest_api/
├── 04_frontend_app/
└── README.md
```

Each folder contains a standalone mini-project. You're encouraged to explore alternate tools and integrate components together as your final system.

---

# 🚨 Requirements

| Requirement | Type | Notes |
|-------------|------|-------|
| Basic knowledge of R or Python | Required | Core programming skills |
| Google account for Google Sheets access | Required | For database exercises |
| Credit card for API usage (if using OpenAI/Gemini) | Required | Textbook cost equivalent |
| GitHub account, local dev environment | Recommended | For version control and development |

---

# 💬 Questions?

Reach out via Canvas or use EdDiscussion. You're not expected to know everything upfront — the point is to **try**, **fail**, **fix**, and **learn**!


