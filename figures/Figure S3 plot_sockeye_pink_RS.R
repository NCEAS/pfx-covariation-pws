
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

copper.mod = lm(logRS ~ Escapement, data = copper[which(!is.na(copper$logRS)),])
eshamy.mod = lm(logRS ~ Escapement, data = eshamy[which(!is.na(eshamy$logRS)),])
coghill.mod = lm(logRS ~ Escapement, data = coghill[which(!is.na(coghill$logRS)),])

pdf("Figure S3 Sockeye_pink_RS.pdf")
par(mfrow = c(3,2), mai = c(0.4,0.4,0.2,0.03), mgp=c(2,1,0))
plot(copper$BroodYear[which(!is.na(copper$logRS))], residuals(copper.mod), main="Copper River", xlab="",ylab="Residuals",type="b")
abline(c(0,0),col="red")
plot(copper$ad.hatchPinkRun.lag2[which(!is.na(copper$logRS))], residuals(copper.mod), main="Copper River", xlab="Hatchery pink salmon returns",ylab="Residuals")
lm2 = lm(residuals(copper.mod) ~ copper$ad.hatchPinkRun.lag2[which(!is.na(copper$logRS))])
sorted = sort(copper$ad.hatchPinkRun.lag2[which(!is.na(copper$logRS))], index.return=T)
lines(sorted$x, lm2$fitted.values[sorted$ix], lwd=2,col="grey30")

plot(eshamy$BroodYear[which(!is.na(eshamy$logRS))], residuals(eshamy.mod), main="Eshamy Lake", xlab="",ylab="Residuals",type="b")
abline(c(0,0),col="red")
plot(eshamy$ad.hatchPinkRun.lag2[which(!is.na(eshamy$logRS))], residuals(eshamy.mod), main="Eshamy Lake",xlab="Hatchery pink salmon returns",ylab="Residuals")
lm2 = lm(residuals(eshamy.mod) ~ eshamy$ad.hatchPinkRun.lag2[which(!is.na(eshamy$logRS))])
sorted = sort(eshamy$ad.hatchPinkRun.lag2[which(!is.na(eshamy$logRS))], index.return=T)
lines(sorted$x, lm2$fitted.values[sorted$ix], lwd=2,col="grey30")

plot(coghill$BroodYear[which(!is.na(coghill$logRS))], residuals(coghill.mod), main="Coghill Lake", xlab="",ylab="Residuals",type="b")
abline(c(0,0),col="red")
plot(coghill$ad.hatchPinkRun.lag2[which(!is.na(coghill$logRS))], residuals(coghill.mod), main="Coghill Lake", xlab="Hatchery pink salmon returns",ylab="Residuals")
lm2 = lm(residuals(coghill.mod) ~ coghill$ad.hatchPinkRun.lag2[which(!is.na(coghill$logRS))])
sorted = sort(coghill$ad.hatchPinkRun.lag2[which(!is.na(coghill$logRS))], index.return=T)
lines(sorted$x, lm2$fitted.values[sorted$ix], lwd=2,col="grey30")

dev.off()
