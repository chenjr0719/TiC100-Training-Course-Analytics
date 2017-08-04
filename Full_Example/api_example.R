#curl "http://localhost:8080"
#* @get /
#* @serializer unboxedJSON
hello <- function() {
    message <- list(Message = "Hello World")
    return(message)
}




