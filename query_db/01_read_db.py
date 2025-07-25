# 01_read_db.py

# Python script to read in a PUBLIC, VIEWABLE Google Sheet

# ✅ Recommended Setup
# !pip install pandas
# Import pandas
import pandas as pd

# Get download link - note: this must be specifically formatted as /export?format=csv; it is DIFFERENT from a share link. It also must be publicly viewable.
path = "http://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/export?format=csv&gid=317348432"

# Load in the CSV of the 'responses' sheet, using the download link with its specific sheet 'gid'
df = pd.read_csv(path)

# View the dataframe
df.head()

# Clean up the column names
df.columns = ['timestamp', 'type', 'satisfaction', 'failed', 'date_failed']

# Filter out any empty rows
df = df[  df.timestamp.notna()  ]

# Preview cleaned data
print(df.head())

# Write to csv
df.to_csv("query_db/responses.csv", index=False)

# Test read 
pd.read_csv("query_db/responses.csv")


# Clean up enviroment
globals().clear()
