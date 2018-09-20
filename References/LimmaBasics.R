#LimmaBasics
library(limma)
library(leukemiasEset)

data("leukemiasEset")
leukemiasEset

table(leukemiasEset$LeukemiaType)

#Find genes differenially expressed
ourData <- leukemiasEset[,leukemiasEset$LeukemiaType %in% c('ALL','NoL')]
head(ourData)
ourData$LeukemiaType #A factor
#Getting rid of levels with no samples
ourData$LeukemiaType = factor(ourData$LeukemiaType)
ourData$LeukemiaType
#1st level = the reference level

#Setting up a design
design <- model.matrix(~ ourData$LeukemiaType)
head(design) #It's a matrix where the number of number of rows = number of samples
#Intercept is the average gene expression for the given gene across the ALL (reference) samples
#The second coulmn is difference in gene expression between ALL and NoL; if 0 - not differenially expressed
fit <- lmFit(ourData, design) #fits a lienar model to all the genes separately
fit <- eBayes(fit) #Empirical estimation of the variability:
#Essentially shows the variability of a gene is a mixture of gene specific varaibility and global variability where GV is assumed to be the same

topTable(fit) #moderate t-statistics

#
design2 <- model.matrix(~ourData$LeukemiaType-1)
head(design2)
colnames(design2)<-c('ALL','NoL')
fit2 <- lmFit(ourData,design2)
contrast.matrix <- makeContrasts('ALL-NoL',levels=design2) #NoL is the reference matrix
contrast.matrix #Whether ALL-NoL = 0
fit2C <- contrasts.fit(fit2,contrast.matrix)
fit2C <- eBayes(fit2C)
topTable(fit2C) #Relative to the specific contrast

sessionInfo()
