###MLB Data Scrap

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
library(xml2)
library(rvest)

###Scrape Data
stat_link = "https://www.mlb.com/stats/?page=1"
mlb_data = read_html(stat_link)
  ###string for data scraping 
newstat_link = "https://www.mlb.com/stats/?page=%s"
  ###Create dataframe of stats
mlb_base <- rvest::html_table(mlb_data) [[1]] %>%
  tibble::as_tibble(.name_repair = "unique")

###Create dataframe of next set of stats
  ##create two empty dataframes
  new_table <- data.frame()
  df <- data.frame()
  
  #iterator
  i <- 1
  
  ###loop through eight times so to extract, store, and combine 
  while (i < 9) {
    new_page <- read_html(sprintf(newstat_link,i))
    new_table <- rvest::html_table(new_page) [[1]] %>%
      tibble::as_tibble(.name_repair = "unique")
    df <- rbind(df, new_table)
    i=i+1
  }
  
df_mlb <- merge(new_table, df, all=T)
