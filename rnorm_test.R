#Normal distribution test
x = rnorm(100)
hist(x)
x1 = rnorm(500)
x2 = rnorm(1000)
x3 = rnorm(10000)
hist(x1)
hist(x2)
hist(x3)
x4 = rnorm(10000000)
hist(x4)
x5 = dnorm(100)
hist(x5)
?ecdf

x <- rnorm(12)
Fn <- ecdf(x)
Fn     # a *function*
Fn(x)  # returns the percentiles for x
tt <- seq(-2, 2, by = 0.1)
12 * Fn(tt) # Fn is a 'simple' function {with values k/12}
summary(Fn)
##--> see below for graphics
knots(Fn)  # the unique data values {12 of them if there were no ties}
