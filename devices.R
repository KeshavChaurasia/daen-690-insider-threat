library(data.table)
library(plyr)
library(ggplot2)
library(ggthemes)
library(scales)
library(dplyr)
library(timeDate)
device_df <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/device.csv')

device_df$date <- as.POSIXct(strptime(device_df$date, "%m/%d/%Y %H:%M:%S"))

options(scipen=10)

hist(device_df$date, breaks="month", freq=TRUE,
     main="Distribution",
     col="slateblue1", xlab="",
     format="%b %Y", las=2)
