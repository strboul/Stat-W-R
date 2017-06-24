#VARIABLE LABELS
names(Survey)[2] <- gender

#MISSING VALUES
Survey$Q2.1 <- gender
is.na(gender) # returns TRUE of x is missing
gender[gender == 99] <- NA
mean(gender) # returns NA
mean(gender, na.rm=TRUE) # returns a numerical value

#VALUE LABELS
(...)

dim(surveydata$gender) # Dimensions of object
str(surveydata$gender) # Structure of object
class(surveydata)
names(surveydata) # Give names of components in object

head(surveydata) # Lists first six
tail(surveydata) # Lists last six

ls(surveydata) # List current objects


#DATA FRAME: Add the variables related to your question/hypothesis
intensity_fb <- data.frame(date, country, gender, q1.1, q2.1, q2.2, stringsAsFactors = FALSE)
