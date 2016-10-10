library(data.table)
library(plyr)
library(ggplot2)
library(ggthemes)
library(scales)
library(dplyr)
library(timeDate)
mydat <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/http.csv')
copydat <- mydat
mydat <- rbind(mydat,mydat[1])
names(mydat) <- c('id','date_stamp','user','pc','url')
mydat$date_stamp <- as.POSIXct(strptime(mydat$date_stamp, "%m/%d/%Y %H:%M:%S"))
url_counts <- aggregate(id ~ url, data = mydat, FUN = length)
url_counts <- sample_n(url_counts, 500, replace=TRUE)
names(url_counts) <- c("url", "count_values")
url_counts <- url_counts[order(-url_counts$count_values),]
top_15 <- head(url_counts, 15)
# ggplot(top_15, aes(reorder(top_15$url,top_15$count_values), top_15$count_values,)) + 
#   xlab('url') + ylab('count') + geom_bar(stat = "identity", fill='green',position = 'dodge') + 
#   coord_flip() + 
#   geom_text(aes(label=comma(top_15$count_values), sep=','),
#             hjust=ifelse(top_15$count_values < 700000, -0.1, 1.1), size=2) + 
#   theme(panel.background = element_blank(),axis.ticks = element_blank(),
#         axis.title.x=element_blank()) + 
#   scale_y_discrete(labels = comma)
user_url_counts <- aggregate(id ~ url + user, data = mydat, FUN = length)
user_url_counts <- sample_n(user_url_counts, 500, replace=TRUE)
head(user_url_counts,15)
#to filter dataframe between two time periods, use the following structure
#mydat[(mydat$date_stamp>"2010-01-04 17:00:00 EST")&(mydat$date_stamp<"2010-01-04 23:59:59 EST")]
# mydat$hour <- cut(mydat$date_stamp, breaks = "hour")
# hour_counts <- aggregate(id ~ hour, data = mydat, FUN = length)
# names(hour_counts) <- c("hour", "count_values")
# ggplot(hour_counts, aes(hour_counts$hour, hour_counts$count_values)) + 
#   geom_bar(stat = "identity") + xlab('hour') + ylab('sites visited') +
#      theme(panel.background = element_blank(),axis.ticks = element_blank(),
#            axis.text.x=element_blank())
options(scipen=10)
hist(mydat$date_stamp, breaks="month", freq=TRUE,
     main="Distribution",
     col="slateblue1", xlab="",
     format="%b %Y", las=2)
subset <- mydat[(mydat$date_stamp>"2010-01-04 17:00:00 EST")&(mydat$date_stamp<"2010-01-14 23:59:59 EST")]

base <- ggplot(subset, aes(subset$date_stamp)) + geom_histogram() +
  scale_x_datetime(breaks = date_breaks("12 hours")) + 
  stat_bin(bins = 20) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
