#Baseball Script

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


###Scrape Data
conference_season_data <- read_html("https://static.theamerican.org/custompages/Stats/baseball/2022/lgplyrs.htm#leagp.ldr")

tables <- html_nodes(conference_season_data, css = "table")
tables <- html_table(tables, fill = TRUE)
 ###why do you need double brackets###
hitting <- tables[[2]]
colnames(hitting) <- make.names(colnames(hitting))

pitching <-tables[[4]]
colnames(pitching) <- make.names(colnames(pitching))

fielding <- tables[[6]]
colnames(fielding) <- make.names(colnames(fielding))

#Identifying correct column names and deleting repeated label row.
hitting <- hitting %>%
  row_to_names(row_number = 1)
hitting
hitting <- hitting[-53, ]
hitting <- hitting[-63, ]
hitting <- hitting[-126, ]
hitting <- hitting[-53, ]
  ###could you explain the parts that were removed?
pitching <- pitching %>%
  row_to_names(row_number = 1)
pitching
pitching <- pitching[-26, ]
pitching <- pitching[-63, ]
pitching <- pitching[-127, ]
pitching <- pitching[-126, ]
pitching <- pitching[-25, ]

fielding <- fielding %>%
  row_to_names(row_number = 1)
fielding
fielding <- fielding[-63, ]
fielding <- fielding[-126, ]
fielding <- fielding[-191, ]
fielding <- fielding[-252, ]
fielding <- fielding[-189, ]

###Initializing variable in new df and data cleaning #####will need an explanation for this###
hitting <- hitting %>%
  separate(Player, c('Last Name', 'Team'), ', ', extra ="merge") %>%
  separate(Team, c('Delete', 'Team'), ', ', fill ="left") %>%
  separate(`gp-gs`, c('gp', 'gs'), '-') %>%
  separate(`sb-att`, c('sb','att'), '-')
hitting[2] <- NULL
hitting 

pitching <- pitching %>%
  separate(Player,c('Last Name','Team'), ', ', extra ="merge") %>%
  separate(Team,c('Delete','Team'), ', ', fill = "left") %>% 
  separate(`w-l`,c('w','l'), '-') %>%
  separate(`app-gs`,c('app','gs'), '-')
pitching[2] <- NULL

fielding <- fielding %>%
  separate(Player,c('Last Name','Team'), ', ', extra ="merge") %>%
  separate(Team,c('Delete','Team'), ', ', fill = "left") 
fielding[2] <- NULL

hitting <- hitting %>% 
  mutate_at(c(3:23), as.numeric) %>%
  filter(ab >= 25)
pitching <- pitching %>%
  mutate_at(c(3:8,10:24), as.numeric) %>%
  filter(ip >= 8)
fielding <- fielding %>%
  mutate_at(c(3:13), as.numeric)

#Calculation of individual, total, and opponents 'Batting Average on Balls in Play'.
#This is calculated by using the formula: (H - HR)/(AB - K - HR + SF).
hitting$BABIP <- length(hitting$Team)
hitting$BABIP <- ((hitting$h) - (hitting$hr)) / ((hitting$ab) - (hitting$hr) - (hitting$so) + (hitting$sf))
pitching$BABIP <- length(pitching$Team)
pitching$BABIP <- ((pitching$h) - (pitching$hr)) / ((pitching$ab) - (pitching$hr) - (pitching$so))

#Calculation of individual, total, and opponents 'Isolated Power'. This is calculated by using the
#formula: (1x2B + 2x3B + 3xHR) / AB
hitting$ISO <- length(hitting$Team)
hitting$ISO <- (((hitting$`2b`) + (hitting$`3b` * 2) + (hitting$hr * 3)) / (hitting$ab))

#Calculation of individual, total, and opponents 'Runs Created'. This is calculated by using the
#formula: TB x (H + BB) / (AB + BB).
hitting$RC <- length(hitting$Team)
hitting$RC <- (((hitting$tb)*((hitting$h)+(hitting$bb))/((hitting$ab)+(hitting$bb))))

#Calculation of individual, total, and opponents 'Offensive Strikeout Rate'. 
#This is calculated by using the formula: (SO)/(AB + BB + HBP + SF + SH). 
hitting$SOR <- length(hitting$Team)
hitting$SOR <- (((hitting$so)/((hitting$ab)+(hitting$bb)+(hitting$hbp)+(hitting$sf)+
                                 (hitting$sh))))

#Calculation of Total Extra Basehits (XBH). This is calculated by using the
#formula: X2B + X3B + HR.
hitting$XBH <- length(hitting$Team)
hitting$XBH <- (((hitting$`2b`)+(hitting$`3b`)+(hitting$hr)))

#Calculation of individual, total, and opponents 'Offensive Walk Rate'. This is 
#calculated by using the formula: (BB)/(AB + BB + HBP + SF + SH).
hitting$BBR <- length(hitting$Team)
hitting$BBR <- (((hitting$bb)/((hitting$ab)+(hitting$bb)+(hitting$hbp)+(hitting$sf)+
                                 (hitting$sh))))

#Calculation of individual, total, and opponents 'K/9'. This is 
#calculated by using the formula: (SO*9)/IP. 
pitching$K9 <- length(pitching$Team)
pitching$K9 <- (((pitching$so)*9)/(pitching$ip))

#Calculation of individual, total, and opponents 'BB/9'. This is 
#calculated by using the formula: (BB*9)/IP. 
pitching$BB9 <- length(pitching$Team)
pitching$BB9 <- (((pitching$bb)*9)/(pitching$ip))

#Calculation of individual, total, and opponents 'LOB%'. This is 
#calculated by using the formula: (H+BB+HBP-R)/(H+BB+HBP-(1.4*HR)). 
pitching$LOB <- length(pitching$Team)
pitching$LOB <- (((pitching$h)+(pitching$bb)+(pitching$hbp)-(pitching$r))/((pitching$h)+(pitching$bb)+(pitching$hbp)-((pitching$hr)*1.4)))







