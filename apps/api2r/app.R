# app.R

# IMPORTANT: Change the working directory path below to match your system
# Replace "/Users/ginayp/foundations/apps/api2r" with your actual path to this folder
setwd("/Users/ginayp/foundations/apps/api2r")

library(plumber)
library(jsonlite)
library(dplyr)
library(readr)

# Load dataset once
mtcars = read_csv("mtcars.csv")

#* @apiTitle mtcars filter API

#* Return filtered mtcars data based on cyl and gear
#* @param cyl:number Number of cylinders
#* @param gear:number Number of gears
#* @get /filter
function(cyl, gear) {
  mycyl <- as.numeric(cyl)
  mygear <- as.numeric(gear)
  
  # Filter data
  filtered = mtcars %>% filter(cyl == mycyl & gear == mygear)
  
  # Reset rownames for JSON export
  rownames(filtered) <- NULL

  # Return the data frame directly - Plumber will handle JSON conversion
  return(filtered)
}