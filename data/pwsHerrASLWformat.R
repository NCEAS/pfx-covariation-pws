## ADFG Herring Age Sex Length Weight data 
## conversion from XLSM worksheet to CSV 
## 

library(dataone) #needed to run
library(datapackage) #needed to run
library(gdata)
library(httr)


pid<-'df35b.281.1' ## data object identifier
mn_uri <- "https://goa.nceas.ucsb.edu/goa/d1/mn/v1"  ## define goa portal as DataONE member node

##### Using dataone R client
#mn <- MNode(mn_uri)
# tempFilename <- 'pwsHerrXlsm.zip'
# herrXlsmObject=get(mn,pid)  ## file from dataONE
# herrXlsmData <- getData(herrXlsmObject, fileName=tempFilename)
# unzip(tempFilename, list=FALSE) 

##### Pull data via url
temp <- tempfile()
tempFileName<-'herring.zip'
tempPath<-file.path(temp)
download.file(paste(mn_uri, "/object/",pid, sep=""),tempFileName,method='curl',mode='wb')
unzip(tempFileName,overwrite=T)
file='PWS_Herring_Age_Sex_Length_Weight_1973-2014.xlsm'
d = read.xls(file,sheet=3,pattern='Year',blank.lines.skip=T,stringsAsFactors=F)


### Eric's editing below:
# delete any of the rows that have values in comment field 
d = d[-which(d$Comments!=""),]
d = d[-which(d$Collection.Date=="#N/A"),]
d = d[which(d$Sex%in%c("M","F")),]


# write.csv(d,file='pwsHerrSclGrth.csv',row.names=F)
