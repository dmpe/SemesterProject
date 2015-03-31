library(xlsx)
library(mi)
library(Hmisc)
library(ggplot2)
library(cluster)
library(NbClust)
library(ggplot2)
library(clustrd)
library("ggthemes")
library(reshape2)
library(gridExtra)

datasetM <- read.xlsx("Data/DataSet_01.xlsx", sheetIndex = 1, endRow=277)
mi.info(datasetM)
typecast(datasetM)

sapply(datasetM, is.ordered)
sapply(datasetM, is.numeric)

m <- ggplot(datasetM, aes(x=Likes))
m <- m + geom_histogram(binwidth = 0.5)
m <- m + coord_cartesian(xlim = c(0, 40), ylim=c(0,33)) + scale_x_continuous(breaks = seq(0, 40, 1)) 
m <- m + scale_y_continuous(breaks = seq(0, 33, 1))
m

w <- ggplot(datasetM, aes(x=Comments))
w <- w + geom_histogram(binwidth = 0.5)
w <- w + coord_cartesian(xlim = c(0, 40), ylim=c(0,50)) + scale_x_continuous(breaks = seq(0, 40, 1))
w <- w + scale_y_continuous(breaks = seq(0, 50, 1))
w

sapply(datasetM, table)


regre <- lm(datasetM$User.Engage ~ datasetM$Acquaintance + datasetM$Total.Reach, data = datasetM)

summary.lm(regre)

l <- qplot(User.Engage, Total.Reach, data = datasetM)
l <- l + geom_smooth(aes(group=Gender), method="lm")
l

klust <- kmeans(dist(datasetM, method = "euclidean"), 2, nstart = 25, iter.max = 100)
plot(datasetM, col = klust$cluster)
dataWithCluster <- data.frame(datasetM[2:13], klust$cluster)  # append cluster assignment
aggregate(datasetM[, 2:13], by=list(klust$cluster), FUN = mean) # get cluster means


clust <- names(sort(table(klust$clust)))
row.names(dataWithCluster[klust$clust==clust[1],]) 
row.names(dataWithCluster[klust$clust==clust[2],])

datasetM

likesComm <- ggplot(datasetM, aes(x=Likes, y=Comments))
likesComm <- likesComm + stat_smooth() + geom_point()
likesComm

plot(lm(Likes~Comments, data=datasetM))
