library(stats4)
library(car)
library(bbmle)
set.seed(5157)

#######
# http://www.iiap.res.in/astrostat/School07/R/reg.html
# http://www.r4all.org/maximum-likelihood-1/
# https://faculty.washington.edu/ezivot/econ424/maxLik.pdf
# http://www.exegetic.biz/blog/2013/08/fitting-a-model-by-maximum-likelihood/
#######

testList <- as.list(runif(1000, 0.000, 1.000))
testList <- as.list(seq(0.0001, 1, length = 1000))

########################### Produkt
cor.list.UE.produkt <- NULL
for(k in 1:length(testList)) {
  cor.list.UE.produkt[[k]] <- cor(qqnorm((dataset.product$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                                  qqnorm((dataset.product$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}
testList[[which.max(cor.list.UE.produkt == max(cor.list.UE.produkt))]]


cor.list.AQ.produkt <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ.produkt[[k]] <- cor(qqnorm((dataset.product$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                                  qqnorm((dataset.product$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}
testList[[which.max(cor.list.AQ.produkt == max(cor.list.AQ.produkt))]]

########################### Service
cor.list.UE.service <- NULL
for(k in 1:length(testList)) {
  cor.list.UE.service[[k]] <- cor(qqnorm((datasetM.correlation$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                                  qqnorm((datasetM.correlation$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}
testList[[which.max(cor.list.UE.service == max(cor.list.UE.service))]]



cor.list.AQ.service <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ.service[[k]] <- cor(qqnorm((datasetM.correlation$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                                  qqnorm((datasetM.correlation$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}
testList[[which.max(cor.list.AQ.service == max(cor.list.AQ.service))]]

########################### Joined
cor.list.UE <- NULL
for(k in 1:length(testList)) {
  cor.list.UE[[k]] <- cor(qqnorm((joinedDataSets.without$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((joinedDataSets.without$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}
testList[[which.max(cor.list.UE == max(cor.list.UE))]]



cor.list.AQ <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ[[k]] <- cor(qqnorm((joinedDataSets.without$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((joinedDataSets.without$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}
testList[[which.max(cor.list.AQ == max(cor.list.AQ))]]


################################ MLE
################################

xAQ2 <- joinedDataSets.without$Acquaintance^0.4444462-1/0.4444462
yAQ2 <- joinedDataSets.without$User.Engage^0.4909343-1/0.4909343

xAQ <- qqnorm((joinedDataSets.without$Acquaintance^0.4444462-1)/0.4444462)$x
yAQ <- qqnorm((joinedDataSets.without$Acquaintance^0.4444462-1)/0.4444462)$y

LL <- function(beta0, beta1, mu, sigma) {
  R = xAQ2 - yAQ2 * beta1 - beta0
  R = suppressWarnings(dnorm(R, mu, sigma, log = TRUE))
  -sum(R)
}

fit <- lm(User.Engage ~ Acquaintance, data = joinedDataSets.without)
summary(fit)

# The maximum-likelihood estimates for the slope (beta1) and intercept (beta0) are not too bad. 
fit2 <- mle(LL, start = list(beta0 = 101.4, beta1 = 0.36, sigma=1), fixed = list(mu = 0), nobs = length(xAQ2))
summary(fit2)

AIC(fit2)
BIC(fit2)
logLik(fit2)

fit3 <-mle2(LL, start = list(beta0 = 101.4, beta1 = 0.36, mu = 0, sigma = 1))
fit3

confidenceEllipse(lm(User.Engage ~ Acquaintance, data = joinedDataSets.without), levels = 0.95)
confidenceEllipse(mle(LL, start = list(beta0 = 101.4, beta1 = 0.36, sigma=1), fixed = list(mu = 0), nobs = length(xAQ2)))

source("http://sites.stat.psu.edu/~dhunter/R/confidence.band.r")
confidence.band(fit)

plot(joinedDataSets.without$User.Engage, joinedDataSets.without$Acquaintance)
abline(fit, col = "red")



summary(p1 <- powerTransform(User.Engage ~ Acquaintance, data = joinedDataSets.without))



boxCox(User.Engage ~ Acquaintance, data = joinedDataSets.without, lambda = seq(0, 1, length = 100))
boxCox(User.Engage ~ Acquaintance, data = datasetM.correlation, lambda = seq(0, 1, length = 100))
boxCox(User.Engage ~ Acquaintance, data = dataset.product.correlation, lambda = seq(0, 1, length = 100))
