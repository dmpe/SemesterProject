library(xlsx)
library(Hmisc)
library(ggplot2)
library(clustrd)
library(reshape2)
library(corrplot)
library(car)
library(dplyr)
library(plyr)

dataset.product <- read.xlsx("Data/DataSet_Product.xlsx",sheetIndex = 1 , endRow = 302)
dataset.product$ProductDataSet <- 1
dataset.product.withoutFour <- dataset.product[, !names(dataset.product) %in% c("Duration", "Post.ID")]

summary(dataset.product.withoutFour)

Product <- cor(dataset.product.withoutFour)
corrplot(Product, type="lower", method="number")


joinedDataSets <- full_join(dataset.product, datasetM)
joinedDataSets.without <- joinedDataSets[, !names(joinedDataSets) %in% c("Duration", "Post.ID", "Earned.Reach", "Fanpage.Reach", "User.NW", "X.Match")]




