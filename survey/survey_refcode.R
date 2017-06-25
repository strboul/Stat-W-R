# SURVEY ANALYSIS
# (REFERENCE CODE)

# ---------- SURVEY DATAFRAME
header_main_surveyx <- scan("~/Survey_Data_R/csv_data/Social_Privacy_on_Facebook.csv", nlines = 1, what = character (), sep = ",") # Extract only headers
data_main_surveyx <- read.csv("~/Survey_Data_R/csv_data/Social_Privacy_on_Facebook.csv", skip = 2, header = FALSE, sep = ",") # Extract only data, w/out headers ## If the file is .txt, use "read.table()"; if not, use "read.csv()"
names_header_main_surveyx <- sapply(header_main_surveyx, paste, collapse = "_") # Use sapply to make operations over the columns
names (data_main_surveyx) <- names_header_main_surveyx
final_data_main_surveyx <- data.frame(data_main_surveyx)[11:76] # Having only [11:76] columns for main survey data, excl. metadata & other unnecessary
Surveyx <- final_data_main_surveyx # "Surveyx"

##(Extra: First read .CSV file. Import to examine data in R, not working with it.)
raw_survey <- read.csv("~/Survey_Data_R/csv_data/Social_Privacy_on_Facebook.csv", header = TRUE)

##Write CSV file (for external visualization needing clean data like Tableau, PowerBI...)
write.csv(Survey, file="~/Survey_Data_R/csv_data/Social_Privacy_on_Facebook.csv")

# ---------- LIBRARIES
library(tidyverse) 
#(Imports: broom, dplyr, forcats, ggplot2, haven,
# httr, hms, jsonlite, lubridate, magrittr, modelr,
# purrr, readr, readxl, stringr, tibble, rvest, tidyr, xml2)
library(data.table)
library(RColorBrewer)
library(car) # For recode variables reversely
library(psych)
library(matrixStats) # High-performing functions operating on rows and columns of matrices
library(colorspace) # For ggplot colors

## ---------- R CODE

### ----------- FOR & LOOP
# Assigning variables in a loop.
for (i in 1:22) {
  print(assign(paste0("Variable", i), varlist[i]))
}

### ---------- RECODE

#### Recode function
# Use 'recode' function to recode variable Q2.1
Q2.1_int <- recode(Survey$Q2.1, '1="Male"; 2="Female"; 3="Other"')
# Remove missing values from _int
Q2.1_int[is.na(Q2.1_int)] <- 99
# recode it and mutate to the Survey
Survey <- mutate(Survey, gender.cat = Q2.1_int)

#### Define function to recode variables
reverse_6point_general <- function(x) {
  case_when(x %in% c("1") ~ 6,
            x %in% c("2") ~ 5,
            x %in% c("3") ~ 4,
            x %in% c("4") ~ 3,
            x %in% c("5") ~ 2,
            x %in% c("6") ~ 1)
}
# Apply recoding function by a temporary variable with _int
Q4.3_int <- sapply(Survey$Q4.3, reverse_6point_general)
# Remove missing values from _int
Q4.3_int[is.na(Q4.3_int)] <- 99
# Bind temporary variable _int onto actual variable in the main Survey dataframe
Survey$Q4.3 <- Q4.3_int

### ----------- DUMMY VARIABLES

heard.dummy <- heard.cross
heard.dummy <- apply(heard.dummy, 2, function(x) {x[x=="No"] <- 0; x})
heard.dummy <- apply(heard.dummy, 2, function(x) {x[x=="Yes"] <- 1; x})
heard.dummy <- as.numeric(heard.dummy)

### ---------- MUTATE VARIABLES (dplyr)

# (dplyr) Mutate the last four variables as sum variable and add to Survey as a new column
Survey <- mutate(Survey, Q5.3sum = Q5.3_1 + Q5.3_2 + Q5.3_3 + Q5.3_4) 
# Group four variables as vector
groupQ5.3 <- c('Q5.3_1', 'Q5.3_2', 'Q5.3_3', 'Q5.3_4')
# Calculate mean and sd of these 4 variables, and add to the main Survey dataframe as new columns to the very end
Survey <- Survey %>%
  mutate(meanQ5.3 = rowMeans(.[groupQ5.3]), sdQ5.3 = rowSds(as.matrix(.[ ,groupQ5.3])))

# ------- Q6.1: Information disclosure --------------------------------
# Define temporary _varlist incl. var from Q6.1_1 to Q6.1_22
Q6.1_varlist <- print(Survey[19:40])

