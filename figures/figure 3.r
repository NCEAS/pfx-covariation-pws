
if("readxl" %in% rownames(installed.packages()) == FALSE) {
  devtools::install_github("hadley/readxl")}
require(readxl)
library(MARSS)

pdf("Figure 04 S-R relationships.pdf")
setwd("/Users/eric.ward/Documents/NCEAS-covariation/analyses")
chnk = read_excel("../data/salmon data/data for analysis/Copper_Chinook_final.xlsx")
X = seq(1981,2005)
subset = which(chnk$BroodYear%in%X)
Y = log(as.numeric(chnk$RecPerSpawn[subset])) # log(R/S)
colSeq = seq(150, 0, length.out = length(X))

par(mfrow = c(3,2), mgp=c(2,1,0), mai = c(0.5,0.5,0.3,0.1))
plot(X, log(chnk$RecPerSpawn[subset]), col = "grey30", xlab="", ylab="log(R/S)",
  main = "Copper River Chinook", lwd=2, cex=1.3, type="b")

# read in sockeye data
coghill = read_excel("../data/salmon data/data for analysis/Coghill_Wild_Sockeye_final.xlsx")
eshamy = read_excel("../data/salmon data/data for analysis/Eshamy_Wild_Sockeye_final.xlsx")
copper = read_excel("../data/salmon data/data for analysis/Copper_Wild_Sockeye_final.xlsx")
X = seq(1981,2008)
subset = which(coghill$BroodYear%in%X)

plot(X, log(coghill$RecPerSpawn[subset]), col = "grey30", xlab="", ylab="log(R/S)", main = "Coghill Lake sockeye", lwd=2, cex=1.3, type="b")
subset = which(eshamy$BroodYear%in%X)
plot(X, log(as.numeric(eshamy$RecPerSpawn[subset])), col = "grey30", xlab="", ylab="log(R/S)", main = "Eshamy Lake sockeye", lwd=2, cex=1.3, type="b")
subset = which(copper$BroodYear%in%X)
plot(X, log(copper$RecPerSpawn[subset]), col = "grey30", xlab="", ylab="log(R/S)", main = "Copper River sockeye", lwd=2, cex=1.3, type="b")

# Read in pink salmon data
pink = read_excel("../data/salmon data/data for analysis/PWS_Wild_Pink_final.xlsx")
subset = which(pink$BroodYear%in%seq(1981,2008))
plot(X, log(pink$RecPerSpawn[subset]), col = "grey30", xlab="", ylab="log(R/S)", main = "PWS pink", lwd=2, cex=1.3, type="b")

# Read in herring data
herring = read_excel("../data/herring/PWS_herring_final.xlsx")
subset = which(herring$BroodYear%in%seq(1981,2008))
plot(X, log(herring$RecPerSpawn[subset]), col="grey30", xlab="", ylab="log (age 3 recruits / SSB)", main = "PWS herring", cex=1.3, lwd=2, type="b")

dev.off()
