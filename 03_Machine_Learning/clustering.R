library(dbscan)
library(ggplot2)

ggplot(iris, aes_string("Sepal.Length", "Petal.Length", col = "Species")) + geom_point()
ggsave('iris.png')

raw_data <- iris
data <- as.data.frame(scale(raw_data[, 1:4]))

result <- kmeans(data, 3)
raw_data$kmeans_result <- as.character(result$cluster)

ggplot(raw_data, aes_string("Sepal.Length", "Petal.Length", col = "kmeans_result")) + geom_point()
ggsave('kmeans.png')

eps <- 0.6
minPts <- 10
result <- dbscan(data, eps = eps, minPts = minPts)
raw_data$dbscan_result <- as.character(result$cluster)

ggplot(raw_data, aes_string("Sepal.Length", "Petal.Length", col = "dbscan_result")) + geom_point()
ggsave('dbscan.png')
