#GeoQuery
#Ascension nunbers exist for the whole set and subsets
#GEO identifier is the pre-requisite

library(GEOquery)
elist = getGEO("GSE11675") #Downloads data into a LIST - because there potentially different sets

length(elist)
#Returning a singal element, meaning there is only one component
class(elist)
names(elist)
eData <- elist[[1]]
eData

names(pData(eData)) #Phenodata

#Raw/supplementary data
elist2 = getGEOSuppFiles('GSE11675') #Gets a tar archive

elist2
