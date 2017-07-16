#k-means clustering
user_data <- read.csv("~/Desktop/github/yelp_business.csv", header = TRUE)
user_data <- user_data[1:1000,] #Take a sample of 1000

userCluster <- kmeans(user_data[,c(9,10)],2)

Stars <- runif(1000, min=0, max=5)
Review <- runif(1000, min=200, max=400)
user_data <- mutate(user_data, Stars = Stars, Review=Review)

ggplot(user_data, aes(Stars, review_count, color=userCluster$cluster)) +
         geom_point()
