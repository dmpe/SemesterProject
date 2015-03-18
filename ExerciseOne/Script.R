# First Exercise 1

x<-c(4,2,6)
y<-c(1,0,-1)


length(x) # 3
sum(x)
sum(x^2)


seq(2,9) #2:9
seq(4,10,by=2) # 4, 6
seq(3,30,length=10)
seq(+6,-4,by=-2)


rep(2,4)
rep(c(1,2),4)
rep(c(1,2),c(4,4))
rep(1:4,4)
rep(1:4,rep(3,4))

x<-c(7.5,8.2,3.1,5.6,8.2,9.3,6.5,7.0,9.3,1.2,14.5,6.2)
x[-(1:6)]

data("trees")
attach(trees)


# we'd have used a 1 instead of a 2 if we wanted the mean of every row
apply(joinedDB.7, 2, mean)
m<-matrix(c(1,0,4,2,-1,1), byrow = T, nrow = 2)

