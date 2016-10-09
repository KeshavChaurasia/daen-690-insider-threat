library(data.table)
library(plyr)
library(ggplot2)
library(ggthemes)
mydat <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r1/http.csv')
mydat <- rbind(mydat,mydat[1])
names(mydat) <- c('id','date_stamp','user','pc','url')
url_counts <- aggregate(id ~ url, data = mydat, FUN = length)
url_counts <- sample_n(url_counts, 500, replace=TRUE)
names(url_counts) <- c("url", "count_values")
url_counts <- url_counts[order(-url_counts$count_values),]
top_15 <- head(url_counts, 15)
ggplot(top_15, aes(reorder(top_15$url,top_15$count_values), top_15$count_values)) + 
  xlab('url') + ylab('count') + geom_bar(stat = "identity", fill='blue') + 
  coord_flip() + geom_text(aes(label=top_15$count_values), hjust="left", size=2)
