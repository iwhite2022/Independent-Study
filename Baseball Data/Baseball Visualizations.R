#Packages
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


####Visualization 
    ###Comparing wOBA v. avg 
Viz12 <- ggplot(data= hitting, mapping = aes(x=wOBA, y=avg, color=Team)) +
  geom_point() +
  scale_color_manual(values=c("black", "purple", "red", "blue", "green", "grey", "gold", "maroon")) +
  ylim(0.000, 0.500) +
  xlim(0.000, 0.600) +
  labs(title= "2022 AAC Baseball Individual Weighted On-Base Averages vs Batting Averages", 
       x="Weighted On-base Averages (wOBA)", y= "Batting Average (AVG))", color="Team") +
       geom_text_repel(aes(label=`Last Name`))
Viz12   ###max.overlaps?

    ####wOBA vs. OPS
Viz13 <- ggplot(data= hitting, mapping = aes(x=wOBA, y=`ob%`, color=Team)) +
  geom_point() +
  scale_color_manual(values=c("black", "purple", "red", "blue", "green", "grey", "gold", "maroon")) +
  ylim(0.000, 0.500) +
  xlim(0.000, 0.600) +
  labs(title= "2022 AAC Baseball Individual Weighted On-Base Averages vs On-Base Percentage", 
       x="Weighted On-base Averages (wOBA)", y= "On-Base Percentage (OPS)", color="Team") +
  geom_text_repel(aes(label=`Last Name`))
Viz13

    ####Individual FIP v. Avg. FIP of AAC Players ####still need to figure this one out
Viz14 <-