
rm(list=ls())
library(fields)
library(reshape2)
library(ggplot2)

releases = read.csv("/Users/eric.ward/Documents/pfx-covariation-pws/data/salmon data/raw_data/PWS hatchery releases all species.csv")

# only show 1987 - 2014, since that's the complete data
# don't show chinook - incomplete
releases = releases[which(releases$Year%in%seq(1976,2014)),]
releases = releases[,c("COHO","SOCKEYE","PINK","CHUM")]
for(i in 1:dim(releases)[2]) {
	releases[is.na(releases[,i])==TRUE,i] =0
}

releases = releases[,c(4,3,1,2)]
releases$year = seq(1979,2014)
names(releases)[names(releases)%in%c("COHO")]="Coho"
names(releases)[names(releases)%in%c("CHUM")]="Chum"
names(releases)[names(releases)%in%c("PINK")]="Pink"
names(releases)[names(releases)%in%c("SOCKEYE")]="Sockeye"

# convert df to long
releases <- melt(releases, id.vars = c("year"))
names(releases)[names(releases)%in%c("variable")]="Species"

names(releases)[names(releases)%in%c("value")]="count"

# chinook chum coho pink sock
#cbPalette <- c("#009E73", "#4B2E83", "#999999", "#CC79A7", "#D55E00")
# coho sockeye pink chum
cbPalette <- c("#4B2E83", "#D55E00", "#999999", "#CC79A7")

releases$col = as.numeric(as.factor(releases$Species))

ggplot(releases, aes(year, count)) + 
geom_area(aes(fill = cbPalette[col]), position = "stack") + 
scale_fill_manual(values = cbPalette) + xlab("Year") + ylab("Releases")




geom_area(aes(fill = cbPalette[col]), position = "stack") +
  xlab("Year") + ylab("Harvest of hatchery produced salmon (millions)") +
  scale_fill_manual(values = cbPalette) + theme(legend.position="none")

g = ggplot(releases, aes(year, count)) + geom_area(aes(fill = cbPalette[col]), position = "stack") + xlab("Year") + ylab("Releases") + scale_fill_manual(values = cbPalette)
g + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

pdf("Figure S1 Hatchery Release trends since 1979.pdf")

dev.off()