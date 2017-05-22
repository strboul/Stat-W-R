#Reg. line

attach("Survey")
plot(age, FB_use)
abline(lm(age~FB_use))
title("Regression of Age on Intensity of Facebook Use")
detach("Survey")
