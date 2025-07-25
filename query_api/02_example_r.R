# 02_example_r.R

# This script can be run in R to demonstrate 
# how to make an API request

# Install if you haven’t yet
# install.packages(c(“httr2”, “jsonlite”)) 

# Execute query and save response as object
library(httr2)
library(jsonlite)

# Create request object
req = request("https://reqres.in/api/users/2") |>
  req_headers(`x-api-key` = "reqres-free-v1") |>
  req_method("GET")

# Execute request and store result as object
resp = req_perform(req)

# Check status
resp$status_code # 200 = success
# Return response as a json
resp_body_json(resp)
# Convert JSON to R list object
fromJSON(resp_body_json(resp))

# Clear environment
rm(list = ls())

# Exit
# q(save = "no")