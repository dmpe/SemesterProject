library(xlsx)
library(Hmisc)
library(ggplot2)
library(clustrd)
library(reshape2)
library(corrplot)
library(car)
library(dplyr)
library(plyr)

# https://stat.ethz.ch/pipermail/r-help/2011-February/269918.html
# http://www.cookbook-r.com/Graphs/Facets_%28ggplot2%29/

dataset.product <- read.xlsx("Data/DataSet_Product.xlsx",sheetIndex = 1 , endRow = 302)
dataset.product$ProductDataSet <- 1
dataset.product.withoutFour <- dataset.product[, !names(dataset.product) %in% c("Duration", "Post.ID")]

summary(dataset.product.withoutFour)

Product <- cor(dataset.product.withoutFour)
corrplot(Product, type="lower", method="number")


joinedDataSets <- full_join(dataset.product, datasetM)
joinedDataSets.without <- joinedDataSets[, !names(joinedDataSets) %in% c("Duration", "Post.ID", "Earned.Reach", "Fanpage.Reach", "User.NW", "X.Match")]

joinedDataSets.without$TypeDataSet <- ifelse(is.na(joinedDataSets.without$ProductDataSet), joinedDataSets.without$ServiceDataSet, joinedDataSets.without$ProductDataSet)

sapply(joinedDataSets.without, class)

# TypeDataSet vertical, horizontal Gender
joinedDataSets.without$Gender[joinedDataSets.without$Gender==0] <- "Woman"
joinedDataSets.without$Gender[joinedDataSets.without$Gender==1]   <- "Man"

joinedDataSets.without$TypeDataSet[joinedDataSets.without$TypeDataSet==0] <- "Service"
joinedDataSets.without$TypeDataSet[joinedDataSets.without$TypeDataSet==1]   <- "Produkt"

sp <- ggplot(joinedDataSets.without, aes(x=Likes, y=User.Engage)) + geom_point(shape=1) + stat_smooth(method = "lm")
sp <- sp + facet_grid(TypeDataSet ~ Gender)
sp
