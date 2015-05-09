library(xlsx)
library(Hmisc)
library(ggplot2)
library(clustrd)
library(reshape2)
library(corrplot)
library(car)
library(dplyr)
library(plyr)

source("R/day3.R")
# https://stat.ethz.ch/pipermail/r-help/2011-February/269918.html
# http://www.cookbook-r.com/Graphs/Facets_%28ggplot2%29/
# http://flowingdata.com/2012/05/15/how-to-visualize-and-compare-distributions/
# summary(dataset.product)

dataset.product <- read.xlsx("Data/DataSet_Product.xlsx",sheetIndex = 1 , endRow = 302)
dataset.product$ProductDataSet <- 1
dataset.product.correlation <- dataset.product[, !names(dataset.product) %in% c("Duration", "Post.ID", "TotalReach", "ProductDataSet")]

product <- cor(dataset.product.correlation)
corrplot(product, type="lower", method="number")

dev.off()
par(mfrow = c(1,2))
corrplot(product, order = "hclust", type="lower", method="number")
corrplot(corrrePart, order = "hclust", type = "lower",  method = "number")
dev.off()

##################
# Joined data Set
##################

joinedDataSets <- full_join(dataset.product, datasetM)
joinedDataSets.without <- joinedDataSets[, !names(joinedDataSets) %in% c("Duration", "Post.ID", "Earned.Reach", "Fanpage.Reach", "User.NW", "X.Match")]

joinedDataSets.without$TypeDataSet <- ifelse(is.na(joinedDataSets.without$ProductDataSet), joinedDataSets.without$ServiceDataSet, joinedDataSets.without$ProductDataSet)
sapply(joinedDataSets.without, class)

# TypeDataSet vertical, horizontal Gender
joinedDataSets.without$Gender[joinedDataSets.without$Gender==0] <- "Woman"
joinedDataSets.without$Gender[joinedDataSets.without$Gender==1] <- "Man"

joinedDataSets.without$TypeDataSet[joinedDataSets.without$TypeDataSet==0] <- "Service"
joinedDataSets.without$TypeDataSet[joinedDataSets.without$TypeDataSet==1] <- "Produkt"

sp <- ggplot(joinedDataSets.without, aes(x=Likes, y=User.Engage)) + geom_point(shape=1) + stat_smooth(method = "lm")
sp <- sp + facet_grid(TypeDataSet ~ Gender)
sp


sp <- ggplot(joinedDataSets.without, aes(x=Likes, y=User.Engage)) + geom_point(shape=1) + stat_smooth(method = "lm")
sp <- sp + facet_grid(Experience ~ Gender)
sp




corrrePart[lower.tri(corrrePart)] <- NA
product[lower.tri(product)] <- NA

rozdil <- as.data.frame(corrrePart) - as.data.frame(product)

# outer(corrrePart, product, "-")
# dasdsdawr <- t(apply(corrrePart, 1, function(x) corrrePart-product))
# sweep(corrrePart,2,c(0,0,product))


