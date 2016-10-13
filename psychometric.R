library(data.table)
library(plyr)
library(dplyr)
pysch <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r3.2/psychometric.csv')
ldap1 <- fread('https://s3.amazonaws.com/daen-690-insider-threat/r3.2/LDAP/2009-12.csv')
supervisor <- unique(ldap1$supervisor)
pysch <- inner_join(pysch, ldap1, by='user_id')
roles <- unique(ldap1$role)
i <- 1
for (x in 1:length(roles)) {
  assign(roles[i][1],filter(pysch, pysch$role==roles[i][1]))
  i <- i + 1
}

bigfive <- data.frame(c('role',1,1,1,1,1))
i <- 1
for (x in 1:length(roles)) {
  assign(bigfive[i][1],roles[i][1])
  assign(bigfive[i][1],roles[i][1])
  i <- i + 1
}
