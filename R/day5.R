library(stats4)
set.seed(5157)

testList <- as.list(runif(1000, 0.000, 1.000))

########################### Produkt
cor.list.UE.produkt <- NULL
for(k in 1:length(testList)) {
  cor.list.UE.produkt[[k]] <- cor(qqnorm((dataset.product$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((dataset.product$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}

cor.list.AQ.produkt <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ.produkt[[k]] <- cor(qqnorm((dataset.product$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((dataset.product$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}

########################### Service
cor.list.UE.service <- NULL
for(k in 1:length(testList)) {
  cor.list.UE.service[[k]] <- cor(qqnorm((datasetM.correlation$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((datasetM.correlation$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}

cor.list.AQ.service <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ.service[[k]] <- cor(qqnorm((datasetM.correlation$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((datasetM.correlation$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}

########################### Joined

cor.list.AQ <- NULL
for(k in 1:length(testList)) {
  cor.list.AQ[[k]] <- cor(qqnorm((joinedDataSets.without$Acquaintance^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((joinedDataSets.without$Acquaintance^testList[[k]]-1)/testList[[k]])$y)
}

which.max(cor.list.AQ == max(cor.list.AQ))
testList[[57]]



cor.list.UE <- NULL
for(k in 1:length(testList)) {
  cor.list.UE[[k]] <- cor(qqnorm((joinedDataSets.without$User.Engage^testList[[k]]-1)/testList[[k]])$x, 
                          qqnorm((joinedDataSets.without$User.Engage^testList[[k]]-1)/testList[[k]])$y)
}


which.max(cor.list.UE == max(cor.list.UE))
testList[[566]]


















################################ MLE

xAQ2 <- joinedDataSets.without$Acquaintance^0.4444462-1/0.4444462
yAQ2 <- joinedDataSets.without$User.Engage^0.4909343-1/0.4909343

xAQ <- qqnorm((joinedDataSets.without$Acquaintance^0.4444462-1)/0.4444462)$x
yAQ <- qqnorm((joinedDataSets.without$Acquaintance^0.4444462-1)/0.4444462)$y

LL <- function(beta0, beta1, mu, sigma) {
  R = xAQ2 - yAQ2 * beta1 - beta0
  R = suppressWarnings(dnorm(R, mu, sigma, log = TRUE))
  -sum(R)
}


summary(mle(LL, start = list(beta0 = 2, beta1 = 1.5, sigma=1), fixed = list(mu = 0, sigma = 1), nobs = length(xAQ2)))

lm(Acquaintance ~ User.Engage, data = joinedDataSets.without)













