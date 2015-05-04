library(xlsx)
library(plyr)
library(Hmisc)
library(ggplot2)
library(clustrd)
library(reshape2)
library(corrplot)
library(car)

# Correlation
# http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
# http://stackoverflow.com/questions/15409820/indexing-a-correlation-matrix

datasetM <- read.xlsx("Data/DataSet_01.xlsx", sheetIndex = 1, endRow=277)
datasetM <- plyr::rename(datasetM, c("Total.Reach" = "TotalReach"))
datasetM$ServiceDataSet <- 0
datasetM.withoutFour <- datasetM[, !names(datasetM) %in% c("Experience", "Gender", "Duration", "Post.ID", "ServiceDataSet", "Earned.Reach", "Fanpage.Reach")]


corrrePart <- cor(datasetM.withoutFour)
corrplot(corrrePart, order = "hclust", type = "lower",  method = "number")

corrrePart[lower.tri(corrrePart)] <- NA
# corrrePart <- data.frame(corrrePart)
# which(corrrePart > 0.7, arr.ind=TRUE)

# rowMeans(corrrePart, na.rm = T) 
# I took over 0.7 !!!
# scatterplot(datasetM.withoutFour$Likes, datasetM.withoutFour$User.Engage)
# scatterplot(datasetM.withoutFour$Comments, datasetM.withoutFour$User.Engage)
# scatterplot(datasetM.withoutFour$Likes, datasetM.withoutFour$Earned.Reach)
# scatterplot(datasetM.withoutFour$Likes, datasetM.withoutFour$Total.Reach)
# scatterplot(datasetM.withoutFour$Comments, datasetM.withoutFour$Total.Reach)
# scatterplot(datasetM.withoutFour$Total.Reach, datasetM.withoutFour$Fanpage.Reach)
# scatterplot(datasetM.withoutFour$Earned.Reach, datasetM.withoutFour$Total.Reach)
# scatterplot(datasetM.withoutFour$Acquaintance, datasetM.withoutFour$User.NW)
# 
# scatterplot(datasetM.withoutFour$Acquaintance, datasetM.withoutFour$User.Engage)
# scatterplot(datasetM$User.Engage, datasetM$Experience)
# 
# scatterplot(datasetM$Experience, datasetM$User.Engage)
# 
# cor(datasetM$User.Engage, datasetM$Experience)


# 
# plot(datasetM.withoutFour$Total.Reach, datasetM.withoutFour$Fanpage.Reach)
# abline(lm(Fanpage.Reach~Total.Reach, data = datasetM.withoutFour), col="red") # regression line (y~x) 
# 
# plot(datasetM.withoutFour$Earned.Reach, datasetM.withoutFour$Likes)
# plot(datasetM.withoutFour$Acquaintance, datasetM.withoutFour$User.NW)
















