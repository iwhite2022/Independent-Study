# Step 7: Create summary data frame
#####
#remove some unwanted columns
all_stat_full$Pos.x <- NULL
all_stat_full$Age.x <- NULL
all_stat_full$`#.x` <- NULL
all_stat_full$Pos.x <- NULL
all_stat_full$Age.x <- NULL
all_stat_full$`#.x` <- NULL

#Sum all stats for each player
all_stat_full <- all_stat_full %>% 
  group_by(Player) %>% 
  summarise_each(list(sum))

View(all_stat_full)

#Look at the available player names.
View(unique(all_stat_full$Player))

#Select the players you want to see. Choose 8 players for better visual results.
selected_players <- subset(all_stat_full, 
                           Player=="Kylian Mbappé" |
                             Player=="Antoine Griezmann" |
                             Player=="Harry Kane" |
                             Player=="Kai Havertz" |
                             Player=="Cristiano Ronaldo" |
                             Player=="Álvaro Morata" |
                             Player=="Memphis Depay" |
                             Player=="Patrik Schick" |
                             Player=="James Maddison" |
                             Player=="Declan Rice" |
                             Player=="Jorginho" |
                             Player=="Breel Embolo")
#####
# Step 9: Create the radar plots
#####
#attach the dataset
attach(selected_players)

#select the statistics we want to see and prepare for the plot
Sel <- data.frame("xG"=`Expected >> xG`,
                  "Dr"=`Dribbles >> Succ.x`,
                  "Pass"=`Passes >> Cmp`,
                  "Sh"=`Performance >> Sh`,
                  "SoT"=`Performance >> SoT`,
                  "KP"=`KP`)
Sel <- mutate_all(Sel, function(x) as.numeric(as.character(x)))

#run the radialprofile function with std=T, which standardizes the data so that the scale looks normal
p <- radialprofile(data=Sel, title=selected_players$Player, std=T)
detach(selected_players)