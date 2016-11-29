plain_plateau<-function(plain,dem){
  
  vals <- plain[]
  vals[vals < 1] <- NA
  plain[] <- vals
  
  dem_mod <- overlay(dem, plain, fun = function(x, y) {
    x[is.na(y[])] <- NA
    return(x)
  })
  
  m <- c(0, 300, 1,  300, 500, 2)
  rclmat <- matrix(m, ncol=3, byrow=TRUE)
  plain_plateau <- reclassify(dem_mod,rclmat)
  return(plain_plateau)
}
