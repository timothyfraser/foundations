# run_simple.R

# Start the simplified API in R
# IMPORTANT: Change the working directory path below to match your system
# Replace "/Users/ginayp/foundations/example_project/api" with your actual path to this folder
setwd("/Users/ginayp/foundations/example_project/api")
library(plumber)
r <- plumb("plumber_simple.R")
r$run(port = 8001)  # Using port 8001 to avoid conflicts
