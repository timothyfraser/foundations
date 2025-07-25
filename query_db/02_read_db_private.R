# 02_read_db_private.R

# R script to read in a private Google Sheet, with authentification
# Note: there is not currently a very easy way in Python to authenticate with Google; it requires several steps. So, if you want to do this, I suggest you use R for ease.


# If you haven't installed these packages...
# install.packages(c("googlesheets4", "dplyr", "readr"))

# Load required packages
library(googlesheets4)
library(dplyr)
library(readr)

# ---- Step 1: Authenticate ----
# Will prompt to open a browser and log into Google (first time only)
gs4_auth()

# ---- Step 2: Define Sheet URL ----
# Replace this with the actual URL of the private shared Google Sheet
sheet_url = "https://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/edit?usp=sharing"

# Optional: specify a worksheet/tab name
sheet_name = "responses"  # or leave blank to use the first sheet

# ---- Step 3: Read the Sheet ----
df = read_sheet(sheet_url, sheet = sheet_name)

# Notice that our column names are very untidy? Let's rename them
glimpse(df)

# ---- Step 4: Clean and View ----
df_clean = df %>%
  # rename columns
  select(timestamp = 1, type = 2, satisfaction = 3, failed = 4, date_failed = 5) %>%
  # remove any blank rows (eg. missing a timestamp)
  filter(!is.na(timestamp))

# Preview structure
glimpse(df_clean)

# ---- Step 5: Save Local Copy ----
write_csv(df_clean, "query_db/responses.csv")


# ---- Step 6: Test Read the Data ---
data = read_csv("query_db/responses.csv")

# Cleanup!
rm(list = ls())