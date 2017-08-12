# Diverging bars (z-score)

library(ggplot2)
library(plyr)
library(reshape2)

divbar.aware <- data.frame(Survey[41:50])
divbar.aware <- divbar.aware[1:169, 1:10]
divbar.aware[is.na(divbar.aware)] <- 3
count.aware <- rep(1:169)
divbar.aware2 <- cbind(count.aware, divbar.aware)
divbar.aware3 <- divbar.aware2[1:169, 1:11]
View(divbar.aware3)

colnames(divbar.aware3) <- c("count.aware",
                "Worrying others \n discovering my info", 
                "Thinking who might \n be reading my post", 
                "Thinking to weather \n people monitor my post", 
                "Thinking about people \n creeping my profile", 
                "Worrying others \n scrutinizing my profile", 
                "Thinking who is \n reading my content", 
                "Scrutinizing what info \n I post on my profile",
                "Not comfortable with \n the level of exposure",
                "Worrying about people \n trying to creep on me", 
                "Thinking about who \n is monitoring me")

divbar.mdata <- melt(divbar.aware3, id=c("count.aware"))
divbar.mdata <- aggregate(cbind(value)~variable, data=divbar.mdata, FUN=mean)

divbar.mdata$value #Use value
divbar.mdata$mdata_z <- round((divbar.mdata$value - mean(divbar.mdata$value))/sd(divbar.mdata$value), 2)  # compute normalized mpg

divbar.mdata$mdata_type <- ifelse(divbar.mdata$mdata_z < 0, "below", "above")  # above / below avg flag

divbar.mdata <- divbar.mdata[order(divbar.mdata$mdata_z), ]  # sort

divbar.mdata

#bug
#@ resolved: "aggregate" data from melt.
divbar.mdata$variable <- factor(divbar.mdata$variable, levels = divbar.mdata$variable)  # convert to factor to retain sorted order in plot.

ggplot(divbar.mdata, aes(x=variable, y=mdata_z, label=mdata_z)) + 
  geom_bar(stat='identity', aes(fill=mdata_type), width=.61)  +
  scale_fill_manual(name="", 
                    labels = c("Above average", "Below average"), 
                    values = c("above"="#64b5f6", "below"="#ef6c00")) + 
  theme(text = element_text(size=16,  family="Times")) +
  theme_minimal()+
  theme(legend.position = c(0.87, 0.465))+
  labs(subtitle="", 
       title= "") +
  xlab(" ")+
  ylab(" ")+
  coord_flip()

# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html
