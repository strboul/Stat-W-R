### INSTALL/UPDATE PACKAGES ##
install.packages("tidyverse")

### UPDATE ALL PACKAGES
update.packages(ask=FALSE, checkBuilt = TRUE)

### UPDATE ONLY IN TIDYVERSE
tidyverse_update()

### LOAD LIBRARIES ###
library(tidyverse) #
# (Imports: broom, dplyr, forcats, ggplot2, haven,
# httr, hms, jsonlite, lubridate, magrittr, modelr,
# purrr, readr, readxl, stringr, tibble, rvest, tidyr, xml2)
library(data.table)
library(RColorBrewer)
library(car) # For recode variables reversely
library(psych)
library(matrixStats) # High-performing functions operating on rows and columns of matrices
library(colorspace) # For ggplot colors

### EXTRA LIBRARIES ###
# Minimal reproducible example or Minimal working example (MWE)
install.packages("reprex")
library(reprex)
