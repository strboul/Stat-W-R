# An understanding of variation, standard deviation and covariance in R

# Data source: https://en.wikipedia.org/wiki/Standard_deviation#Basic_examples
data <- data.frame(Sex = c(rep("Male", 8), rep("Female", 6)),
                   MetabolicRate = c(525.8, 605.7,	843.3, 1195.5, 1945.6, 2135.6, 2308.7, 2950.0, 727.7, 1086.5, 1091.0, 1361.3, 1490.5, 1956.1)
)

# Mean of our MetabolicRate
mean(data$MetabolicRate) # 1444.521

# Subtract mean from the each element
sapply(1L:length(data$MetabolicRate), function(i) {
  round(data[i,2] - mean(data$MetabolicRate), 3)
}) -> dist

data <- cbind(data, dist)

# Sum all the distances (rates substracted by the mean) and divide the total number of population
# Always returns zero "numeric(0)"
sum(data$dist) / nrow(data$dist)

# Take square of each element and then square root
distSquare <- (dist)^2
distSquareSquareroot <- sqrt((dist)^2)

data <- cbind(data, distSquare, distSquareSquareroot)
data

# The variance is the mean of these values
var <- sum(data$distSquareSquareroot)

#And the population standard deviation is equal to the square root of the variance
sqrt(var)
