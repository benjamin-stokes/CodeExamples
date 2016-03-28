#!/usr/bin/Rscript



dc <- read.table("data_clean")
skymap <- read.table("skymap_1deg")
dc <- data.matrix(dc)
skymap$density <- 0
skymap <- data.matrix(skymap)
for ( i in 1:dim(skymap)[1]){
    for ( j in 1:dim(dc)[1]){
        if ( dc[j,1] > 57){
            sep <- dc[j,2]*skymap[i,1] + dc[j,3]*skymap[i,2] + dc[j,4]*skymap[i,3]
            if ( sep > 0.984807753012 ){
                skymap[i,6] <- skymap[i,6]+1
            }
        }
    }
}
colmax <- max(skymap[,6])+1
colgrad <-  rainbow(colmax, start=0, end=.75)
plot(skymap[,4], skymap[,5], col=colgrad[colmax-skymap[,6]])
            
