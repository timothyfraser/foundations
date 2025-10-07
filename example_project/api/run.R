# run.R

# Start the API in R
setwd("example_project/api")
library(plumber)
r <- plumb("plumber.R")
r$run(port = 8000)
