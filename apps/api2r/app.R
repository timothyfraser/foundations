# app.R

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

  # Export to json
  output = toJSON(filtered, pretty = TRUE, dataframe = "rows")

  return(output)
}