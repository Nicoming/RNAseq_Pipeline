###Importing dependencies##################
library(magrittr)
library(tibble)
library(dplyr)
library(AnnotationDbi)
library(EnsDb.Hsapiens.v79) #Installing EnsDb.Hsapiens.v75 requires RMySQL
library(pathview)
library(gage)
library(gageData)
data(kegg.sets.hs) #KEGG referencing background
data(sigmet.idx.hs) #Containing only core metabolic pathways

##########

###Setting up local directory parameter######
setwd('~/Gits/RNAseq_DE_Analysis_Pipeline')
download.dir <- paste(getwd(),'/ImportData',sep='')
working.dir <- paste(getwd(),'/Code',sep='')
exp.dir <- paste(getwd(),'/ExportData',sep='')
##########

###Setting up datasets for pathview ###########################
fc = resSig$log2FoldChange #foldchange of sigficant differentially expressed genes
res <- resSig


#Given rownames are gene names (symbols), retreive corresponding
#entrez IDs from annotation of the given model organism
res$entrez <- mapIds(EnsDb.Hsapiens.v79,keys=row.names(res),
                     column=c("ENTREZID"), 
                     keytype="SYMBOL", multiVals="first")

names(fc) = res$entrez #Assigning converted ids to foldchange table

##########

###KEGG analysis and specifying pathview parameters#####################

###Acquiring KEGG results using calculated foldchange and background
keggres = gage(fc, gsets=kegg.sets.hs, same.dir=TRUE)

#Select five most notable pathwyas
keggrespathways = data.frame(id=rownames(keggres$greater), keggres$greater) %>% 
 as_tibble() %>% 
  filter(row_number()<=5) %>% #Number can be changed here to accommodate more pathways
  .$id %>% 
  as.character()

#PArsing out the identifiers
keggresids = substr(keggrespathways, start=1, stop=8)

##########

###Commence plotting#################

detach('package:GEOquery',unload=TRUE) #Important to unload dplyr that is under GEOqury
plot_pathway = function(pid) pathview(gene.data=fc, pathway.id=pid, species="hsa", new.signature=FALSE)

# plot multiple pathways (plots saved to disk and returns a throwaway list object)
setwd('~/Gits/RNAseq_DE_Analysis_Pipeline/ExportData/KEGG') #Setting working directory to allow graphs being downloaded into designated folder
tmp = sapply(keggresids, function(pid) pathview(gene.data=fc, pathway.id=pid, species="hsa"))
setwd('~/Gits/RNAseq_DE_Analysis_Pipeline/') #Reverse working directory change

##########

sessionInfo()
