
if("readxl" %in% rownames(installed.packages()) == FALSE) {
  devtools::install_github("hadley/readxl")}
require(readxl)
library(MARSS)
library(viridis)

setwd("/Users/eric.ward/Documents/NCEAS-covariation/analyses")

X = seq(1981,2008)
cols = viridis(length(X),alpha=0.4)

pdf("Figure 01 S-R relationships.pdf")
par(mfrow = c(3,2), mgp=c(2,1,0), mai = c(0.5,0.5,0.3,0.1))

chnk = read_excel("../data/salmon data/data for analysis/Copper_Chinook_final.xlsx")
subset = which(chnk$BroodYear%in%X)
Y = log(as.numeric(chnk$RecPerSpawn[subset])) # log(R/S)
plot(chnk$Escapement[subset], Y, col = cols[subset], xlab="Spawners", ylab="log (R/S)", main = "Copper River Chinook", lwd=2, cex=2,pch=16)
legend('topright', c("1985","1990","1995","2000","2005"), bty='n', pch=16, col = cols[c(4,9,14,19,24)], cex=1.1)

# read in sockeye data
coghill = read_excel("../data/salmon data/data for analysis/Coghill_Wild_Sockeye_final.xlsx")
eshamy = read_excel("../data/salmon data/data for analysis/Eshamy_Wild_Sockeye_final.xlsx")
copper = read_excel("../data/salmon data/data for analysis/Copper_Wild_Sockeye_final.xlsx")
X = seq(1981,2008)
subset = which(coghill$BroodYear%in%X)
Y = log(as.numeric(coghill$RecPerSpawn[subset])) # log(R/S)

plot(coghill$Escapement[subset], Y, col = cols[coghill$BroodYear[subset]-1980], xlab="Spawners", ylab="log (R/S)", main = "Coghill Lake sockeye", lwd=2, cex=2, pch=16)

subset = which(eshamy$BroodYear%in%X)
Y = log(as.numeric(eshamy$RecPerSpawn[subset])) # log(R/S)
plot(eshamy$Escapement[subset], Y, col = cols[eshamy$BroodYear[subset]-1980], xlab="Spawners", ylab="log (R/S)", main = "Eshamy Lake sockeye", lwd=2, cex=2, pch=16)

subset = which(copper$BroodYear%in%X)
Y = log(as.numeric(copper$RecPerSpawn[subset])) # log(R/S)
plot(copper$Escapement[subset], Y, col = cols[copper$BroodYear[subset]-1980], xlab="Spawners", ylab="log (R/S)", main = "Copper River sockeye", lwd=2, cex=2, pch=16)

# Read in pink salmon data
pink = read_excel("../data/salmon data/data for analysis/PWS_Wild_Pink_final.xlsx")
subset = which(pink$BroodYear%in%X)
Y = log(as.numeric(pink$RecPerSpawn[subset])) # log(R/S)
plot(pink$Escapement[subset], Y, col = cols[pink$BroodYear[subset]-1980], xlab="Spawners", ylab="log (R/S)", main = "PWS pink", lwd=2, cex=2, pch=16)

# Read in herring data
herring = read_excel("../data/herring/PWS_herring_final.xlsx")
subset = which(herring$BroodYear%in%X)
Y = log(as.numeric(herring$RecPerSpawn[subset])) # log(R/S)
plot(herring$BroodYearSB[subset], Y, col = cols[herring$BroodYear[subset]-1980], xlab="Spawning biomass (mt)", ylab="log (age 3 recruits / SSB)", main = "PWS herring", pch=16,cex=2, lwd=2)

dev.off()
