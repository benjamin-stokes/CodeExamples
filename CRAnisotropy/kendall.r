#!/usr/bin/Rscript
library(pcaPP)
library(survival)
convert.z.score<-function(z, one.sided=NULL) {
    if(is.null(one.sided)) {
        pval = pnorm(-abs(z));
        pval = 2 * pval
    } else if(one.sided=="-") {
        pval = pnorm(z);
    } else {
        pval = pnorm(-z);                                                                                 
    }
    return(pval);
}
raddeg <- 57.2957795131
result <- NULL
ra <- NULL
dec <- NULL
pvalue <- NULL
n <- NULL
dc <- read.table("data_clean")
for (i in 1:dim(dc)[1])
{
	dc_tmp <- dc[dc$energy>dc$energy[i],]
	theta <- acos(dc_tmp$ex*dc$ex[i]+dc_tmp$ey*dc$ey[i]+dc_tmp$ez*dc$ez[i])
	energy <- dc_tmp[,1]
	x <- cbind(dc_tmp$energy, theta)
	colnames(x) <- c("energy", "theta")
	if ( length(x[,1]) > 3 ){
	   #result_tmp <- cor.test(x[,1], x[,2], method="kendall", use="pairwise")
	   #result_tmp <- Kendall(x[,1], x[,2])
	   #result_tmp <- survConcordance(Surv(x[,2]) ~ x[,1])
	   result_tmp <- cor.fk(x)
	   result[i] <- result_tmp[1,2]
	   n[i] <- dim(x)[1]
	   p_tmp <- result[i]/sqrt((2*(2*n[i]+5))/(9*n[i]*(n[i]-1)))
	   pvalue[i] <- convert.z.score(p_tmp)
	   ra[i] <- atan2(dc$ey[i], dc$ex[i])*raddeg
	   if(ra[i] < 0){ra[i] <- ra[i] + 360}
	   dec[i] <- asin(dc$ez[i])*raddeg
	}
}
reorder <-  order(pvalue, decreasing=FALSE,na.last=NA)

answer <- cbind(pvalue[(reorder)], result[(reorder)], ra[(reorder)], dec[(reorder)], n[(reorder)])
colnames(answer) <- c("P-value", "Tau-b", "RA", "Dec", "n")
write.table(answer,file="kendall_test")
answer[c(1,length(answer[,1])),1]
