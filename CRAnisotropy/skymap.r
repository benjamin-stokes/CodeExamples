#!/usr/bin/Rscript

library(astrolibR)
raddeg <- 57.2957795131

latlon<-function(nlat) {
    interval <- pi/nlat/2
    area <- interval**2
    coordinates <- NULL
    for ( i in 1:nlat ){
        ringarea <- (cos(interval*(i-1))-cos(interval*i))*2*pi
        latnum <- round(ringarea/area)
        for (j in 1:latnum){
            phi <- (j-0.5)/latnum*2*pi
            theta <- pi/nlat/2*(i-0.5)
            coortmp <- c(sin(theta)*cos(phi), sin(theta)*sin(phi), cos(theta))
            hammer <- aitoff(180-phi*raddeg, 90-theta*raddeg)
            coortmp <- c(coortmp, hammer$x, hammer$y)
            coordinates <- rbind(coordinates, coortmp)
        }
    }
    colnames(coordinates) <- c("x","y","z","hx","hy")
    rownames(coordinates) <- NULL
    return(coordinates)
}

skymap <- latlon(90)
write.table(skymap, file="skymap_1deg")
