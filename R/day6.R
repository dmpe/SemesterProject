# https://stats.stackexchange.com/questions/9898/how-to-plot-an-ellipse-from-eigenvalues-and-eigenvectors-in-r

mat  <- matrix(1, length(xAQ2), 2)
eigens <- eigen(ellip2)
ellip2 <- t(ellip) %*% ellip

evs <- sqrt(eigens$values)
evecs <- eigens$vectors

a <- evs[1]
b <- evs[2]
x0 <- 0
y0 <- 0
alpha <- atan(evecs[ , 1][2] / evecs[ , 1][1])
theta <- seq(0, 2 * pi, length=(1000))

x <- x0 + a * cos(theta) * cos(alpha) - b * sin(theta) * sin(alpha)
y <- y0 + a * cos(theta) * sin(alpha) + b * sin(theta) * cos(alpha)




plot(x, y, type = "l", main = expression("x = a cos " * theta * " + " * x[0] * " and y = b sin " * theta * " + " * y[0]), asp = 1)
arrows(0, 0, a * evecs[ , 1][2], a * evecs[ , 1][2])
arrows(0, 0, b * evecs[ , 2][3], b * evecs[ , 2][2])



dataEllipse(ellip2[,1], ellip2[,2])


