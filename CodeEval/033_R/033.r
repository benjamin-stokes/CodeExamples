#!/usr/bin/Rscript

args <- commandArgs(trailingOnly=TRUE)
test.cases <- strsplit(readLines(args[[1]], warn=FALSE), "\n")
for (test in test.cases[2:length(test.cases)]) {
    if (length(test) > 0) {
        X <- strtoi(test)
        if (X == 0){
            cat("1\n")
            next
        }
        N <- 0
         for (a in 0:floor(sqrt(X / 2))){
            b <- sqrt(X - a ** 2)
            if (a ** 2 + round(b) ** 2 == X){
                N <- N + 1
            }
        }
        stmt <- sprintf("%d\n", N)
        cat(stmt)
    }
}
