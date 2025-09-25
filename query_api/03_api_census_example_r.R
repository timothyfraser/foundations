#install.packages("censusapi")
#install.packages("tidycensus")
library(dplyr)
library(tidycensus)

# Set Census API Key (only required once)
# Request Census API Key at https://api.census.gov/data/key_signup.html
census_api_key("Your_Census_API_Key", install = TRUE, overwrite = TRUE)

# Define variables for census data retrieval
variables <- c(
  total_population = "B01003_001",  
  
  Not_Hispanic_or_Latino_Population= "B03002_002",
  Hispanic_or_Latino_Population = "B03002_012",
  
  population_by_race_White = "B02001_002", 
  population_by_race_Black_or_African_American = "B02001_003",
  population_by_race_American_Indian_and_Alaska_Native = "B02001_004",
  population_by_race_Asian = "B02001_005",
  population_by_race_Native_Hawaiian_and_Other_Pacific_Islander = "B02001_006",
  
  median_income = "B19013_001",       # Median household income
  
  population_by_gender_male = "B01001_002", # Male population (use B01001_026 for Female)
  population_by_gender_female= "B01001_026",
  
  
  White_alone_Not_Hispanic_or_Latino_Population = "B03002_003",
  Black_or_African_American_Not_Hispanic_or_Latino_Population = "B03002_004",
  American_Indian_and_Alaska_Not_Native_Hispanic_or_Latino_Population = "B03002_005",
  Asian_Not_Hispanic_or_Latino_Population = "B03002_006",
  Native_Hawaiian_and_Other_Pacific_Islander_Not_Latino_Population = "B03002_007",
  
  
  Asian_Hispanic_or_Latino_Population = "B03002_016",
  White_alone_Hispanic_or_Latino_Population = "B03002_013",
  Black_or_African_American_Hispanic_or_Latino_Population = "B03002_014",
  American_Indian_and_Alaska_Native_Hispanic_or_Latino_Population = "B03002_015",
  Native_Hawaiian_and_Other_Pacific_Islander_Latino_Population = "B03002_017"
)

# Get census data for New York State (NY)
ny_census_data <- get_acs(
  geography = "county",
  variables = variables,
  state = "36",
  year = 2022,    # Specify the year
  survey = "acs5" # 5-year ACS survey
)


# Define ACS Income Variables (B19001 - Household Income)
income_vars <- c(
  # $0 - $24,999 (B19001_002 to B19001_005)
  "B19001_002", "B19001_003", "B19001_004", "B19001_005",
  
  # $25,000 - $49,999 (B19001_006 to B19001_010)
  "B19001_006", "B19001_007", "B19001_008", "B19001_009", "B19001_010",
  
  # $50,000 - $74,999 (B19001_011 to B19001_012)
  "B19001_011", "B19001_012",
  
  # $75,000 - $99,999 (B19001_013)
  "B19001_013",
  
  # $100,000 - $124,999 (B19001_014)
  "B19001_014",
  
  # $125,000 - $149,999 (B19001_015)
  "B19001_015",
  
  # $150,000 - $199,999 (B19001_016)
  "B19001_016",
  
  # $200,000 or more (B19001_017)
  "B19001_017"
)


# Fetch ACS 2022 5-Year Estimates for Income Breakdown
income_data <- get_acs(
  geography = "county",  # County-level data
  variables = income_vars,  # Use defined income breakdown variables
  state = "36",           # New York (Change this for other states)
  year = 2022,            # ACS 2022 (5-Year Estimates)
  survey = "acs5"         # Use ACS 5-Year Estimates
)


# Group and Summarize Household Income Data
income_summary <- income_data %>%
  group_by(GEOID, NAME) %>%
  summarise(
    income_0_24999 = sum(estimate[variable %in% c("B19001_002", "B19001_003", "B19001_004", "B19001_005")]),
    income_25000_49999 = sum(estimate[variable %in% c("B19001_006", "B19001_007", "B19001_008", "B19001_009", "B19001_010")]),
    income_50000_74999 = sum(estimate[variable %in% c("B19001_011", "B19001_012")]),
    income_75000_99999 = sum(estimate[variable %in% c("B19001_013")]),
    income_100000_124999 = sum(estimate[variable %in% c("B19001_014")]),
    income_125000_149999 = sum(estimate[variable %in% c("B19001_015")]),
    income_150000_199999 = sum(estimate[variable %in% c("B19001_016")]),
    income_200000_or_more = sum(estimate[variable %in% c("B19001_017")])
  )






