# READNE `/query_db`

## Querying a Continuously Updating Database with Google Sheets

This folder demonstrates how you can use Google Forms and Google Sheets to create a real, continuously updating database, and how to programmatically query it.

---

## Overview

- **Purpose:** Simulate a live product feedback database using Google Forms and Sheets.
- **Demo:** Users submit feedback via a Google Form. Responses are stored in a Google Sheet, which can be queried in real time as a CSV.
- **Use Case:** Track customer-reported reliability issues for insulin pumps over time.

---

## 1. The Feedback Form

This product feedback form collects user experiences with various insulin pumps, focusing on device type, failure history, and overall satisfaction. The form consists of four core questions: the model of pump used, whether it has ever failed, the date of most recent failure (if applicable), and a Likert-scale rating of satisfaction. 

- **Google Form Link:** [Product Feedback Survey](https://forms.gle/KcAkbKWzXJy79tXM8)
- **Prompt for User:**
  > "Thank you for taking a moment to share your experience with your insulin pump. Your feedback helps us improve device reliability and better support people living with diabetes. This short survey should take less than 2 minutes."
- **Questions Collected:**
  1. What type of insulin pump are you currently using?
  2. Overall, how satisfied are you with your insulin pump? (Likert scale)
  3. Has your pump ever failed or malfunctioned while you were using it?
  4. If yes, when did it most recently fail?

---

## 2. The Google Sheet Database

- **Sheet Link (View Only):** [Responses Sheet](https://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/edit?usp=sharing)
- **How it works:**
  - Every form submission creates a new row in the "responses" sheet.
  - The sheet is continually updated as new feedback arrives.

### Example Data

| Timestamp         | Type                              | Satisfaction | Failed | Date Failed |
|-------------------|-----------------------------------|--------------|--------|-------------|
| 7/25/2025 10:19:45| Medtronic MiniMed (600/700 series)| 5            | No     |             |
| 7/25/2025 10:19:54| Medtronic MiniMed (600/700 series)| 4            | No     |             |
| 7/25/2025 10:20:08| Medtronic MiniMed (600/700 series)| 4            | Yes    | 7/25/2025   |
| 7/25/2025 10:20:19| Medtronic MiniMed (600/700 series)| 3            | Yes    | 7/23/2025   |

---

## 3. Programmatic Access: Downloading the Data

You can access the latest responses as a CSV using a special download link:

- **CSV Download Link:**
  [Download responses as CSV](http://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/export?format=csv&gid=317348432)

### Anatomy of a Google Sheets Download Link

| Component | Example Value |
|-----------|--------------|
| base      | `http://docs.google.com/spreadsheets/d/` |
| doc_id    | `1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk` |
| action    | `/export?format=csv` |
| sheet_id  | `&gid=317348432` |

**Full Example:**
```
http://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/export?format=csv&gid=317348432
```

---

## 4. Sharing vs. Download Links

| Purpose         | Link Example |
|-----------------|-------------|
| **Share Link**  | [View Sheet](https://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/edit?usp=sharing) |
| **Download Link** | [Download CSV](http://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/export?format=csv&gid=317348432) |

**Share Link Structure:**
- Shares the entire document for viewing or editing.
- Format: `.../edit?usp=sharing`
- No `gid` (sheet id) required.

**Download Link Structure:**
- Downloads a specific sheet as CSV.
- Format: `.../export?format=csv&gid=...`
- Requires the `gid` of the sheet/tab.

---

## 5. Security Considerations

- **Public Access:**
  - This method requires the sheet to be publicly viewable (anyone with the link can view).
- **Private Alternatives:**
  - For sensitive data, use R or Python libraries to authenticate and download data securely (see [`02_read_db_private.R`](https://github.com/timothyfraser/foundations/tree/main/query_db/02_read_db_private.R)).
  - For beginners, it's EASIEST to do this in R. For Python, you'll have to set up your own Google Cloud Project and follow some extra steps if you hope to query a *private* sheet.

---

## 6. Files in This Folder

| File                  | Purpose |
|-----------------------|---------|
| [`01_read_db.py`](https://github.com/timothyfraser/foundations/tree/main/query_db/01_read_db.py)       | Python script to read the public Google Sheet as CSV |
| [`01_read_from_db.R`](https://github.com/timothyfraser/foundations/tree/main/query_db/01_read_from_db.R)   | R script to read the public Google Sheet as CSV (using dplyr/readr) |
| [`02_read_db_private.R`](https://github.com/timothyfraser/foundations/tree/main/query_db/02_read_db_private.R)| R script to read a private Google Sheet with authentication |
| [`responses.csv`](https://github.com/timothyfraser/foundations/tree/main/query_db/responses.csv)       | Example of downloaded/cleaned data |

---

## 7. References & Further Reading

- [Google Forms](https://www.google.com/forms/about/)
- [Google Sheets](https://www.google.com/sheets/about/)
- [Google Sheets API Documentation](https://developers.google.com/sheets/api)  