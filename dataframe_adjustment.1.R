#Separate Data Frame by Time Point

df_PA1 <- df[,c('id', 'PA1', 'group']
df_PA2 <- df[,c('id', 'PA2', 'group']
df_PA3 <- df[,c('id', 'PA3', 'group']

#Add identifier for Timepoint
df_PA1['TP'] = 1
df_PA2['TP'] = 2
df_PA3['TP'] = 3

#Fix Adjust Column Mame for consistency
colnames(df_PA1)[2] <- "PA"
colnames(df_PA2)[2] <- "PA"
colnames(df_PA3)[2] <- "PA"

#Reconstruct Dataframe
adjusted_df <- rbind(df_PA1, df_PA2, df_PA3)
