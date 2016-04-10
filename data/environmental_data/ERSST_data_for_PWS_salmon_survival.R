# Script written by Mike Litzow, summer 2015
   
# subsample ERSST for analysis of salmon survival
# adapted from code first written by Franz Mueter

library(ncdf4)
library(maps)
library(mapdata)
library(chron)
library(fields)
library(zoo)
library(RCurl)
#setwd("/Users/MikeLitzow/Documents/R/NCEAS")

# Open netCDF file from NOAA website via ftp
URL_SST <- "ftp://ftp.cdc.noaa.gov/Datasets/noaa.ersst/sst.mnmean.nc"
SSTGet <- getBinaryURL(URL_SST, ftp.use.epsv = FALSE) 
tmpSST <- tempfile(pattern="SSTwB", fileext=".nc")
writeBin(object=SSTGet, con=tmpSST)
nc <- nc_open(tmpSST)
nc

# view dates
d <- dates(ncvar_get(nc, "time"), origin=c(1,15,1800))
d

# Extract SST data for desired period and locations:
# Pick start and end dates (January 1950-February 2015):
d[c(1153,1934)]
d <- d[1153:1934]  # for later use!
d 

# Extract GOA SST, 54-61 deg. N, 200-226 deg. E:
x <- ncvar_get(nc, "lon", start=101, count=14)
y <- ncvar_get(nc, "lat", start=14, count=5)
x ; y
SST <- ncvar_get(nc, "sst", start=c(101,14,1153), count=c(14,5,length(d)), verbose = T)
dim(SST) # 14 longitudes, 5 latitudes, 782 months

 
# Change data from a 3-D array to a matrix of monthly data by grid point:
 SST <- aperm(SST, 3:1)  # reverse order of dimensions ("transpose" array)
 
 SST <- SST[,5:1,]  # Reverse order of latitudes to be increasing for convenience (in later plotting)
 y <- rev(y)  # Also reverse corresponding vector of lattidues
 SST <- matrix(SST, nrow=dim(SST)[1], ncol=prod(dim(SST)[2:3]))  # Change to matrix
 dim(SST)  # Matrix with column for each grid point, rows for monthly means
# Keep track of corresponding latitudes and longitudes of each column:
 lat <- rep(y, length(x))   # Vector of latitudes
 lon <- rep(x, each = length(y))   # Vector of longitudes
  plot(lon, lat)  # Show grid of longitude x latitude
 map('world2Hires',fill=F,xlim=c(100,255), ylim=c(20,66),add=T, lwd=2)
 dimnames(SST) <- list(as.character(d), paste("N", lat, "W", lon, sep=""))
 head(SST)

# Overall mean temperature at each location:
 SST.mean <- colMeans(SST)
 z <- t(matrix(SST.mean,length(y)))  # Re-shape to a matrix with latitudes in columns, longitudes in rows
 image(x,y,z, col=tim.colors(64))
 contour(x, y, z, add=T)  # Mean temperature pattern
 map('world2Hires',fill=F,xlim=c(130,250), ylim=c(20,66),add=T, lwd=2)

#restrict to the central GOA region from Mueter et al. 2005
use <- c("N60W210", "N60W212", "N60W214")
SST <- SST[,use]

sst.mean <- rowMeans(SST) #mean SST across the three grid cells
 
 m <- months(d)  # Extracts months from the date vector
 y <- as.integer((years(d)))   # Ditto for year
 
 temp <- data.frame(cbind(y,m,sst.mean)) #combine with mean temp
 rownames(temp) <- 1:nrow(temp) #clean up
 temp$y <- y+1949 #and correct year...
 
# months of SST response by species, from Mueter et al. 2005
# pink salmon values are for Jan-Sept FOR YEAR AFTER SPAWNING...i.e., year of out-migration

pink <- subset(temp, m <= 9)
pink <- subset(pink, y < 2015) #remove incomplete 2015 data
pink.sst <- tapply(pink$sst.mean, pink$y, mean) #avg SST Jan-Sept for each year

# chum salmon values are Jul-Sept for year after spawning
chum <- subset(temp, m>= 7 & m <= 9)
chum <- subset(chum, y < 2015) #remove incomplete 2015 data
chum.sst <- tapply(chum$sst.mean, chum$y, mean) #avg SST Jan-Sept for each year

# sockeye values are Jan-Feb lag1, all of lag2, Jan-Apr lag3 
# this loop produces means centered on year lag2
# ie, 1951 values are for brood year 1949

sock.sst <- NA
for(i in 1951:2014){
	grab1 <- subset(temp, y == i)
	grab2 <- subset(temp, y == i+1 & m <= 4)
	grab3 <- subset(temp, y == i-1 & m <= 2)
	sock <- rbind(grab1, grab2, grab3)
	sock.sst[i] <- mean(sock$sst.mean)	
}
sock.sst[2014] <- sock.sst[1950] <- NA #remove incomplete years
sock.sst <- sock.sst[1950:2014] #restrict to meaningful years

#Chinook values are lag 2 MJJA - (per discussion with Rich, Milo & Tammy)

