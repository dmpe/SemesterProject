# http://www.exegetic.biz/blog/2013/08/fitting-a-model-by-maximum-likelihood/
# Code taken from Andrew Collier on 18 August 2013.

library(stats4)


set.seed(1001)
N <- 100
x <- rnorm(N, mean = 3, sd = 2)

mean(x)

sd(x)



LL <- function(mu, sigma) {
  R = dnorm(x, mu, sigma)
  -sum(log(R))
}

mle(LL, start = list(mu = 1, sigma=1))

mle(LL, start = list(mu = 1, sigma=1), method = "L-BFGS-B", lower = c(-Inf, 0),
    upper = c(Inf, Inf))




LL <- function(mu, sigma) {
  R = suppressWarnings(dnorm(x, mu, sigma))
  -sum(log(R))
}
mle(LL, start = list(mu = 1, sigma=1))
mle(LL, start = list(mu = 0, sigma=1))


#####################


x <- runif(N)
y <- 5 * x + 3 + rnorm(N)


fit <- lm(y ~ x)
summary(fit)

plot(x, y) 
abline(fit, col = "red")


LLsad <- function(beta0, beta1, mu, sigma) {
  R = y - x * beta1 - beta0
  R = suppressWarnings(dnorm(R, mu, sigma, log = TRUE))
  -sum(R)
}

fit <- mle(LLsad, start = list(beta0 = 2, beta1 = 1.5, sigma=1), fixed = list(mu = 0), nobs = length(y))
# fit
summary(fit)
