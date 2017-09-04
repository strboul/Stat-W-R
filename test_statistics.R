# Test statistics in hypothesis testing (draft)
x=rnorm(100)
y=rnorm(100)
p <- t.test(x,y)
p
plot(p)
names(p)
p$statistic

ts = replicate(1000,t.test(rnorm(10),rnorm(10))$statistic)
ts
range(ts)

pts = seq(-4.5, 4.5, length=100)
pts

plot(pts,dt(pts,df=18),col='red',type='l')
lines(density(ts))
