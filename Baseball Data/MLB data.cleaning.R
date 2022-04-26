###Clean MLB Data

library(rvest)
library(tidyverse)
library(naniar)
library(ggthemes)
library(dplyr)
library(readr)
library(ggplot2)
library(ggrepel)
library(tidyr)
library(janitor)

##Initializing Variables in df and cleaning data ###Stopped here need to figure out columns 
df_mlb <- df_mlb %>%
  separate(PLAYERPLAYER, c('First Name', 'Last Name', 'Pos'), ' ', extra = "left")

data.frame(df_mlb,do.call("rbind", strsplit(as.character(df_mlb$`First Name`), " ", fixed= T)))