# Define function to recode variables from Q6.1_1 to Q6.1_22 (this defines inside)
# Like an if statement, the arguments are evaluated in order, so always proceed from the most specific to the most general.
Q6.1_varlist[1:22]<-sapply (Q6.1_varlist[1:22], function(x) {
  case_when(x %in% c("3") ~ 1,
            x %in% c("2") ~ 2,
            x %in% c("1") ~ 3)})
# Remove missing values from _varlist
Q6.1_varlist[1:22][is.na(Q6.1_varlist[1:22])] <- 99
#Bind them (temporary _varlist var.s) into the main Survey dataframe
Survey[19:40] <- Q6.1_varlist[1:22]

# (dplyr -- SUM) Mutate the each 22 variables as sum variable and add to Survey as a new column
# rowSums: Form row and column sums and means for numeric arrays (or data frames).
# cbind: "column bind", takes several vectors or arrays and binds them "by column" into a single array.
Survey <- mutate(Survey, Q6.1sum = rowSums(cbind(Survey[19:40])))
# Group each 22 variables as vector ## using "names" for variable names.
groupQ6.1 <- names(Survey[19:40])

# Calculate mean and sd of these 22 variables, and add to the main Survey dataframe as new columns to the very end
Survey <- Survey %>%
  mutate(meanQ6.1 = rowMeans(.[groupQ6.1]), sdQ6.1 = rowSds(as.matrix(.[ ,groupQ6.1])))

## ---------- BASIC STATISTICS

# Mean and SD via "psych" package
describe(Survey$Q5.3_1, na.rm = TRUE)

### Frequency table
library(MASS) # load the MASS package 
Q6.1_1.freq = table(Survey$Q6.1_1)

### Welch’s anova for unequal variances
oneway.test(spa ~ kinds, data=sum_disc_10, na.action=na.omit, var.equal=FALSE)

## ---------- CROSSTABLE

total.crs <- cbind(gender.cross, age.cross, edulevel.cross, heard.cross, expe.cross, aware.cor.mm)

CrossTable(total.crs$gender.cross, total.crs$heard.cross, chisq = T)
CrossTable(total.crs$age.cross, total.crs$heard.cross, chisq = T)
CrossTable(total.crs$edulevel.cross, total.crs$heard.cross, chisq = T)

CrossTable(total.crs$gender.cross, total.crs$expe.cross, chisq = T)
CrossTable(total.crs$age.cross, total.crs$expe.cross, chisq = T)
CrossTable(total.crs$edulevel.cross, total.crs$expe.cross, chisq = T)

## ---------- T-TEST

default.cross <- Surveyx$Q9.1
default.cross <- recode(default.cross, '1="Yes"; 2="No"')
default.cross <- default.cross[1:169]
default.cross <- data.frame(default.cross)
default.cross[is.na(default.cross)] = "Yes"

default_data <- cbind(aware.cor.mm, default.cross)
t.test (aware.cor.m ~ default.cross, data=default_data)

shapiro.test(aware.cor.m ~ expe.cross$residuals)$p.value

## ----------- ANOVA

with(intense.aov.df, aggregate(techno.cor.m, by=list(aware.cor.m), FUN=mean))  ## for mean

aov1 <- aov(aware.cor.m ~ Q4.1.cat, data=intense.aov.df)

summary(aov1)

TukeyHSD(aware.cor.m$intense.aov.df ~ Q4.1.cat$intense.aov.df, conf.level=0.95)

## ---------- CORRELATION

aware.cor.m <- rowMeans(aware.cor)
aware.cor.m <- aware.cor.m[1:167]
aware.cor.m.saver <- matrix(c(2,2), ncol=1)
colnames(aware.cor.m.saver) <- c("aware.cor.m")
acor_1 <- as.data.frame(aware.cor.m)
acor_2 <- rbind(acor_1, aware.cor.m.saver)
aware.cor.mm <- as.matrix(acor_2)

# --Corlist
basic.cor.m.2 <- as.data.frame((basic.cor.m))
basic.cor.m.2 <- mutate(basic.cor.m.2, v1=appear.cor.m, v2=techno.cor.mm, v3=aware.cor.mm, v14=intensity.cor.m, v4=previous.cor.mm, v11=gender.cor, v12=age.cor, v13=edulevel.cor)
colnames(basic.cor.m.2) <- c("Basic", "Appear", "Techno", "Aware", "Intensity", "Previous", "Gender", "Age", "EduLevel")
corlist.cor <- as.matrix(basic.cor.m.2)

