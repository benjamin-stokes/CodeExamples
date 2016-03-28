#!/usr/bin/Rscript

args <- commandArgs(trailingOnly=TRUE)
test.cases <- strsplit(readLines(args[[1]], warn=FALSE), '\n')
for (test in test.cases) {
    N <- strtoi(test)
    if ( N == 0) {
        cat("0\n")
        next
    }
    F[1] <- 1
    F[2] <- 1
    if ( N > 2){
        for (i in 3:N){
            F[i] <- F[(i - 1)] + F[(i - 2)]
        }
    }
    stmnt <- sprintf("%g\n", F[N])
    cat(stmnt)
}
