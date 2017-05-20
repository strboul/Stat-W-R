## EXCEL FILES
#AVOID THEM AS MUCH AS YOU CAN. TEXT OR CSV FILES WORK MORE CONSISTENT

## TEXT FILES
#YOU CAN SAVE SOMETHING IN EXCEL AND THEN SAVE IT AS A TEXT FILE.
#Load a Excel spreadsheet that has been saved as tab-delimited text file.
#Need to give complete address to file
#Gives error on missing data (empty cells) but works on complete data
trends.txt <- read.table("~/Google Drive/R_Examples/extras/multiTimelineGoogleTrends.txt", header = TRUE)
#Header, true means that the first line will be variable names
?read.table

#This works with missing data by specifying the separator: sep="\t" is for tabs, sep="," for commas.
#R converts missing to "NA"
trends.txt <- read.table("~/Google Drive/R_Examples/extras/multiTimelineGoogleTrends.txt", header = TRUE, sep = ",")
str(trends.txt) #This gives structure of object sntxt

## CSV FILES
# It's universal format that any program can deals with csv files.
# I.e. SPSS, SAS, Excel, Google Docs Spreadsheet etc. can extract .csv file.
# Don't have to specify delimiters (i.e. "\t" or ",") for missing data
# Because CSV means "comma seperated values"
trends.csv <- read.table("~/Google Drive/R_Examples/extras/multiTimelineGoogleTrends.csv", header = TRUE) #It's an example. This document doesn't exist.
str(trends.csv)