# Define ACS Variables for New Age Groups
age_vars <- c(
  # Under 18 (Male: 003-006, Female: 027-030)
  "B01001_003", "B01001_004", "B01001_005", "B01001_006",
  "B01001_027", "B01001_028", "B01001_029", "B01001_030",
  
  # 18-34 (Male: 007-012, Female: 031-036)
  "B01001_007", "B01001_008", "B01001_009", "B01001_010", "B01001_011", "B01001_012",
  "B01001_031", "B01001_032", "B01001_033", "B01001_034", "B01001_035", "B01001_036",
  
  # 35-64 (Male: 013-019, Female: 037-043)
  "B01001_013", "B01001_014", "B01001_015", "B01001_016", "B01001_017", "B01001_018", "B01001_019",
  "B01001_037", "B01001_038", "B01001_039", "B01001_040", "B01001_041", "B01001_042", "B01001_043",
  
  # 65 and over (Male: 020-025, Female: 044-049)
  "B01001_020", "B01001_021", "B01001_022", "B01001_023", "B01001_024", "B01001_025",
  "B01001_044", "B01001_045", "B01001_046", "B01001_047", "B01001_048", "B01001_049"
)

# Fetch ACS 2022 5-Year Estimates for Age Breakdown
age_data <- get_acs(
  geography = "county",  # Get data at the county level
  variables = age_vars,  # Use the defined age breakdown variables
  state = "36",          # State code for New York
  year = 2022,           # ACS 2022 (5-Year Estimates)
  survey = "acs5"        # Use ACS 5-Year Estimates
)


# Group and Summarize Age Data
age_summary <- age_data %>%
  group_by(GEOID, NAME) %>%
  summarise(
    age_under_18 = sum(estimate[variable %in% c(
      "B01001_003", "B01001_004", "B01001_005", "B01001_006",
      "B01001_027", "B01001_028", "B01001_029", "B01001_030")]),
    
    age_18_34 = sum(estimate[variable %in% c(
      "B01001_007", "B01001_008", "B01001_009", "B01001_010", "B01001_011", "B01001_012",
      "B01001_031", "B01001_032", "B01001_033", "B01001_034", "B01001_035", "B01001_036")]),
    
    age_35_64 = sum(estimate[variable %in% c(
      "B01001_013", "B01001_014", "B01001_015", "B01001_016", "B01001_017", "B01001_018", "B01001_019",
      "B01001_037", "B01001_038", "B01001_039", "B01001_040", "B01001_041", "B01001_042", "B01001_043")]),
    
    age_65_and_over = sum(estimate[variable %in% c(
      "B01001_020", "B01001_021", "B01001_022", "B01001_023", "B01001_024", "B01001_025",
      "B01001_044", "B01001_045", "B01001_046", "B01001_047", "B01001_048", "B01001_049")])
  )



# Combine all datasets into a list
combined_data <- list(
  ny_census_data = ny_census_data,
  income_summary = income_summary,
  age_summary = age_summary
)

# Save as a single RDS file
saveRDS(combined_data, file = "combined_census_data.rds")

print(combined_data$ny_census_data, n = 50)  # Show 100 rows
print(combined_data$income_summary, n = 50)
print(combined_data$age_summary, n = 50)

cat("\n=== SAVING DATA AS CSV FILES ===\n")
write.csv(combined_data$ny_census_data, "census_data_readable.csv", row.names = FALSE)
write.csv(combined_data$income_summary, "income_summary_readable.csv", row.names = FALSE)
write.csv(combined_data$age_summary, "age_summary_readable.csv", row.names = FALSE)

cat("Data saved as:\n")
cat("- combined_census_data.rds (R binary format)\n")
cat("- census_data_readable.csv (main census data)\n")
cat("- income_summary_readable.csv (income breakdown by county)\n")
cat("- age_summary_readable.csv (age distribution by county)\n")

#readRDS("combined_census_data.rds")