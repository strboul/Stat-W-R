u1 <- rnorm(30)
print("This loop calculates the square of the first 10 elements of vector u1")

# Initialize `usq`
usq <- 0

for(i in 1:10) {
  # i-th element of `u1` squared into `i`-th position of `usq`
  usq[i] <- u1[i]*u1[i]
  print(usq[i])
}

print(i)

# ----------------------------------

# dim( ) : Dimensions of an Object. Retrieve or give value to the the dimension of an object.

# Create a 10 x 10 matrix (10rows and 10columns)
#It returns NA empty cells, but the matrix is created
mymatrix <- matrix(nrow=10, ncol=10)

# For each row and for each column, assign values based on position: product of two indexes
for(i in 1:dim(mymatrix)[2]) {
  for(j in 1:dim(mymatrix)[1]) {
    mymatrix[i,j] = i*j
  }
}

# Just show the upper left 10x10 chunk
mymatrix[1:10, 1:10]

# ---------------
# But matrix() is limited
?array
# Create your three-dimensional array
my_array <- array(1:5, dim=c(5, 5, 5)) #20 rows, 20 columns and 20 matrices
my_array
for (i in 1:dim(my_array)[1]) {
  for (j in 1:dim(my_array)[2]) {
    for (k in 1:dim(my_array)[3]) {
      my_array[i,j,k] = i*j*k
    }
  }
}
??plotting
# Show a 10x10x15 chunk of your array
my_array[1:10, 1:10, 1:15]
