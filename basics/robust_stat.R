#Robust statistics for univariate analyses

#Load data
?state.area
area <- state.area
area
hist(area)
boxplot(area)
boxplot.stats(area)
summary(area)

#Robust methods for describing center:
mean(area) #NOT robust
median(area)
mean(area, trim = .05) #Trimmed mean. 5% from each end (actually you trim 10% total). Mean gets close to median.
mean(area, trim = .50) #50 from each end = median

mean(area, trim = .20) #20% from each end (%40 total). "Rand Wilcox" recommends 20% trimmed mean.

#Robust methods for describing variation:
sd(area) #NOT robust
mad(area) #Median absolute deviation
IQR(area) #Interquartile range (Can select many methods)

#Review: "The median and the trimmed mean are good variations for the mean and the median absolute deviation or the IQR can be good substitutes for the standard deviation when you have outliers or you have strongly-skewed datasets."