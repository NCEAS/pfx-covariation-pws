

setwd("/Users/eric.ward/Documents/NCEAS-covariation")

if("readxl" %in% rownames(installed.packages()) == FALSE) {
  devtools::install_github("hadley/readxl")}
require(readxl)
library(MARSS)

pdf("Figure 02 - recruits and total return_FINAL.pdf")
par(mfrow = c(3,2), mgp=c(2,1,0), mai = c(0.3,0.4,0.2,0.1))

setwd("/Users/eric.ward/Documents/NCEAS-covariation")
salm = as.data.frame(read_excel("data/salmon data/data for analysis/salmonEscapementTotal.xlsx"))

for(i in 1:dim(salm)[2]) {
	salm[,i]=as.numeric(salm[,i])
}
xlims = c(1975,2014)
ylims = range(c(salm$CopperChinook.totalrun, salm$CopperChinook.escapement), na.rm=T)
plot(salm$ReturnYear, salm$CopperChinook.totalrun, xlab="", ylab="Abundance", main="Copper Chinook", type="b", lwd=2, ylim=ylims, xlim=xlims, col="dark blue")
lines(c(1989,1989),c(0,1.0e20),col="red")
lines(salm$ReturnYear, salm$CopperChinook.escapement,main="Copper Chinook",type="b", lwd=2, col='grey50')

ylims = range(c(salm$CoghillSockeye.totalrun, salm$CoghillSockeye.escapement), na.rm=T)
plot(salm$ReturnYear, salm$CoghillSockeye.totalrun, xlab="",ylab="Abundance",main="Coghill sockeye",type="b", lwd=2, ylim=ylims, xlim=xlims, col="dark blue")
lines(c(1989,1989),c(0,1.0e20),col="red")
lines(salm$ReturnYear, salm$CoghillSockeye.escapement,main="Coghill sockeye",type="b",lwd=2, col='grey50')

ylims = range(c(salm$EshamySockeye.totalrun, salm$EshamySockeye.escapement), na.rm=T)
plot(salm$ReturnYear, salm$EshamySockeye.totalrun, xlab="",ylab="Abundance",main="Eshamy sockeye",type="b", lwd=2, ylim=ylims, xlim=xlims, col="dark blue")
lines(c(1989,1989),c(0,1.0e20),col="red")
lines(salm$ReturnYear, salm$EshamySockeye.escapement,main="Eshamy sockeye",type="b",lwd=2, col='grey50')

ylims = range(c(salm$CopperSockeye.totalrun, salm$CopperSockeye.escapement), na.rm=T)
plot(salm$ReturnYear, salm$CopperSockeye.totalrun, xlab="", ylab="Abundance", main="Copper sockeye", type="b", lwd=2, ylim=ylims, xlim=xlims, col="dark blue")
lines(c(1989,1989),c(0,1.0e20),col="red")
lines(salm$ReturnYear, salm$CopperSockeye.escapement, main="Copper sockeye", type="b", lwd=2, col='grey50')

ylims = range(c(salm$PWSPink.totalrun, salm$PWSPink.escapement), na.rm=T)
plot(salm$ReturnYear, salm$PWSPink.totalrun, xlab="", ylab="Abundance", main="PWS pink", type="b", lwd=2, ylim=ylims, xlim=xlims, col="dark blue")
lines(c(1989,1989),c(0,1.0e20),col="red")
lines(salm$ReturnYear, salm$PWSPink.escapement,main="PWS pink",type="b",lwd=2, col='grey50')

herring = read_excel("data/herring/PWS_herring_final.xlsx")

preFishery = c(60412,
67436,
56646,
61990,
74814,
92152,
84145,
90455,
118854,
108683,
92801,
80028,
83661,
35473,
18454,
14076,
14411,
26428,
21153,
13564,
11142,
7969,
10704,
14014,
16842,
13385,
11556,
13640,
18364,
19470,
20507)
ylims = range(c(preFishery, herring$BroodYearSB), na.rm=T)
plot(1980:2010, preFishery, xlab="",ylab="Biomass",main="PWS herring",type="b",lwd=2, ylim=ylims, xlim=xlims, col="dark blue")
lines(c(1989,1989),c(0,1.0e20),col="red")
lines(herring$BroodYear, herring$BroodYearSB,main="PWS herring",type="b",lwd=2, col='grey50')

legend('topright', c("Total run", "Spawners"), bty='n', lwd=2, col=c("dark blue","grey50"))

dev.off()