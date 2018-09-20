#ExpressionSet
library(Biobase)
library(ALL)
data(ALL)
ALL

#MetaData
experimentData(ALL)
?ALL #Help page command

#Affymetrix Identifiers
exprs(ALL)[1:4,1:4]
head(sampleNames(ALL))
featureNames(ALL)

#Phenotype data - covariance on information of the samples being run
head(pData(ALL))
pData(ALL)$sex

#Dimensional subsetting
ALL[,1:5] #1st - feature, 2nd - samples
ALL[1:10,1:5]

featureData(ALL)

ids = featureNames(ALL)[1:5]
ids

library(hgu95av2.db)
as.list(hgu95av2ENTREZID[ids])

phenoData(ALL) #Returns an annotated data frame instead of a conventional data frame in pData()
varLabels(ALL)
#phenoData contains a pData slot