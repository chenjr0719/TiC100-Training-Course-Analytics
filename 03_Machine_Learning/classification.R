library(rpart)
library(nnet)
library(mlearning)

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

png("dtree_model.png", width = 7, height = 7, units = "in", res = 600)
plot(dtree_model)
text(dtree_model)
dev.off()

testing_dataset$dt_result <- predict(dtree_model, testing_dataset, type="class")
confusion_matrix <- confusion(factor(testing_dataset$dt_result), factor(testing_dataset$Species))
print(confusion_matrix)


size <- 30
maxit <- 100
nn_model <- nnet(Species ~ ., training_dataset, size = size, maxit = maxit)
print(nn_model)
summary(nn_model)

testing_dataset$nn_result <- predict(nn_model, testing_dataset, type="class")
confusion_matrix <- confusion(factor(testing_dataset$nn_result), factor(testing_dataset$Species))
print(confusion_matrix)
