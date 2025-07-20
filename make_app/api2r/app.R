# plumber.R
library(plumber)
library(jsonlite)

# Load dataset once
data("mtcars")
mtcars$model <- rownames(mtcars)

#* @apiTitle mtcars filter API

#* Return filtered mtcars data based on cyl and gear
#* @param cyl:number Number of cylinders
#* @param gear:number Number of gears
#* @get /filter
function(cyl, gear) {
  cyl <- as.numeric(cyl)
  gear <- as.numeric(gear)
  
  # Filter data
  filtered <- subset(mtcars, cyl == cyl & gear == gear)
  
  # Reset rownames for JSON export
  rownames(filtered) <- NULL
  toJSON(filtered, pretty = TRUE, dataframe = "rows")
}