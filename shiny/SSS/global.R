library(xlsx)

datasetM <- read.xlsx("/srv/shiny-server/SemesterProject/Data/DataSet_01.xlsx", sheetIndex = 1, endRow=277)
datasetM.withoutFour <- datasetM[, !names(datasetM) %in% c("Experience", "Gender", "Duration", "Post.ID")]



dataset.product <- read.xlsx("/srv/shiny-server/SemesterProject/Data/DataSet_Product.xlsx",sheetIndex = 1 , endRow = 302)
dataset.product.withoutFour <- dataset.product[, !names(dataset.product) %in% c("Duration", "Post.ID")]
