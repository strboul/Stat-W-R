# Converting tabular data to row data
# If you have a data set that is in tabular format, and a lot of the sample data sets in R are in tabular format. But you may want to convert it to a data frame of rows and columns for use in standard analysis.

#Example
#Load dataset
?UCBAdmissions
str(UCBAdmissions)

#The problem
admit.fail <- (UCBAdmissions$Admit) # "$" sign doesn't work and is invalid for atomic vectors.
barplot(UCBAdmissions$Admit) # Doesn't work. "$" is invalid for atomic vectors.

# We want marginal frequencies from original table
margin.table(UCBAdmissions, 1) #Admit (variable 1 __use ?dataset)
margin.table(UCBAdmissions, 2) #Gender
margin.table(UCBAdmissions, 3) #Dept
margin.table(UCBAdmissions) #Grand total

#Save marginals as new table
admit.dept <- margin.table(UCBAdmissions, 3) #Dept
str(admit.dept)
barplot(admit.dept)
admit.dept #Show frequencies
prop.table(admit.dept) #Show as proportions
round(prop.table(admit.dept), 2) #Show as propotions w/2 digits
round(prop.table(admit.dept), 2) * 100 #Give percentages w/o decimal places

# Convert table to one row per case
admit1 <- as.data.frame.table(UCBAdmissions) #Coerces to data frame #Make it from a tabular format to laying it out flat.
admit2 <- lapply(admit1, function(x)rep(x, admit1$Freq)) #Repeats each row by Freq. It is situated in the 'values' environment, not 'data.'
#Above is taken each one of "admit1" rows. For instance, there's 512 people who have the combination of admitted male in A? We're going to take that row and repeat it 512 times, and then we're going to have the next one repeat a total of 313 times, and so on. So what we're going to do, is we're going to use this one lapply, and that is going to be able to take the data frame that we just created, admit1, and it's going to use this function or it takes a variable, and it repeats it.

admit3 <- as.data.frame(admit2) #Converts from 'value' to 'data'
#Note: As admit1 (24 obs., 4 var.) was groups, admit3 (4526 obs., 4 var.) is the all the people extracted from admit1.
admit4 <- admit3[, -4] #Removes fifth column with frequencies (as it was showing the number of people in admit1, admit3 it was the people which frequency they belong. Have been became unnecessary and vague. Now admit4 (4526 obs., 4 var))

## Or do it all in one go. For the actions between admit1 and admit4.
admit.rows <- as.data.frame(lapply(as.data.frame.table(UCBAdmissions), function(x)rep(x, as.data.frame.table(UCBAdmissions)$Freq)))[, -4]
str(admit.rows)
admit.rows[1:10, ] #View first 10 rows o data (out of 4526)