# 01_read_from_db.R

# R script to read in a PUBLIC, VIEWABLE Google Sheet as CSV
# Only uses dplyr and readr (no authentication required)

# Load required packages
library(dplyr)
library(readr)

# ---- Step 1: Define the CSV download link ----
# This must be a public Google Sheet link, formatted as /export?format=csv
path = "http://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/export?format=csv&gid=317348432"

# ---- Step 2: Read the CSV from the URL ----
df = read_csv(path)

# Preview structure
glimpse(df)

# ---- Step 4: Clean and View ----
df_clean = df %>%
  # rename columns
  select(timestamp = 1, type = 2, satisfaction = 3, failed = 4, date_failed = 5) %>%
  # remove any blank rows (eg. missing a timestamp)
  filter(!is.na(timestamp))

# ---- Step 5: Save Local Copy ----
write_csv(df_clean, "query_db/responses.csv")

# ---- Step 6: Test Read the Data ---
data = read_csv("query_db/responses.csv")

# Check result
glimpse(data)

# Cleanup!
rm(list = ls())
