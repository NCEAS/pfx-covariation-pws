
if("readxl" %in% rownames(installed.packages()) == FALSE) {
  devtools::install_github("hadley/readxl")}
require(readxl)
library(MARSS)



dis = read.csv("data/environmental_data/annual.freshwater.discharge.csv")
pdf("Figure S2 historic discharge.pdf")
plot(dis$Year, dis$total.discharge, type="l",lwd=3, ylab='Total freshwater discharge',xlab="")
# put vertical lines at 1980 and 2008 - about what we're looking at here
lines(rep(1980,2), c(0,1.0e6), lty=2, col="grey")
lines(rep(2008,2), c(0,1.0e6), lty=2, col="grey")
# also show long term mean
lines(c(min(dis$Year),max(dis$Year)), rep(mean(dis$total.discharge),2), lty=2,lwd=2)
dev.off()