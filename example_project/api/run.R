# run.R

# Start the API in R
# IMPORTANT: Change the working directory path below to match your system
# Replace "/Users/ginayp/foundations/example_project/api" with your actual path to this folder
setwd("example_project/api")
library(plumber)
r <- plumb("plumber.R")
r$run(port = 8000)
