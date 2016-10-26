#Figure S4

# sockeye - pink figure for appendix
dat = read.csv("data/salmon data/data for analysis/PWS_Wild_Chum_CSV.csv")

pdf("figures/Fig S4 Unakwik.pdf")
plot(dat$Year, dat$Total_Rtn/1000, xlab="Year",
  ylab="Total run (thousands)", type="b", lwd=2,pch=16)
dev.off()
