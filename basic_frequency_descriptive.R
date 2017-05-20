## FREQUENCIES

#CREATE DATASET FOR THIS EXAMPLE
#Data is the number of hits (in millions) for each word on Google
groups <- c(rep("blue", 3990),
            rep("red", 4140),
            rep("orange", 1890),
            rep("green", 3770),
            rep("purple", 855))

#CREATE FREQUENCY TABLES
groups.t1 <- table(groups) #Creates frequency table
groups.t1 #Print table

# MODIFY FREQUENCY TABLES
#Normally they are sorted alphebatical, sort and "decreasing = TRUE" helps sort decreasing order, which looks better.
groups.t2 <- sort(groups.t1, decreasing = TRUE) #Sorts by frequency, saves table
groups.t2 #Print table

# PROPORTIONS AND PERCENTAGES
round(prop.table(groups.t2), 2)*100 #Give proportions of total (round: w/2 decimal places). "groups.t2" because it gives the order we desire here.

## DESCRIPTIVES

# Load dataset
require("datasets")
?cars
str(cars) #Structure view
data(cars) #To add into workspace

#CALCULATE DESCRIPTIVES
summary(cars) #Summary for entire table
summary(cars$speed) #Summary for speed variable

#Tukey's five-number summary: minimum, lower-hinge, median, upper-hinge, maximum. No labels. #It can be useful if you want to define the box plot.
fivenum(cars$speed)

#Boxplot stats: hinges, n, CI, outliers
boxplot.stats(cars$speed)

??ggplot2
