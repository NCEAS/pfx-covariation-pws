

setwd("/Users/eric.ward/Documents/NCEAS-covariation")

if("readxl" %in% rownames(installed.packages()) == FALSE) {
  devtools::install_github("hadley/readxl")}
require(readxl)
library(MARSS)

pdf("Figure 1b - recruits and total return.pdf")
par(mfrow = c(6,2), mgp=c(2,1,0), mai = c(0.3,0.4,0.2,0.1))

setwd("/Users/eric.ward/Documents/NCEAS-covariation")
salm = read_excel("data/salmon data/data for analysis/salmonEscapementTotal.xlsx")

plot(salm$ReturnYear, salm$CopperChinook.totalrun, xlab="",ylab="Returns",main="Copper Chinook",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")
plot(salm$ReturnYear, salm$CopperChinook.escapement, xlab="",ylab="Escapement",main="Copper Chinook",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")

plot(salm$ReturnYear, salm$PWSPink.totalrun, xlab="",ylab="Returns",main="PWS pink",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")
plot(salm$ReturnYear, salm$PWSPink.escapement, xlab="",ylab="Escapement",main="PWS pink",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")

plot(salm$ReturnYear, salm$CopperSockeye.totalrun, xlab="",ylab="Returns",main="Copper sockeye",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")
plot(salm$ReturnYear, salm$CopperSockeye.escapement, xlab="",ylab="Escapement",main="Copper sockeye",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")

plot(salm$ReturnYear, salm$EshamySockeye.totalrun, xlab="",ylab="Returns",main="Eshamy sockeye",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")
plot(salm$ReturnYear, salm$EshamySockeye.escapement, xlab="",ylab="Escapement",main="Eshamy sockeye",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")

plot(salm$ReturnYear, salm$CoghillSockeye.totalrun, xlab="",ylab="Returns",main="Coghill sockeye",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")
plot(salm$ReturnYear, salm$CoghillSockeye.escapement, xlab="",ylab="Escapement",main="Coghill sockeye",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")

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

plot(1980:2010, preFishery, xlab="",ylab="Returns",main="PWS herring",type="b")
lines(c(1989,1989),c(0,1.0e20),col="red")

plot(herring$BroodYear, herring$BroodYearSB, xlab="",ylab="SSB",main="PWS herring",type="b", xlim=c(1980,2010))
lines(c(1989,1989),c(0,1.0e20),col="red")

dev.off()