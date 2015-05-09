library(xlsx)
library(dplyr)

datasetM <- read.xlsx("/srv/shiny-server/SemesterProject/Data/DataSet_01.xlsx", sheetIndex = 1, endRow=277)
datasetM.withoutFour <- datasetM[, !names(datasetM) %in% c("Experience", "Gender", "Duration", "Post.ID")]
datasetM <- plyr::rename(datasetM, c("Total.Reach" = "TotalReach"))
datasetM$ServiceDataSet <- 0
datasetM.correlation <- datasetM[, !names(datasetM) %in% c("Duration", "X.Match","Post.ID", "ServiceDataSet", "Earned.Reach", "Fanpage.Reach", "TotalReach", "User.NW")]

dataset.product <- read.xlsx("/srv/shiny-server/SemesterProject/Data/DataSet_Product.xlsx",sheetIndex = 1 , endRow = 302)
dataset.product$ProductDataSet <- 1
dataset.product.withoutFour <- dataset.product[, !names(dataset.product) %in% c("Duration", "Post.ID")]
dataset.product.correlation <- dataset.product[, !names(dataset.product) %in% c("Duration", "Post.ID", "TotalReach", "ProductDataSet")]


dataset.product.correlation.cor <- cor(dataset.product.correlation)
datasetM.correlation.cor <- cor(datasetM.correlation)



joinedDataSets <- full_join(dataset.product, datasetM)
joinedDataSets.without <- joinedDataSets[, !names(joinedDataSets) %in% c("Duration", "Post.ID", "Earned.Reach", "Fanpage.Reach", "User.NW", "X.Match")]

joinedDataSets.without$TypeDataSet <- ifelse(is.na(joinedDataSets.without$ProductDataSet), joinedDataSets.without$ServiceDataSet, joinedDataSets.without$ProductDataSet)

# sapply(joinedDataSets.without, class)
# TypeDataSet vertical, horizontal Gender

joinedDataSets.without$Gender[joinedDataSets.without$Gender==0] <- "Woman"
joinedDataSets.without$Gender[joinedDataSets.without$Gender==1] <- "Man"

joinedDataSets.without$TypeDataSet[joinedDataSets.without$TypeDataSet==0] <- "Service"
joinedDataSets.without$TypeDataSet[joinedDataSets.without$TypeDataSet==1] <- "Produkt"

