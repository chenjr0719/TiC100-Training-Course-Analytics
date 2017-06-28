random_char <- sample(LETTERS, 20, TRUE)
random_char <- factor(random_char)
print(random_char)
print(as.numeric(random_char))

data <- data.frame(x = rnorm(10, 30, .2), y = runif(10, 3, 5))
scaled_data <- scale(data)
print(data)
print(scaled_data)

data <- as.data.frame(matrix(c(1:5, NA), ncol = 2))
print(data)
data <- data[complete.cases(data), ]
print(data)
