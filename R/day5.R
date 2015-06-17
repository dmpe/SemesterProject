library(stats4)
library(car)
library(bbmle)
library(dplyr)
set.seed(5157)

source("R/day4.R")

#######
# http://www.iiap.res.in/astrostat/School07/R/reg.html
# http://www.r4all.org/maximum-likelihood-1/
# https://faculty.washington.edu/ezivot/econ424/maxLik.pdf
# http://www.exegetic.biz/blog/2013/08/fitting-a-model-by-maximum-likelihood/
# http://polisci2.ucsd.edu/dhughes/teaching/MLE_in_R.pdf
# https://de.mathworks.com/help/stats/mle.html
#######

testList <- as.list(runif(1000, 0.000, 1.000))
testList <- as.list(seq(0.0001, 1, length = 1000))

########################### Produkt
cor.list.UE.produkt <- NULL
for(k in 1:length(testList)) {
  cor.list.UE.produkt[[k]] <- cor(qqnorm((dataset.product$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                                  qqnorm((dataset.product$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}
labda.UE.produkt <- testList[[which.max(cor.list.UE.produkt == max(cor.list.UE.produkt))]]


cor.list.AQ.produkt <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ.produkt[[k]] <- cor(qqnorm((dataset.product$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                                  qqnorm((dataset.product$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}
labda.AQ.produkt <- testList[[which.max(cor.list.AQ.produkt == max(cor.list.AQ.produkt))]]

########################### Service
cor.list.UE.service <- NULL
for(k in 1:length(testList)) {
  cor.list.UE.service[[k]] <- cor(qqnorm((datasetM.correlation$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                                  qqnorm((datasetM.correlation$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}
labda.UE.service <- testList[[which.max(cor.list.UE.service == max(cor.list.UE.service))]]



cor.list.AQ.service <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ.service[[k]] <- cor(qqnorm((datasetM.correlation$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                                  qqnorm((datasetM.correlation$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}
labda.AQ.service <- testList[[which.max(cor.list.AQ.service == max(cor.list.AQ.service))]]

########################### Joined
cor.list.UE <- NULL
for(k in 1:length(testList)) {
  cor.list.UE[[k]] <- cor(qqnorm((joinedDataSets.without$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((joinedDataSets.without$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}
labda.UE.joined <- testList[[which.max(cor.list.UE == max(cor.list.UE))]]


plot(testList, cor.list.UE)

cor.list.AQ <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ[[k]] <- cor(qqnorm((joinedDataSets.without$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((joinedDataSets.without$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}
labda.AQ.joined <- testList[[which.max(cor.list.AQ == max(cor.list.AQ))]]

############################ Scatterplots vor und nach
############################
par(mfrow=c(2,3))
plot(datasetM.correlation$Acquaintance, datasetM.correlation$User.Engage)
plot(joinedDataSets.without$Acquaintance, joinedDataSets.without$User.Engage)
plot(dataset.product$Acquaintance, dataset.product$User.Engage)

plot((datasetM.correlation$Acquaintance^0.5-1)/0.5, (datasetM.correlation$User.Engage^0.5-1)/0.5)
plot((joinedDataSets.without$Acquaintance^0.5-1)/0.5, (joinedDataSets.without$User.Engage^0.5-1)/0.5)
plot((dataset.product$Acquaintance^0.5-1)/0.5, (dataset.product$User.Engage^0.5-1)/0.5)

dev.off()


par(mfrow=c(2,3))
plot(datasetM.correlation$Acquaintance, datasetM.correlation$User.Engage)
plot(joinedDataSets.without$Acquaintance, joinedDataSets.without$User.Engage)
plot(dataset.product$Acquaintance, dataset.product$User.Engage)

plot(datasetM.correlation$Acquaintance^labda.AQ.list[[1]], datasetM.correlation$User.Engage^labda.AQ.list[[1]])
plot(joinedDataSets.without$Acquaintance^labda.AQ.list[[3]], joinedDataSets.without$User.Engage^labda.AQ.list[[3]])
plot(dataset.product$Acquaintance^labda.AQ.list[[2]], dataset.product$User.Engage^labda.AQ.list[[2]])

dev.off()

################################ LM
################################

labda.UE.list <- c(labda.UE.service, labda.UE.produkt, labda.UE.joined)
labda.AQ.list <- c(labda.AQ.service, labda.AQ.produkt, labda.AQ.joined)

xAQ2 <- (dataset.product$Acquaintance^labda.AQ.list[[3]]-1)/labda.AQ.list[[3]]
yAQ2 <- (dataset.product$User.Engage^labda.UE.list[[3]]-1)/labda.UE.list[[3]]


xAQ2 <- (dataset.product$Acquaintance^0.5-1)/0.5
yAQ2 <- (dataset.product$User.Engage^0.5-1)/0.5

fit <- lm(yAQ2 ~ xAQ2)

cor(xAQ2, yAQ2)
plot(xAQ2, yAQ2)
abline(lm(yAQ2 ~ xAQ2))

mean(yAQ2)
sd(yAQ2)

summary(fit)
fit$coefficients
plot(fit)

######################## Manuell Betas bestimmen
########################

ellip <- matrix(1, length(xAQ2), 2) # einfach Z
ellip[, 2] <- xAQ2

ellip2 <- t(ellip) %*% ellip
ellip2

eigen(ellip2)

solve(ellip2) %*% t(ellip) %*% yAQ2

############################### Ellipse gleichung
###############################
# https://en.wikipedia.org/wiki/Confidence_region
# https://en.wikipedia.org/wiki/Ordinary_least_squares#Estimation
# http://www.weibull.com/hotwire/issue95/relbasics95.htm

shochzwei <- (sum(fit$residuals^2)) / (ellip2[1,1]-2)
Fverteilung <- 2 * shochzwei * 3 


confidenceEllipse(lm(yAQ2 ~ xAQ2), levels = 0.95)
head(as.matrix(confidenceEllipse(lm(yAQ2 ~ xAQ2), levels = 0.95)), 10)

xausrechenen <- sqrt( (ellip2[2,2] * Fverteilung) / ( ellip2[1,1] * ellip2[2,2] - ellip2[1,2]^2 ))

## fur den y-wurzel
## musi byt s minus jinak mi to nefunguje
firstOne <- (ellip2[1,2]^2) * (xausrechenen^2)
secondOne <- ellip2[1,1] * ellip2[2,2] * xausrechenen^2
thridOne <- ellip2[2,2] * Fverteilung^2

unterwurzel <- sqrt(firstOne - secondOne + thridOne)

yausrechenen <- ( (-ellip2[1,2] * xausrechenen) + 0) / ellip2[2,2]
yausrechenen12 <- ( (-ellip2[1,2] * xausrechenen) - 0) / ellip2[2,2]

xlist <- seq(-xausrechenen, xausrechenen, length = 64)
yausrechenen2 <- NULL
unterwurzel2 <- NULL

for( p in 1:length(xlist) ) {
  unterwurzel2[[p]] <- sqrt( (12751.6^2) * (xlist[[p]]^2) - (ellip2[1,1] * 579549.6 * (xlist[[p]]^2)) + (579549.6 * Fverteilung))
  yausrechenen2[[p]] <- ( (-12751.6 * xlist[[p]]) + unterwurzel2[[p]]) / 579549.6
}

yausrechenen2

# Lineares Modell Abschatzen
# 

EllipsenplotXY <- as.matrix(confidenceEllipse(lm(yAQ2 ~ xAQ2), levels = 0.95))


for (d in 1:52) {
  plot(EllipsenplotXY[,1], EllipsenplotXY[,2])
  abline(lm(EllipsenplotXY[,1] ~ EllipsenplotXY[,2]))
}

p <- ggplot(data.frame(EllipsenplotXY), aes(x = EllipsenplotXY[,1], y=EllipsenplotXY[,2])) + geom_point()
p <- p + geom_abline(aes(intercept=EllipsenplotXY[,1], slope=EllipsenplotXY[,2]), data=data.frame(EllipsenplotXY))
p

################################ MLE
################################

LL <- function(beta0, beta1, mu, sigma) {
  R = yAQ2 - xAQ2 * beta1 - beta0
  R = suppressWarnings(dnorm(R, mu, sigma, log = TRUE))
  -sum(R)
}

# The maximum-likelihood estimates for the slope (beta1) and intercept (beta0) are not too bad. 
fit2 <- mle(LL, start = list(beta0 = 8, beta1 = 0.5, sigma=1), fixed = list(mu = 0), nobs = length(yAQ2))
summary(fit2)


AIC(fit2)
BIC(fit2)
logLik(fit2)

fit3 <-mle2(LL, start = list(beta0 = 101.4, beta1 = 0.36, mu = 0, sigma = 1))
fit3

##############################
##############################
# xAQ <- qqnorm((joinedDataSets.without$Acquaintance^0.4444462-1)/0.4444462)$x
# yAQ <- qqnorm((joinedDataSets.without$Acquaintance^0.4444462-1)/0.4444462)$y

summary(p1 <- powerTransform(User.Engage ~ Acquaintance, data = joinedDataSets.without))

boxCox(User.Engage ~ Acquaintance, data = joinedDataSets.without, lambda = seq(0, 1, length = 100))
boxCox(User.Engage ~ Acquaintance, data = datasetM.correlation, lambda = seq(0, 1, length = 100))
boxCox(User.Engage ~ Acquaintance, data = dataset.product.correlation, lambda = seq(0, 1, length = 100))


ncvTest(lm(User.Engage ~ Acquaintance, data = joinedDataSets.without))
spreadLevelPlot(lm(User.Engage ~ Acquaintance, data = joinedDataSets.without))





yAQ3 <- joinedDataSets.without$User.Engage^0.4909343-1/0.4909343
mean(yAQ3)
sd(yAQ3)
LdL <- function(mu, sigma) {
  R = suppressWarnings(dnorm(yAQ3, mu, sigma, log=TRUE))
  -sum(R)
}
mle(LdL, start = list(mu = 21, sigma=7))






