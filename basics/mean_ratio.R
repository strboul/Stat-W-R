#mean&ratio

iqsize <- read.table("~/Desktop/iqsize.csv", header = TRUE, sep = ",")
str(iqsize)
iqsize

mean(iqsize$PIQ)
mean(iqsize$Brain)
x <- mean(iqsize$Weight)
y <- mean(iqsize$Height)

x/y #Ratio of weight over height
