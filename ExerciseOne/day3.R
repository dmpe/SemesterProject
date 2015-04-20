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
library(car)

datasetM <- read.xlsx("Data/DataSet_01.xlsx", sheetIndex = 1, endRow=277)
datasetM.withoutFour <- datasetM[, !names(datasetM) %in% c("Experience", "Gender", "Duration", "Post.ID")]

# Correlation
# http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
# http://stackoverflow.com/questions/15409820/indexing-a-correlation-matrix
corrrePart <- cor(datasetM.withoutFour)
corrplot(corrrePart, order = "hclust", type = "lower",  method = "number")

corrrePart[lower.tri(corrrePart)] <- NA
corrrePart <- data.frame(corrrePart)
which(corrrePart > 0.7, arr.ind=TRUE)

rowMeans(corrrePart, na.rm = T) 
# I took over 0.7 !!!
scatterplot(datasetM.withoutFour$Likes, datasetM.withoutFour$User.Engage)
scatterplot(datasetM.withoutFour$Comments, datasetM.withoutFour$User.Engage)
scatterplot(datasetM.withoutFour$Likes, datasetM.withoutFour$Earned.Reach)
scatterplot(datasetM.withoutFour$Likes, datasetM.withoutFour$Total.Reach)
scatterplot(datasetM.withoutFour$Comments, datasetM.withoutFour$Total.Reach)
scatterplot(datasetM.withoutFour$Total.Reach, datasetM.withoutFour$Fanpage.Reach)
scatterplot(datasetM.withoutFour$Earned.Reach, datasetM.withoutFour$Total.Reach)
scatterplot(datasetM.withoutFour$Acquaintance, datasetM.withoutFour$User.NW)


plot(datasetM.withoutFour$Total.Reach, datasetM.withoutFour$Fanpage.Reach)
abline(lm(Fanpage.Reach~Total.Reach, data = datasetM.withoutFour), col="red") # regression line (y~x) 

plot(datasetM.withoutFour$Earned.Reach, datasetM.withoutFour$Likes)
plot(datasetM.withoutFour$Acquaintance, datasetM.withoutFour$User.NW)

