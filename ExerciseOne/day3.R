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

datasetM.withoutFour <- datasetM[, !names(datasetM) %in% c("Experience", "Gender", "Duration", "Post.ID")]

# datasetM.withoutFour <- datasetM[, c(1,2,3,4)]

dasda <- c(1:9)
asdasr <- !(dasda %in% c(4:5))
asdasr

# Correlation
# http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
corrplot(cor(datasetM.withoutFour), order = "hclust", type = "lower",  method = "number")
cor(datasetM.withoutFour, method = "kendall")
cor(datasetM.withoutFour, method = "spearman")

scatterplot(datasetM.withoutFour$Total.Reach, datasetM.withoutFour$Fanpage.Reach)
abline(lm(Total.Reach~Fanpage.Reach, data = datasetM.withoutFour), col="red") # regression line (y~x) 
plot(datasetM.withoutFour$Earned.Reach, datasetM.withoutFour$Likes)
plot(datasetM.withoutFour$Acquaintance, datasetM.withoutFour$User.NW)

# dr1 <- dr1 + coord_cartesian(xlidr1 = c(0, 40), ylidr1=c(0,33)) + scale_x_continuous(breaks = seq(0, 40, 1)) 
# dr1 <- dr1 + scale_y_continuous(breaks = seq(0, 33, 1))
# dr1 <- dr1 + geodr1_vline(xintercept = dr1ean(datasetM$Likes), size = 2, colour = "red")
dr1
