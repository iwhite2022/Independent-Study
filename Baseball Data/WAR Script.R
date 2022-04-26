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

####WAR Stats 
#####WAR=(Batting Runs Above Replacement + Positional Adjustment + Base Running Runs + Fielding Runs)/runs per win

###Using Driveline Coefficients 2020

####Batting Runs Above Replacement 
    ###wOBA
            ##calculate weighted on-base average (wOBA) ***No intentional bbs listed in dataframe***
    ##Formula: wOBA=( BB factor x BB + HBP factor x HBP + 1B factor x 1B + 2B factor x 2B + 3B factor x 3B + HR factor x HR)/(AB +  BB + SF + HBP),
hitting$wOBA <- length(hitting$team)
hitting$wOBA <-((0.79689 * hitting$bb)+
                (0.81968 * hitting$hbp)+
                (0.97083 * hitting$h)+
                (1.28144 * hitting$`2b`)+
                (1.65008 * hitting$`3b`)
                +(2.0367 * hitting$hr))/
              (hitting$ab + hitting$bb + hitting$sf + hitting$hbp)
    ###Transforming wOBA to wRAA
        ##Formula: wRAA= (wOBA-0.346)/(1.095* at-bats)
hitting$wRAA <- length(hitting$team)
hitting$wRAA <- (hitting$wOBA - 0.346)/(1.095*hitting$ab)

####Not enough info from AAC to calculate positional Adjustment 


#####Pitching WAR
      ### WAR= ((Avg FIP - Pitcher FIP)/Dynamic Runs Per Wins + Wins Above Average)*IP/9
  ##Calculate Pitcher FIP
    ###Equation: (13*HR + 3*BB -2*K)/IP +C C=constant 3.909 (from Driveline)
pitching$FIP <- length(pitching$team)
pitching$FIP <- (((13 * pitching$hr) +
                    (3 * pitching$bb) - 
                    (2 * pitching$so)/pitching$ip) + 3.909)
  ####Calculate Avg. FIP for AAC players 
pitchingavgFIP <- mean(pitching$FIP)

  ##Calculate RPW 
    ###Equation: RPW : 9 * (Runs Scored/IP) * 1.5 +3
pitching$RPW <- length(pitching$team)
pitching$RPW <- (9 * (pitching$r/pitching$ip) *1.5 + 3)

  ###Calculate Wins Above Average ###will need to return to this 
AvgWins <- mean(pitching$w)
pitching$WAAV <- length(pitching$Team)
pitching$WAAV<- pitching$win/AvgWins





