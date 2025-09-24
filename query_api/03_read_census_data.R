# Load and explore the census data
library(dplyr)

# Read the RDS file
combined_data <- readRDS("combined_census_data.rds")

# Display structure of the data
cat("=== DATA STRUCTURE ===\n")
str(combined_data)

cat("\n=== CENSUS DATA OVERVIEW ===\n")
cat("Number of records in ny_census_data:", nrow(combined_data$ny_census_data), "\n")
cat("Number of counties:", length(unique(combined_data$ny_census_data$GEOID)), "\n")

cat("\n=== INCOME SUMMARY OVERVIEW ===\n")
cat("Number of counties in income data:", nrow(combined_data$income_summary), "\n")

cat("\n=== AGE SUMMARY OVERVIEW ===\n")
cat("Number of counties in age data:", nrow(combined_data$age_summary), "\n")

# Display first few rows of each dataset
cat("\n=== FIRST 5 ROWS OF CENSUS DATA ===\n")
print(head(combined_data$ny_census_data, 5))

cat("\n=== FIRST 5 ROWS OF INCOME SUMMARY ===\n")
print(head(combined_data$income_summary, 5))

cat("\n=== FIRST 5 ROWS OF AGE SUMMARY ===\n")
print(head(combined_data$age_summary, 5))

# Show some interesting statistics
cat("\n=== POPULATION STATISTICS ===\n")
total_pop_data <- combined_data$ny_census_data %>%
  filter(variable == "total_population") %>%
  arrange(desc(estimate))

cat("Top 5 counties by population:\n")
print(total_pop_data[1:5, c("NAME", "estimate")])

cat("\n=== INCOME STATISTICS ===\n")
# Calculate total households for each county
income_totals <- combined_data$income_summary %>%
  mutate(total_households = income_0_24999 + income_25000_49999 + income_50000_74999 + 
                           income_75000_99999 + income_100000_124999 + income_125000_149999 + 
                           income_150000_199999 + income_200000_or_more) %>%
  arrange(desc(total_households))

cat("Top 5 counties by total households:\n")
print(income_totals[1:5, c("NAME", "total_households")])

cat("\n=== AGE STATISTICS ===\n")
# Calculate total population for each county from age data
age_totals <- combined_data$age_summary %>%
  mutate(total_population = age_under_18 + age_18_34 + age_35_64 + age_65_and_over) %>%
  arrange(desc(total_population))

cat("Top 5 counties by total population (from age data):\n")
print(age_totals[1:5, c("NAME", "total_population")])

# Save readable versions as CSV files
cat("\n=== SAVING DATA AS CSV FILES ===\n")
write.csv(combined_data$ny_census_data, "census_data_readable.csv", row.names = FALSE)
write.csv(combined_data$income_summary, "income_summary_readable.csv", row.names = FALSE)
write.csv(combined_data$age_summary, "age_summary_readable.csv", row.names = FALSE)

cat("Data saved as:\n")
cat("- census_data_readable.csv\n")
cat("- income_summary_readable.csv\n")
cat("- age_summary_readable.csv\n")