library(Hmisc)
Mcor.cor <- cor(corlist.cor)
print(Mcor.cor)
rcorr(as.matrix(corlist.cor), type="pearson") #calculate significance

## ---------- LINEAR REGRESSION

fit <- lm(aware.cor.mm ~ basic.cor.m + age.cor + gender.dummy + edulevel.cor)
summary(fit)
coefficients(fit)
confint(fit)
anova(fit)
shapiro.test(fit$residuals)$p.value
par(mfrow=c(2,2)) # For 2x2 viewing, then run plot(x)
plot(fit)
par(mfrow=c(1,1)) # Return 1x viewing

VIF(lm(aware.cor.mm ~ basic.cor.m + age.cor + gender.dummy + edulevel.cor))


## ---------- RELIABILITY AND VALIDITY

### ----------- CRONBACH'S ALPHA
Q4.3_int <- recode(Surveyx$Q4.3, '1=6; 2=5; 3=4; 4=3; 5=2; 6=1')
Q4.4_int <- recode(Surveyx$Q4.4, '1=6; 2=5; 3=4; 4=3; 5=2; 6=1')

Surveyx <- mutate(Surveyx, Q4.1_r = Q4.1_int, Q4.3_r = Q4.3_int, Q4.4_r = Q4.4_int)

factor_c1_int <- data.frame(cbind(Surveyx$Q4.1_r,
                                  Surveyx$Q4.2,
                                  Surveyx$Q4.3_r,
                                  Surveyx$Q4.4_r,
                                  Surveyx$Q5.2
                                  # Surveyx$Q5.3_1,
                                  # Surveyx$Q5.3_2,
                                  # Surveyx$Q5.3_3,
                                  # Surveyx$Q5.3_4
))
factor_c1_int[is.na(factor_c1_int)] <- 99

factor_c1 <- as.matrix(sapply(factor_c1_int, as.numeric))

alpha(factor_c1) ## psych
psych::alpha(factor_c1)$total$std.alpha # Accessing the alpha value in direct

### ---------- VALIDITY
require(psych)
validx <- data.frame(cbind(factor_c2, factor_c3, factor_c4))

fa.parallel (validx, fa="pc", n.iter = 100, ylabel = ,
             show.legend = F, main = "Scree plot with parallel analysis")

summary(validx) # You can check which variables have high correlation amongst each other
cor(validx) # Correlation Matrix
KMO(validx) # Kaiser-Meyer-Oklin Test (KMO)

bartlett.test(validx) # Bartlett’s test

pc <- principal(r=validx, nfactors=6, rotate = "varimax")

head(pc) # To print results with "varimax" rotated.

cor.plot(validx, numbers=TRUE, cex.axis=0.6, main=" ") #Correlation plot with 'psych'
#?cor.plot

## ---------- VISUALIZATION

### ---------- WAFFLE CHART (instead of pie chart)
# devtools::install_github("hrbrmstr/waffle") #Install package from github
# NOTE: There is a better waffle chart inside ggplot2 (06/2017)
library(waffle)

table(chart_ss_ns) #See the number of occurances
round(prop.table(table(chart_ss_ns))*100,2) #See the proportions

waffle_vector <- c('Social Sciences (85.23%)'=150, 'Natural sciences (13.64%)'=24, 'NA (1.14%)'=2) # [[Manual]] entry from occur. and prop.
waffle_vector_woutpercent <- c('Social Sciences'=150, 'Natural sciences'=24, 'NA'=8) # [[Manual]] entry from occur. and prop.

waffle(waffle_vector_woutpercent/5.4, rows=4, size=0.5, legend_pos="bottom", colors=c("#ef6c00", "#64b5f6", "#ffd54f"))

### --------- BAR CHART WITH PERCENTAGES

year_FB <- c('2004'=2, '2005'=1, '2006'=4, '2007'=14, '2008'=35, '2009'=33, '2010'=26, '2011'=17, '2012'=18, '2013'=7, '2014'=2, '2015'=10, '2016'=3, '2017'=1)
year_FB2 <- as.factor(year_FB)
names_year_FB2 <- names(year_FB2)
year_FB3 <- as.data.frame(year_FB2)
#proportion
year_pt <- sprintf("%0.1f%%", prop.table(year_FB) * 100)
dim(year_pt) <- dim(year_FB)
dimnames(year_pt) <- dimnames(year_FB)

year_proptable <- print(year_pt, quote = FALSE, right = TRUE) #without quotes and right align

year_FB3 <- mutate(year_FB3, year_names=names_year_FB2, year_prop=year_proptable)
year_FB3

