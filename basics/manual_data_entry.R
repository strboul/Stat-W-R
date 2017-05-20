#Entering data manually
#(Importing data to R from a Excel spreadsheet would be more time-wise)

#Create sequential data
x1 <- 0:10 # Assigns number 0 to 10 to x1 (i.e. c)
# seq(10) # Counts from 1 to 10 -- different bcs seq starts from 1
x1 # Prints contents of x1 in console

x4 <- seq(30,0,by=-3) # Counts down by 3 (it's minus bcs counts down)
x4

#Manually enter data
x5 <- c(5,4,1,6,7,7,8,3,4,5) #Concatenate(_siralamak_)
x5 #Print the values
?c #To get more information about popular concatenate in R. "c" is a generic function combining arguments.

x6 <- scan()  #After running this go to console. It allows you to enter variables from console.
#Hit return(enter) after each number
#Hit return twice to stop
x6
?scan
