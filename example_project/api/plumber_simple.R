# plumber_simple.R

# Simplified Plumber API for Insulin Pump Data
# Uses local data instead of Google Sheets

# IMPORTANT: Change the working directory path below to match your system
# Replace "/Users/ginayp/foundations/example_project/api" with your actual path to this folder
setwd("/Users/ginayp/foundations/example_project/api")

# Load required packages
library(plumber, quietly = TRUE, warn.conflicts = FALSE)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(jsonlite, quietly = TRUE, warn.conflicts = FALSE)

#* @apiTitle Simplified REST API
#* @apiDescription Simplified REST API for Insulin Pump Data

# Create sample data instead of reading from Google Sheets
sample_data <- data.frame(
  timestamp = Sys.time() - runif(100, 0, 86400*30), # Random timestamps in last 30 days
  type = sample(c("Medtronic MiniMed (600/700 series)", "Omnipod 5", "Omnipod DASH", "Tandem t:slim X2"), 100, replace = TRUE),
  satisfaction = sample(1:10, 100, replace = TRUE),
  failed = sample(c("Yes", "No"), 100, replace = TRUE),
  date_failed = ifelse(runif(100) > 0.7, Sys.Date() - runif(100, 0, 30), NA)
)

# Available pump types
pump_types <- c(
  "Medtronic MiniMed (600/700 series)",
  "Omnipod 5", 
  "Omnipod DASH",
  "Tandem t:slim X2"
)

#* @get /pumps
#* Get list of available pump types
#* @response 200
function(){
  return(list(pumps = pump_types))
}

#* @get /summary
#* Get summary data for specified pump types
#* @param pumpid:[int] The id number(s) for the type(s) of pump, as an integer vector
#* @response 200
function(pumpid){
  # Convert the pumpid parameter to an integer vector
  pumpid <- as.integer(pumpid)
  
  # Filter data for selected pump types
  selected_pumps <- pump_types[pumpid]
  filtered_data <- sample_data %>% 
    filter(type %in% selected_pumps)
  
  # Calculate summary statistics
  summary_stats <- list(
    total_responses = nrow(filtered_data),
    avg_satisfaction = round(mean(filtered_data$satisfaction, na.rm = TRUE), 2),
    failure_rate = round(mean(filtered_data$failed == "Yes", na.rm = TRUE) * 100, 2),
    pump_types = selected_pumps
  )
  
  return(summary_stats)
}

#* @get /data
#* Get raw data for specified pump types
#* @param pumpid:[int] The id number(s) for the type(s) of pump, as an integer vector
#* @response 200
function(pumpid){
  # Convert the pumpid parameter to an integer vector
  pumpid <- as.integer(pumpid)
  
  # Filter data for selected pump types
  selected_pumps <- pump_types[pumpid]
  filtered_data <- sample_data %>% 
    filter(type %in% selected_pumps)
  
  return(filtered_data)
}
