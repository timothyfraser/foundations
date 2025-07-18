# Load required packages
library(googlesheets4)
library(dplyr)
library(readr)
library(janitor)   # for clean_names()

# ---- Step 1: Authenticate ----
# Will prompt to open a browser and log into Google (first time only)
gs4_auth()

# ---- Step 2: Define Sheet URL ----
# Replace this with the actual URL of the private shared Google Sheet
sheet_url <- "https://docs.google.com/spreadsheets/d/your-sheet-id-here"

# Optional: specify a worksheet/tab name
sheet_name <- "Data"  # or leave blank to use the first sheet

# ---- Step 3: Read the Sheet ----
df <- read_sheet(sheet_url, sheet = sheet_name)

# ---- Step 4: Clean and View ----
df_clean <- df %>%
  clean_names() %>%
  filter(if_any(everything(), ~ !is.na(.)))  # remove fully blank rows

# Preview structure
glimpse(df_clean)

# ---- Step 5: Save Local Copy ----
write_csv(df_clean, "local_copy.csv")
