

releases = read.csv("data/salmon data/raw_data/PWS hatchery releases all species.csv")

# only show 1987 - 2014, since that's the complete data
# don't show chinook - incomplete
releases = releases[which(releases$Year%in%seq(1976,2014)),]
releases = releases[,c("COHO","SOCKEYE","PINK","CHUM")]
for(i in 1:dim(releases)[2]) {
	releases[is.na(releases[,i])==TRUE,i] =0
}

library(fields)

pdf("Figure S1 Hatchery Release trends since 1979.pdf")

Yrs = seq(1979,2014)
N = length(Yrs)
# Plot polygon of coho 
plot(0,0,col="white",xlab="Year", ylab = "Hatchery releases (numbers of fish)", xlim= range(Yrs), ylim=c(0, max(apply(releases,1,sum))))
polygon(c(Yrs,rev(Yrs)), c(rep(0, N), rev(releases$COHO)), border=NA, col = "black")
# plot sockeye
polygon(c(Yrs,rev(Yrs)), c(releases$COHO, rev(releases$COHO+releases$SOCKEYE)), border=NA, col = "grey80")
# plot chum
polygon(c(Yrs,rev(Yrs)), c(releases$COHO+releases$SOCKEYE, rev(releases$COHO+releases$SOCKEYE+releases$CHUM)), border=NA, col = "grey50")
# plot pink
polygon(c(Yrs,rev(Yrs)), c(releases$COHO+releases$SOCKEYE+releases$CHUM, rev(releases$COHO+releases$SOCKEYE+releases$PINK+releases$CHUM)), border=NA, col = "grey30")

legend('topleft', bty="n", fill = c("black","grey80","grey50","grey30"), c("Coho","Sockeye","Chum","Pink"))
dev.off()