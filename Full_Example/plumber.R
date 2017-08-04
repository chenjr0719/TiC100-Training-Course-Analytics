library(plumber)

r <- plumb("api_example.R")
r$run(host="0.0.0.0", port=8080)