chin <- subset(temp, m >= 5 & m <= 8)
chin <- subset(chin, y < 2015) #remove incomplete 2015 data
chin.sst <- tapply(chin$sst.mean, chin$y, mean) #avg SST Jan-Sept for each year

#coho are lag3 JJAS
coho <- subset(temp, m >= 6 & m <= 9)
coho <- subset(coho, y < 2015) #remove incomplete 2015 data
coho.sst <- tapply(coho$sst.mean, coho$y, mean) #avg SST Jan-Sept for each year

year <- 1950:2014
salmon.sst <- as.data.frame(cbind(year, pink.sst, chum.sst, sock.sst, chin.sst, coho.sst))

#############################
# Now get winter (NDJFM) sst
# Need to go back and re-define SST
 x <- ncvar_get(nc, "lon", start=101, count=14)
 y <- ncvar_get(nc, "lat", start=14, count=5)
 x ; y
 SST <- ncvar_get(nc, "sst", start=c(101,14,1153), count=c(14,5,length(d)), verbose = T)
 dim(SST) # 14 longitudes, 5 latitudes, 782 months

 
# Change data from a 3-D array to a matrix of monthly data by grid point:
 SST <- aperm(SST, 3:1)  # reverse order of dimensions ("transpose" array)
 
 SST <- SST[,5:1,]  # Reverse order of latitudes to be increasing for convenience (in later plotting)
 y <- rev(y)  # Also reverse corresponding vector of lattidues
 SST <- matrix(SST, nrow=dim(SST)[1], ncol=prod(dim(SST)[2:3]))  # Change to matrix
 dim(SST)  # Matrix with column for each grid point, rows for monthly means
# Keep track of corresponding latitudes and longitudes of each column:
 lat <- rep(y, length(x))   # Vector of latitudes
 lon <- rep(x, each = length(y))   # Vector of longitudes
  plot(lon, lat)  # Show grid of longitude x latitude
 map('world2Hires',fill=F,xlim=c(100,255), ylim=c(20,66),add=T, lwd=2)
 dimnames(SST) <- list(as.character(d), paste("N", lat, "W", lon, sep=""))
 head(SST)

# Overall mean temperature at each location:
 SST.mean <- colMeans(SST)
 z <- t(matrix(SST.mean,length(y)))  # Re-shape to a matrix with latitudes in columns, longitudes in rows
 image(x,y,z, col=tim.colors(64))
 contour(x, y, z, add=T)  # Mean temperature pattern
 map('world2Hires',fill=F,xlim=c(130,250), ylim=c(20,66),add=T, lwd=2)



#restrict to the central/western GOA 
use <- c("N60W210", "N60W212", "N60W214", "N58W214", "N58W212", "N58W210", "N58W208", "N58W206", "N58W204", "N56W202","N56W204", "N56W206", "N56W208", "N56W210", "N56W212", "N56W214", "N54W200", "N54W202", "N54W204", "N54W206", "N54W208", "N54W210", "N54W212", "N54W214")
g.SST <- SST[,use]

mean <- rowMeans(g.SST) #mean SST across the selected grid cells
 
 m <- months(d)  # Extracts months from the date vector
 y <- as.integer((years(d)))   # Ditto for year
 
 g.temp <- data.frame(cbind(y,m,mean)) #combine with mean temp
 rownames(g.temp) <- 1:nrow(temp) #clean up
 g.temp$y <- y+1949 #and correct year...

win.sst <- NA

for(i in 1951:2014){
	grab1 <- subset(g.temp, y == i-1 & m >=11)
	grab2 <- subset(g.temp, y == i & m <= 3)
	win <- rbind(grab1, grab2)
	win.sst[i] <- mean(win$mean)	
}


salmon.sst$win.sst <- NA
salmon.sst$win.sst[2:65] <- win.sst[1951:2014]
win3 <- rollmean(win.sst, 3, fill = NA)
salmon.sst$win3 <- NA
rm <- rollmean(salmon.sst$win.sst[2:65], 3, fill = NA )
salmon.sst$win3[2:65] <- rm
write.csv(salmon.sst, "salmon.sst.csv") # this is the version I first put on redmine, without any lags


# none of these sst time series include appropriate lags
# ie, all are centered on year of interest
# as per notes above, I'll lag appropriately: pink and chum lag1, sockeye lag2 (see notes for sockeye above)
# Chinook lag2, coho lag3

head(salmon.sst)
salmon.sst <- zoo(salmon.sst)
salmon.sst$pink.sst.l1 <- lag(salmon.sst$pink.sst,1)
salmon.sst$chum.sst.l1 <- lag(salmon.sst$chum.sst,1)
salmon.sst$sock.sst.l2 <- lag(salmon.sst$sock.sst,2)
salmon.sst$chin.sst.l2 <- lag(salmon.sst$chin.sst,2)
salmon.sst$coho.sst.l3 <- lag(salmon.sst$chum.sst,3)

write.csv(salmon.sst, "salmon.sst.with.lags.csv") 


###########################################
# PLEASE CHECK THAT I HAVE THIS RIGHT!
# FOR EXAMPLE - PINK BY 1950 IS REGULATED BY SST
# IN 1951, WHEN THEY OUT-MIGRATE
###########################################
