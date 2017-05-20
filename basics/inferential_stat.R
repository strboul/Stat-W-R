library(help = "stats") #Full documentation for the package "stats"

# Single proportion: Hypothesis test and confidence interval

#In the 2012 Major League Baseball season, the Washigton Nationals 98 wins out of 162 games (.605). Is this significantly greater than 50%?

# PROPORTION TEST
# 98 wins out of 162 games (default settings)
prop.test(98, 162)

#So we reject the null hypothesis

#Single mean: Hypothesis test and confidence interval

#Load data
?quakes
quakes [1:5, ] #See the first 5 lines of the data

mag <- quakes$mag #Just load the magnitude variable
mag[1:5] #First 5 lines

#Use t-test for one-sample
#Default t-test (compares mean to 0)
t.test(mag)

#Single categorcal variale: One sample chi-square test

#Load data
?HairEyeColor
str(HairEyeColor)

#Get marginal frequencies for eye color
margin.table(HairEyeColor, 2)

#Save eye color to data frame
eyes <- margin.table(HairEyeColor, 2)

round(prop.table(eyes), 2)*100 #Proportions w/2 digits

#Use Pearson's chi-squared test
#Need one-dimensional goodness-of-fit test
#Default test (assume equal distribution)
chi1 <- chisq.test(eyes) #Save tests as object "chi1"
chi1 #Check results

chi2 <-  chisq.test(eyes, p = c(.41, .32, .15, .12))
chi2