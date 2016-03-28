#!/usr/bin/Rscript

raddeg <- 57.2957795131
columns=c("mjd", "zenith", "azimuth", "energy", "nclust", "array_boundary", "t_boundary", "chi_geo", "chi_ldf", "ang_res", "s800", "s800_err", "xcore", "ycore", "ra", "dec")
data <- read.delim("TASD_N4_0.5E_pErr10_z55_period080511_150511", col.names=columns, header=FALSE, sep="")
data_clean <- data[data$energy>20 & data$ang_res < 5 & data$array_boundary > 1 & data$chi_ldf<10000,]
data_clean$ex <- cos(data_clean$ra/raddeg)*cos(data_clean$dec/raddeg)
data_clean$ey <- sin(data_clean$ra/raddeg)*cos(data_clean$dec/raddeg)
data_clean$ez <- sin(data_clean$dec/raddeg)

data_clean2 <- cbind(data_clean$energy, data_clean$ex, data_clean$ey, data_clean$ez)
colnames(data_clean2) <- c("energy", "ex", "ey", "ez")
for (i in 1:dim(data_clean2)[1]){
    stmt <- sprintf("%g %g %g %g\n", data_clean2[i,1], data_clean2[i,2], data_clean2[i,3], data_clean2[i,4])
    cat(stmt)
}
write.table(data_clean2, file="data_clean")
