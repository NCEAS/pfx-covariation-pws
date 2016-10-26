
# sockeye - pink figure for appendix
coghill = readxl::read_excel("data/salmon data/data for analysis/Coghill_Wild_Sockeye_final.xlsx")
coghill = as.data.frame(coghill)[,names(coghill)%in%c("BroodYear","Escapement","RecPerSpawn","ad.hatchPinkRun.lag2")]
coghill$logRS = log(coghill$RecPerSpawn)

copper = readxl::read_excel("data/salmon data/data for analysis/Copper_Wild_Sockeye_final.xlsx")
copper = as.data.frame(copper)[,names(copper)%in%c("BroodYear","Escapement","RecPerSpawn","ad.hatchPinkRun.lag2")]
copper$logRS = log(copper$RecPerSpawn)

eshamy = readxl::read_excel("data/salmon data/data for analysis/Eshamy_Wild_Sockeye_final.xlsx")
eshamy = as.data.frame(eshamy)[,names(eshamy)%in%c("BroodYear","Escapement","RecPerSpawn","ad.hatchPinkRun.lag2")]
eshamy$logRS = log(as.numeric(eshamy$RecPerSpawn))
eshamy$Escapement = as.numeric(eshamy$Escapement)

copper.mod = lm(logRS ~ ad.hatchPinkRun.lag2, data = copper[which(!is.na(copper$logRS)),])
eshamy.mod = lm(logRS ~ ad.hatchPinkRun.lag2, data = eshamy[which(!is.na(eshamy$logRS)),])
coghill.mod = lm(logRS ~ ad.hatchPinkRun.lag2, data = coghill[which(!is.na(coghill$logRS)),])

pdf("Figure 07.pdf")
par(mfrow = c(2,2), mai = c(0.6,0.6,0.2,0.03), mgp=c(2,1,0))
plot(coghill$ad.hatchPinkRun.lag2[which(!is.na(coghill$logRS))], coghill$logRS[which(!is.na(coghill$logRS))], main="Coghill Lake sockeye", lwd=2, xlab="Pink salmon hatchery returns",ylab="ln (R/S)",type="p")
sorted = sort(coghill$ad.hatchPinkRun.lag2[which(!is.na(coghill$logRS))], index.return=T)
lines(sorted$x, coghill.mod$fitted.values[sorted$ix], lwd=2,col="grey30")

plot(eshamy$ad.hatchPinkRun.lag2[which(!is.na(eshamy$logRS))], eshamy$logRS[which(!is.na(eshamy$logRS))], main="Eshamy Lake sockeye", lwd=2, xlab="Pink salmon hatchery returns",ylab="ln (R/S)",type="p")
sorted = sort(eshamy$ad.hatchPinkRun.lag2[which(!is.na(eshamy$logRS))], index.return=T)
lines(sorted$x, eshamy.mod$fitted.values[sorted$ix], lwd=2,col="grey30")

plot(copper$ad.hatchPinkRun.lag2[which(!is.na(copper$logRS))], copper$logRS[which(!is.na(copper$logRS))], main="Copper River sockeye", lwd=2, xlab="Pink salmon hatchery returns",ylab="ln (R/S)",type="p")
sorted = sort(copper$ad.hatchPinkRun.lag2[which(!is.na(copper$logRS))], index.return=T)
lines(sorted$x, copper.mod$fitted.values[sorted$ix], lwd=2,col="grey30")
dev.off()
