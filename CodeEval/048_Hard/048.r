#!/usr/bin/Rscript

letter.count<-function(item){
    item2 <- tolower(item)
    letter_vec <- table(factor(unlist(strsplit(item2, ""), use.names=FALSE), levels=letters))
    ntot <- sum(letter_vec)
    nvowel <- letter_vec[["a"]] + letter_vec[["e"]] + letter_vec[["i"]] + letter_vec[["o"]] + letter_vec[["u"]] + letter_vec[["y"]]
    ncount <- c(ntot, nvowel, ntot-nvowel)
    names(ncount) <- c("nlett", "nvowel", "nconst")
    return(ncount)
}

gcd <- function(x,y) {
  r <- x%%y;
  return(ifelse(r, gcd(y, r), y))
}

set.seed(123)
permmax <- 80000
upscale <- 24
args <- commandArgs(trailingOnly=TRUE)

test.cases <- strsplit(readLines(args[[1]], warn=FALSE), '\n')
for (test in test.cases) {
    if (length(test) > 0) {
        categories <- strsplit(test, ";")[[1]]
        if(length(categories) == 1){
            cat("0.00","\n")    
            next
        }
      
        names <- strsplit(categories, ",")[[1]]
        if(length(names) == 0){
            cat("0.00", "\n")    
            next
        }
        products <- strsplit(categories, ",")[[2]]
        namecount <- lapply(names, letter.count)
        productcount <- lapply(products, letter.count)
        SS <- matrix(0, length(namecount), length(productcount))
        for (i in 1:length(namecount)) {
            for (j in 1:length(productcount)) {
                if (productcount[[j]][1]%%2 == 0){
                    SS[i,j] <- namecount[[i]][2]*1.5
                }
                else {
                    SS[i,j] <- namecount[[i]][3]
                }
                if ( gcd(namecount[[i]][1], productcount[[j]][1]) > 1){
                    SS[i,j] <- SS[i,j]*1.5
                }          
            }
        }      
        if (dim(SS)[1] > dim(SS)[2])
        {
            SS <- t(SS)
        }
        y <- clue::solve_LSAP(SS, maximum=TRUE)
            stmnt <- sprintf("%.2f", sum(SS[cbind(seq_along(y), y)]))
            cat(stmnt,"\n")
    }
}
quit()
