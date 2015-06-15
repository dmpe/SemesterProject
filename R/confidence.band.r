# confidence.band (Derek Young and David Hunter)
# based on Ellipses, by J. Fox and G. Monette, from
# car package

confidence.band = function(model, levels=0.95, segments=50, col.points=palette()[1], 
                           col.line=palette()[1], col.bands=palette()[2], 
                           lty.line=1, lty.bands=2, ...) {
  if (attr(model$terms,"intercept")!=1 || length(model$coef) !=2) {
    stop(paste("condifence.bands only works for simple linear regression\n",
               "with one predictor and an intercept"))
  }
  plot(model$model[,2:1], col=col.points, ...)
  abline(model, col=col.line, lty=lty.line, lwd=2)
  angles=(0:segments)*pi/segments
  halfcircle = cbind(cos(angles), sin(angles))  
  chol.shape = chol(vcov(model))
  slopes = (halfcircle %*% chol.shape)[,2]
  angles = angles+angles[which.max(slopes)]
  halfcircle = cbind(cos(angles), sin(angles))  
  center = model$coef
  radius = sqrt(2*qf(levels, 2, df.residual(model)))
  for (r in radius) {
    for (i in 1:2) {
      halfcircle = -halfcircle
      ellipse = sweep(r*(halfcircle %*% chol.shape), 2, center, "+")
      int = ellipse[,1]
      slope = ellipse[,2]
      x = -diff(int)/diff(slope)
      y = int[-1]+slope[-1]*x
      lines(x, y, lwd=2, lty=lty.bands, col=col.bands)
    }
  }
}