## ggplot
year_use <-ggplot(data=year_FB3, aes(x=year_names, y=year_FB2)) +
  geom_bar(stat="identity", fill="#ef6c00") +
  geom_text(aes(label=year_proptable), vjust=0.4, hjust=1.2, color="black", size=3) +
  ylab('') +
  xlab('') +
  theme_minimal()+
  #scale_x_discrete(limits=c("D0.5", "D2")) + ##choose which items to display
  coord_flip() #Horizontal
year_use

### ----------- INFORMATION DISC. SCATTER PLOT

scatter_df %>%
  #filter(gender.cat != "99") #%>% # Remove "99" element
  ggplot() +
  aes(x = sum, y = sd, shape=Edu.level, color=Gender, size=Age) +
  #colour = Q4.2, shape = gender.cat
  geom_jitter(alpha = 0.65) +
  # ggtitle('Information Disclosure Level') +
  theme(text = element_text(size=12.5,  family="Times")) +
  xlab('Level of Information Disclosure') +
  ylab('Dispersion') +
  #scale_colour_discrete(name = "Number of Hours") +
  #scale_shape_discrete(name = "Gender") +
  #scale_x_continuous(limits = c(22, 65)) + # limiting x-axis outliers
  #scale_y_continuous(limits = c(0.25, 1.25)) + # limiting y-axis outliers
  geom_point()

### ---------- SCATTER PLOT (SP AWARENESS, CONTROL VARIABLES)

##### ggplot Frequency table histogram
Q6.1_ft_int <- data.frame(Q6.1_rnames, no = Q6.1_freq)
ft1 <- data.frame(Q6.1_rnames, Q6.1_ft_int["no.X1"], Type = 1) # "Not Shared"
ft2 <- data.frame(Q6.1_rnames, Q6.1_ft_int["no.X2"], Type = 2) # "Shared but incomplete/inaccurate"
ft3 <- data.frame(Q6.1_rnames, Q6.1_ft_int["no.X3"], Type = 3) # "Shared"
## Used rbindlist, library(data.table): Change names of columns of X1, X2, X3 because of rbind requires same names
Q6.1_ft <- data.frame(rbindlist(list(ft1, ft2, ft3))) ## Attention: All no.X1, ~X2, ~X3 are merged in the same name of "no.X1"
Q6.1_ft$Type2 <- cut(Q6.1_ft$Type, breaks=3) # This to turn continuous variables into categorical ones because of removing "gradient" fill in ggplot
Q6.1_ft_status <- revalue(Q6.1_ft$Type2, c("(0.998,1.67]"="NS","(1.67,2.33]"="S-BNC/I","(2.33,3]"="S")) #plyr: To rename legend in ggplot
Q6.1_ft <- mutate(Q6.1_ft, Status = Q6.1_ft_status)

ggplot(data = Q6.1_ft, aes(x = Q6.1_rnames, y = no.X1, fill = Status)) +
  geom_bar(position = "stack", stat = "identity") +
  ylab('M or (%)') +
  xlab('') +
  theme(text = element_text(size=11,  family="Times")) +
  scale_fill_manual(values=c("#ef6c00", "#189BFF", "#00BF00")) +
  coord_flip()
  
####Notched boxplot
boxplot(aware.cor.m ~ heard.cross, data=total.crs, notch=T,
        col=(c("red","royalblue2")))

boxplot(aware.cor.m ~ expe.cross, data=total.crs, notch=TRUE, 
        col=(c("red","royalblue2")))


## ---------- MISCELLANEOUS

### ---------- LaTeX TABULAR OUTPUT (xtable)
acadiscipline1 <- data.frame(Survey$Q2.4[1:88])
aca_no <- rep(89:176)
aca_no
acadiscipline2 <- data.frame(Survey$Q2.4[89:176])
acadiscipline <- cbind(acadiscipline1, aca_no, acadiscipline2)

# LaTeX Tabular Output (from data.frame)
library(xtable) # Run these three lines
options(xtable.floating = FALSE)
options(xtable.timestamp = "")

xtable(acadiscipline)

### ---------- SOME COLORS

##Fancy colors
#ef6c00 - red
#64b5f6 - blue
#ffd54f - yellow
#76c476 - green

##Pale colors
#aad18e green
#f5b184 red
#9cc3e7 blue

##Saturated colors
#FF5652 -red
#189BFF -blue
#00BF00 -green

par(mfrow=c(1,1)) # For ...x... viewing in plot (i.e. 2x2)

# Look all the class in survey
sapply(Survey, class)

