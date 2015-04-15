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


# Correlation
# http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
corrplot(cor(datasetM[2:11]), order = "hclust", type = "lower",  method = "number")
