library(plumber)

r <- plumb("api_example.R")
r$run(port=8080)
