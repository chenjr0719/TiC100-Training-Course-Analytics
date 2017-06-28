library(ggplot2)
library(rpart)

#curl "http://localhost:8080"
#* @get /
#* @serializer unboxedJSON
hello <- function() {
    message <- list(Message = "Hello World")
    return(message)
}


#* @get /kmeans
#* @png
run_kmeans <- function() {
    raw_data <- iris
    data <- as.data.frame(scale(raw_data[, 1:4]))

    result <- kmeans(data, 3)
    raw_data$kmeans_result <- as.character(result$cluster)

    plot <- ggplot(raw_data, aes_string("Sepal.Length", "Petal.Length", col = "kmeans_result")) + geom_point()
    plot(plot)
}


#curl -X PUT "http://localhost:8080/decision_tree_train"
#* @put /decision_tree_train
#* @serializer unboxedJSON
decision_tree_train <- function() {
    raw_data <- iris
    testing_dataset <- sort(
        sample(nrow(raw_data), nrow(raw_data)/3))

    training_dataset <- data.frame(
        scale(raw_data[-testing_dataset, 1:4]),
        Species = factor(raw_data[-testing_dataset, 5]))

    testing_dataset <- data.frame(
        scale(raw_data[testing_dataset, 1:4]),
        Species = factor(raw_data[testing_dataset, 5]))

    dtree_model <- rpart(Species ~ ., training_dataset)
    save(dtree_model, file = "dtree_model.rda")

    return(list(Message = "Training model success"))
}


#curl -X POST -d '{"data": {"Sepal.Length": 5.9, "Sepal.Width": 3.0, "Petal.Length": 5.1, "Petal.Width": 1.8}}' 'http://localhost:8080/decision_tree_predict'
#* @post /decision_tree_predict
#* @serializer unboxedJSON
decision_tree_predict <- function(data = NULL) {
    if(file.exists("dtree_model.rda")) {
        load("dtree_model.rda")
        result <- predict(dtree_model, data, type = "class")

        return(list(Data = data, Reslt = result))
    }else {
        return(list(Error = "No model exists"))
    }
}


#curl -X DELETE "http://localhost:8080/decision_tree_delete"
#* @delete /decision_tree_delete
#* @serializer unboxedJSON
decision_tree_delete <- function() {
    if(file.exists("dtree_model.rda")) {
        file.remove("dtree_model.rda")
        return(list(Message = "Delete model success"))
    }else {
        return(list(Error = "No model exists"))
    }
}




