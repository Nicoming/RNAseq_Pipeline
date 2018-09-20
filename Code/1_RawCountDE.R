###Importing Dependencies############
library(DESeq)
library(DESeq2)
library(GEOquery)
##########

###Setting up local directory parameter######
setwd('~/Gits/RNAseq_DE_Analysis_Pipeline')
download.dir <- paste(getwd(),'/ImportData',sep='')
working.dir <- paste(getwd(),'/Code',sep='')
exp.dir <- paste(getwd(),'/ExportData',sep='')
##########

###Data Input############
#Download supplementary raw data
getGEOSuppFiles('GSE101526',baseDir = download.dir) #Input GEO ascension numbers

#Takes raw supplementary files that are in raw count
rawdata <- read.table(paste(download.dir,'/GSE101526/GSE101526_HTSeq_in_counts.txt',sep='')) #Input downloaded file and its directory
#or rawdata <- read.csv('~...csv')

##########

####Setting up input matriaces for DEseq################
#Making first column and row colnames and rownames

countdata <- rawdata[2:nrow(rawdata),2:ncol(rawdata)] 
rownames(countdata) <- rawdata$V1[2:nrow(rawdata)]

###Manually setting col names and conditions because they are not ordered by treatment###########
samples <- c(
  'S1768_HCT116wt_normDMSO',
  'S1756_HCT116wt_normDMSO',
  'S1774_HCT116wt_hypoxDMSO',
  'S1762_HCT116wt_hypoxDMSO',
  'S1771_HCT116wt_norm3MB',
  'S1759_HCT116wt_norm3MB',
  'S1777_HCT116wt_hypox3MB',
  'S1765_HCT116wt_hypox3MB',
  'S1769_HCT116cdk8as_normDMSO',
  'S1757_HCT116cdk8as_normDMSO',
  'S1775_HCT116cdk8as_hypoxDMSO',
  'S1763_HCT116cdk8as_hypoxDMSO',
  'S1772_HCT116cdk8as_norm3MB',
  'S1760_HCT116cdk8as_norm3MB',
  'S1778_HCT116cdk8as_hypox3MB',
  'S1766_HCT116cdk8as_hypox3MB'
)
colnames(countdata) <- samples
condition <- factor(rep(c('Normo','Normo','Hypo','Hypo'),times=4))

#Default object type is factor, converting them to numeric/integer
countmat <- mapply(countdata,FUN = as.numeric)
rownames(countmat) <- rownames(countdata)

#Number of  columns in coldata equals/corresponds to the rows of countdata
coldata <- data.frame(
  as.factor(condition)
)
rownames(coldata) <- samples
colnames(coldata) <- 'condition'

##########

###Differential expression analysis###############

dds <- DESeqDataSetFromMatrix(countData=countmat,colData=coldata,design=~condition)

#May take serveral minutes based on data size
dds <- DESeq(dds)
res <- results(dds, contrast=c('condition','Hypo','Normo'))

#Number of genes that are significantly different in two states
sum(res$padj < 0.1, na.rm=TRUE)

#Subsetting differentially expressed data that shows significance (p<0.1)
resSig <- subset(res, padj < 0.1)

#Wrapping resSig (a DEseq dataset into a data frame before exporting)
exp.data <- as.data.frame(resSig)

write.csv(exp.data, file = paste(exp.dir,'/DEGs.csv',sep=''))
# Save dds into a rds
saveRDS(resSig, file = paste(exp.dir,"resSig.rds",sep=''))

##########

sessionInfo()