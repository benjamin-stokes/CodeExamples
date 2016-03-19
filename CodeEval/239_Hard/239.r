#!/usr/bin/Rscript

quicksort <- function(x) {
    npivots <- 0
    
    if (length(x) == 1) {
        return(list(x=x, npivots=npivots))
    }
    xtmp <- x[1]
    i <- 1
    j <- 1
    k <- length(x)+1
    while (j+1 < k) {
        for (k in (k-1):(j+1)) {
            if ( xtmp > x[k]) {
                x[j] <- x[k]
                x[k] <- xtmp
                i <-k
                break
            }
        }
        if (k <= j+1){
            break
        }
        for (j in (j+1):(k-1)) {
            if ( xtmp < x[j]) {
                x[k] <- x[j]
                x[j] <- xtmp
                i <- j
                break
            }
        }
    }
    
    
    npivots <- npivots + 1

    if (i == 1) {
        q1 <- quicksort(x[(i + 1):length(x)])
        x <- c(xtmp, q1$x)
        npivots <- npivots + q1$npivots
    }
    else if (i == length(x)) {
        q1 <- quicksort(x[1:(i - 1)])
        x <- c(q1$x, xtmp)
        npivots <- npivots + q1$npivots
    }
    else {
        q1 <- quicksort(x[1:(i - 1)])
        q2 <- quicksort(x[(i + 1):length(x)])
        x <- c(q1$x, xtmp, q2$x)
        npivots <- npivots + q1$npivots + q2$npivots
    }
    return(list(x=x, npivots=npivots))
}

args <- commandArgs(trailingOnly=TRUE)
test.cases <- strsplit(readLines(args[[1]], warn=FALSE), '\n')
for (test in test.cases) {
    if (length(test) > 0) {
        x <- strsplit(test, ' ')
        x <- lapply(x, as.numeric)[[1]]
        q <- quicksort(x)
        stmnt <- sprintf("%d\n",q$npivots)
        cat(stmnt)
    }
}

