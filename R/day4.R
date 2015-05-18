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

# https://stackoverflow.com/questions/4357031/qqnorm-and-qqline-in-ggplot2
qqplot.data <- function (vec) # argument: vector of numbers
{
  # following four lines from base R's qqline()
  y <- quantile(vec[!is.na(vec)], c(0.25, 0.75))
  x <- qnorm(c(0.25, 0.75))
  slope <- diff(y)/diff(x)
  int <- y[1L] - slope * x[1L]
  
  d <- data.frame(resids = vec)
  
  ggplot(d, aes(sample = resids)) + stat_qq() + geom_abline(slope = slope, intercept = int)
  
}

qqplot.data(datasetM$User.Engage)
qqplot.data(datasetM$Acquaintance)
qqplot.data(datasetM$Experience)

qqplot.data(dataset.product$User.Engage)
qqplot.data(dataset.product$Acquaintance)
qqplot.data(dataset.product$Experience)
















