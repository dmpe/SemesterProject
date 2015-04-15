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
library(corrplot)


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

sapply(datasetM, class)

pCA <- prcomp(datasetM, scale = TRUE)
summary(pCA)

# http://stackoverflow.com/questions/2547402/standard-library-function-in-r-for-finding-the-mode
Mode.SD <- function(x) {
ux <- unique(x)
#ux[which.max(tabulate(match(x, ux)))]
  tab <- tabulate(match(x, ux))
  ux[tab == max(tab)] 
}

sdas <- Mode.SD(datasetM$User.Engage)
sdas

library(modeest)
mlv(datasetM$User.Engage, method = "mfv")

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

head(datasetM)

likesComm <- ggplot(datasetM, aes(x=Likes, y=Comments))
likesComm <- likesComm + stat_smooth() + geom_point()
likesComm

plot(lm(Likes~Comments, data=datasetM))



# # Intervals User Eng.
# 180-360
# 361-720
# 721-1080
# 1081-1440
# 1441-1840
# 
# # Intervals Aquita
# 0-200
# 201-400
# 401-600
# 601-800
# http://www.r-bloggers.com/r-function-of-the-day-cut/

# breaks = seq(180, 1840, by = 260)
rota2 <- cut(datasetM$X.Match, 40, dig.lab = 4)
barplot(table(rota2))

m <- ggplot(rota2, aes(x=Total.Reach))
m <- m + geom_histogram(aes(y=..density..), colour="black", fill="white")
m <- m + geom_density()
m

# an Prof
# Wie die Ergebsniess am Ende aussehen sollen
# Mit leuten entscheidung uber Presentatino
# Genaue beschreibung von Aufgabe- nicht nur mit Merkmale
# Feedback geben konnte? 361, 721, 1080, 1081,



Principal Component Analysis

```{r}
pca <- prcomp(datasetM[2:11], scale = TRUE)
summary(pca)
```

names(datasetM[2:13])

"Acquaintance"
"Total.Reach"
"Gender"



sapply(datasetM, hist)


2,5,8, 11

summary(datasetM)






