library(jsonlite)
library(mongolite)


main <- function() {

    # Connect to MongoDB of localhost
    mongo_uri <- 'mongodb://localhost:27017/test'

    # Connect to MongoDB on WISE-PaaS
    vcap_services <- Sys.getenv("VCAP_SERVICES")
    vcap_services <- fromJSON(vcap_services)

    mongo_uri <- vcap_services$mongodb$credentials$uri

    coll_name <- "Test"
    coll <- mongo(coll_name, url = mongo_uri)

    # Insert document
    doc1 <- list("_id" = "test01", Message = "Hello World", From = "WISE-PaaS")
    doc1 <- toJSON(doc1, auto_unbox = TRUE)

    doc2 <- list("_id" = "test02", Message = "Hello R", From = "Your team")
    doc2 <- toJSON(doc2, auto_unbox = TRUE)

    docs <- c(doc1, doc2)
    insert_result <- coll$insert(docs)
    print(insert_result$nInserted)
    print(coll$find())

    # Query document
    query <- list("_id" = "test01")
    query <- toJSON(query, auto_unbox = TRUE)

    fields <- list("_id" = 1, Message = 1, From = 1)
    fields <- toJSON(fields, auto_unbox = TRUE)
    query_result <- coll$find(query, fields = fields)
    print(query_result)

    # Query with regex
    regex <- list("$regex" = "^Hello")
    query <- list(Message = regex)
    query <- toJSON(query, auto_unbox = TRUE)
    query_result <- coll$find(query)
    print(query_result)

    # Update document
    query <- list(From = "WISE-PaaS")
    query <- toJSON(query, auto_unbox = TRUE)

    set <- list(From = "Your team")
    update <- list("$set" = set)
    update <- toJSON(update, auto_unbox = TRUE)
    update_result <- coll$update(query, update)
    print(update_result)
    print(coll$find())

    # Delete document
    query <- list("_id" = "test02")
    query <- toJSON(query, auto_unbox = TRUE)
    remove_result <- coll$remove(query)
    print(remove_result)
    print(coll$find())

}

main()

