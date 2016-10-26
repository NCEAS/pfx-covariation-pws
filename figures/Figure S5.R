#Figure S5

# sockeye - pink figure for appendix
dat = read.csv("data/salmon data/data for analysis/Unakwik_Harvest.csv")

pdf("figures/Fig S5 Unakwik.pdf")
plot(dat$Year, dat$Harvest/1000, xlab="Year",
  ylab="Harvest (thousands)", type="b", lwd=2,pch=16)
dev.off()
