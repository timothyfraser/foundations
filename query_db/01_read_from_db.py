# ✅ Recommended Setup (Pure OAuth, No Credentials File)
# !pip install pygsheets pandas

# 📄 load_shared_sheet.py (No credentials file, just login)

import pygsheets
import pandas as pd

# ---- Step 1: Authorize with your Google account ----
# Will open a browser and ask you to log in to your Google account
gc = pygsheets.authorize(local=True)  # This triggers interactive login

# ---- Step 2: Open shared private Google Sheet ----
# Sheet must be explicitly shared with your Google account
sheet_url = "https://docs.google.com/spreadsheets/d/your-sheet-id-here"
sh = gc.open_by_url(sheet_url)

# ---- Step 3: Select worksheet/tab ----
wks = sh.worksheet_by_title("Data")  # or use .sheet1 for first tab

# ---- Step 4: Load data into DataFrame ----
df = wks.get_as_df()

# Optional: Clean up column names
df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")

# ---- Step 5: Preview and save ----
print(df.head())
df.to_csv("local_copy.csv", index=False)
