#This script attempts to figure out which employees left the firm and when
#by using the ldap files by month and seeing the differences
library(data.table)
library(plyr)
library(ggplot2)
library(ggthemes)
library(scales)
library(dplyr)
library(timeDate)

Dec_09_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2009-12.csv')
Jan_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-01.csv')
Feb_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-02.csv')
Mar_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-03.csv')
Apr_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-04.csv')
May_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-05.csv')
Jun_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-06.csv')
Jul_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-07.csv')
Aug_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-08.csv')
Sep_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-09.csv')
Oct_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-10.csv')
Nov_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-11.csv')
Dec_10_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2010-12.csv')
Jan_11_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2011-01.csv')
Feb_11_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2011-02.csv')
Mar_11_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2011-03.csv')
Apr_11_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2011-04.csv')
May_11_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/LDAP/2011-05.csv')

Dec_09_df$date <- as.POSIXct(strptime("12/01/2009", "%m/%d/%Y"))
Jan_10_df$date <- as.POSIXct(strptime("01/01/2010", "%m/%d/%Y"))
Feb_10_df$date <- as.POSIXct(strptime("02/01/2010", "%m/%d/%Y"))
Mar_10_df$date <- as.POSIXct(strptime("03/01/2010", "%m/%d/%Y"))
Apr_10_df$date <- as.POSIXct(strptime("04/01/2010", "%m/%d/%Y"))
May_10_df$date <- as.POSIXct(strptime("05/01/2010", "%m/%d/%Y"))
Jun_10_df$date <- as.POSIXct(strptime("06/01/2010", "%m/%d/%Y"))
Jul_10_df$date <- as.POSIXct(strptime("07/01/2010", "%m/%d/%Y"))
Aug_10_df$date <- as.POSIXct(strptime("08/01/2010", "%m/%d/%Y"))
Sep_10_df$date <- as.POSIXct(strptime("09/01/2010", "%m/%d/%Y"))
Oct_10_df$date <- as.POSIXct(strptime("10/01/2010", "%m/%d/%Y"))
Nov_10_df$date <- as.POSIXct(strptime("11/01/2010", "%m/%d/%Y"))
Dec_10_df$date <- as.POSIXct(strptime("12/01/2010", "%m/%d/%Y"))
Jan_11_df$date <- as.POSIXct(strptime("01/01/2011", "%m/%d/%Y"))
Feb_11_df$date <- as.POSIXct(strptime("02/01/2011", "%m/%d/%Y"))
Mar_11_df$date <- as.POSIXct(strptime("03/01/2011", "%m/%d/%Y"))
Apr_11_df$date <- as.POSIXct(strptime("04/01/2011", "%m/%d/%Y"))
May_11_df$date <- as.POSIXct(strptime("05/01/2011", "%m/%d/%Y"))

all_LDAPs <- rbind(Dec_09_df, Jan_10_df, Feb_10_df, Mar_10_df, Apr_10_df, May_10_df, Jun_10_df, 
      Jul_10_df, Aug_10_df, Sep_10_df, Oct_10_df, Nov_10_df, Dec_10_df, Jan_11_df, 
      Feb_11_df, Mar_11_df, Apr_11_df, May_11_df)

month_counts <- aggregate(user_id ~ date, data = all_LDAPs, FUN = length)

roles <- unique(Dec_09_df$Role)

role_counts <- aggregate(user_id ~ Role, data = Dec_09_df, FUN = length)

names(role_counts) <- c("role", "count_values")

role_counts <- role_counts[order(-role_counts$count_values),]

ggplot(role_counts, aes(reorder(role_counts$role,role_counts$count_values), role_counts$count_values)) +
  geom_bar(stat = "identity") + xlab('role') + ylab('count values') +
     theme(panel.background = element_blank(),axis.ticks = element_blank()) + 
      coord_flip()