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

















