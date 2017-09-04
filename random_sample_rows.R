# Make a sample from the data which is about 1000 randomly selected rows. It is a random sample to speed the analysis up.

a <- read.csv(...)
xx <- data.frame(a)
xx <- xx[sample(nrow(xx), 1000), ]
