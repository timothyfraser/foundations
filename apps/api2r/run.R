# In R console:

# setwd("apps/api2r")
library(plumber)
r <- plumb("app.R")
r$run(port = 8000)
