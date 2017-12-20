days <- seq_along(1:365)
points <- list()

for (i in days) {
  points[[i]] <- exp(-i/500)
}

x <- unlist(points)
df <- cbind.data.frame(x, days)

df <- data.frame(df)

colnames(df) <- c("Point","Day")

library(ggplot2)
library(magrittr)

df %>%
  ggplot() +
  geom_line(aes(x=Day, y=Point), stat="identity") +
  scale_x_continuous(breaks=seq(0,365,50)) +
  annotate("text", x = 241, y = 0.71, label = "x (170, 0.7046881)", color="blue") +
  annotate("text", x = 175, y = 0.8, label = "x (90, 0.8352702)", color="blue") +
  xlab('Day') +
  ylab('Point')
