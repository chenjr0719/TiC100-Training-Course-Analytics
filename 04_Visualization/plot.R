library(ggplot2)

bar_chart <- ggplot(testing_dataset, aes(nn_result)) + geom_bar()
plot(bar_chart)
ggsave('bar_chart.png')

histogram <- ggplot(iris, aes(Sepal.Length)) + geom_histogram()
plot(histogram)
ggsave('histogram.png')

scatter <- ggplot(iris, aes(Sepal.Length, Petal.Length, col = Species)) + geom_point()
plot(scatter)
ggsave('scatter.png')

line_chart <- ggplot(economics, aes(date, unemploy)) + geom_line()
plot(line_chart)
ggsave('line_chart.png')

smooth <- ggplot(iris, aes(Sepal.Length, Petal.Length, col = Species)) + geom_point() + geom_smooth()
plot(smooth)
ggsave('smooth.png')
