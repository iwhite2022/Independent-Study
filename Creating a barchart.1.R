library(readr)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)

#load initial data frame
library(readr)
thesis_data <- read_csv("Documents/ECU/Graduate Program/Thesis Documents /Final DATA/2.8-FINAL.DATASET.THESIS.csv")
View(thesis_data)
 
#### Extracting specific columns of data into a new data frame (new columns)
pa_data <- data.frame(thesis_data$PARTID,thesis_data$Group, thesis_data$TOTALMETMIN.1, thesis_data$TOTALMETMIN.2, thesis_data$TOTALMETMIN.3)
###Renaming columns 
names(pa_data) <- data.frame('ID', 'group', 'PA1', 'PA2', 'PA3')

####Chart at one time point ###what does position, stat, fun do?
###Time 1 
ggplot(pa_data, aes(group, PA1))+geom_bar(position = 'dodge', stat='summary', fun='mean')
###Time 2
ggplot(pa_data, aes(group, PA2))+geom_bar(position = 'dodge', stat='summary', fun='mean')
###Time 3
ggplot(pa_data, aes(group, PA3))+geom_bar(position = 'dodge', stat='summary', fun='mean')



####Adjusting DataFrame to look at all time points
#Separate Data Frame by Time Point

df_PA1 <- pa_data[,c('ID', 'PA1', 'group')]
df_PA2 <- pa_data[,c('ID', 'PA2', 'group')]
df_PA3 <- pa_data[,c('ID', 'PA3', 'group')]

#Add identifier for Timepoint
df_PA1['TP'] = 1
df_PA2['TP'] = 2
df_PA3['TP'] = 3

#Fix Adjust Column Name for consistency
colnames(df_PA1)[2] <- "PA"
colnames(df_PA2)[2] <- "PA"
colnames(df_PA3)[2] <- "PA"

#Reconstruct Dataframe
adjusted_df <- rbind(df_PA1, df_PA2, df_PA3)

####Chart at all time points 
####PA levels 
ggplot(adjusted_df, aes(x=TP, y=PA, group=group))+geom_bar(position='dodge', stat='summary', fun='mean')
####Make it purty 
###Change width of bars 
ggplot(adjusted_df, aes(x=TP, y=PA, group=group))+geom_bar(position='dodge', stat='summary', fun='mean', width=0.75)
#####Add Color
ggplot(adjusted_df, aes(x=TP, y=PA, group=group))+geom_bar(position='dodge', stat='summary', fun='mean', width=0.75, color='purple', fill='gold')
#####Barplot with labels 
ggplot(adjusted_df, aes(x=TP, y=PA, group=group))+geom_bar(position='dodge', stat='summary', fun='mean', width=0.75, color='purple', fill='gold')+geom_text((aes(label=XYZ)), vjust=1.6, color="purple", size=3.5)+theme_minimal()
###Change legend position ####why is legend not showing up?
g <- ggplot(adjusted_df, aes(x=TP, y=PA, group=group, fill=group))+geom_bar(position='dodge', stat='summary', fun='mean', width=0.75, color='purple', fill='gold')
g + theme(legend.position = 'top')

###Would like to look at how to add SD and average on top of chart 
ggplot(adjusted_df, aes(x=TP, y=PA, group=group))+geom_bar(position='dodge', stat='summary', fun='mean')+geom_errorbar(ymin=, ymax= ) ####Adding SD for this chart?

