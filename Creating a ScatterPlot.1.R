library(readr)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)

#load initial data frame
library(readr)
thesis_data <- read_csv()
View(thesis_data)

#### Extracting specific columns of data into a new data frame (new columns)
pa_data <- data.frame(thesis_data$PARTID,thesis_data$Group, thesis_data$TOTALMETMIN.1, thesis_data$TOTALMETMIN.2, thesis_data$TOTALMETMIN.3)
###Renaming columns 
names(pa_data) <- data.frame('ID', 'group', 'PA1', 'PA2', 'PA3')

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

##Initialize dataset
data.frame("adjusted_df", package='ggplot2')

###initialize ggplot
ggplot(adjusted_df, aes(x=TP, y=PA))

####Simple Scatter plot ###Would not want to utilize this data for this type of graph but what would be appropriate (x=Comp, y=pa?)
ggplot(adjusted_df, aes(x=TP, y=PA))+geom_point()

  ####Add Linear Model to Simple Scatter plot 
ggplot(adjusted_df, aes(x=TP, y=PA))+geom_point()+geom_smooth(method = 'lm')

###Adjust X and Y Axis Limits
g <- ggplot(adjusted_df, aes(x=TP, y=PA))+geom_point()+geom_smooth(method = 'lm')
g1 <-g + xlim(c(1,3))+ylim(c(0, 28000))

###Zoom in on Chart 
g2 <- g1 + coord_cartesian(xlim=c(1,1), ylim=c(0,28000))

####Change Title and Axis Labels 
g1 + labs(title = "Physical Activity at Each Timepoint", subtitle = "This is a terrible scatterplot and should not be used for this data", y="Physical Activity", x="Timepoint", caption="Ooof")

###Change Color and Size of Points 
g3 <- ggplot(adjusted_df, aes(x=TP, y=PA))+geom_point()+geom_smooth(method = 'lm', col='firebrick', size=2.5)
g3 <- g3 + xlim(c(1,3))+ylim(c(0, 28000))
g3 <- g3 + labs(title = "Physical Activity at Each Timepoint", subtitle = "This is a terrible scatterplot and should not be used for this data", y="Physical Activity", x="Timepoint", caption="Ooof")
plot(g3)

###Change color to Reflect Categories in another column #####does not work for this graph but understand the gist of it now 
gg <-ggplot(adjusted_df, aes(x=TP, y=PA))+ geom_point(aes(col=ID), size=3)

####Add Jitter to First plot 
g <- ggplot(adjusted_df, aes(jitter(x=TP), y=PA))+geom_point()+geom_smooth(method = 'lm')
plot(g)












