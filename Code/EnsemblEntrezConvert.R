#This component takes a dds that has its rownmaes in Ensembl and makes a colimn of Entrez Ids 
#before pathway analysis
res <- readRDS('~/Gits/RNAseq_DE_Analysis_Pipeline/ExportData/resSig.rds')

res$symbol = mapIds(org.Hs.eg.db,
                       keys=row.names(res), 
                       column="SYMBOL",
                       keytype="UNIGENE",
                       multiVals="first")
res$entrez = mapIds(org.Hs.eg.db,
                    keys=row.names(res), 
                    column="ENTREZID",
                    keytype="ENSEMBL",
                    multiVals="first")
res$name =   mapIds(org.Hs.eg.db,
                    keys=row.names(res), 
                    column="GENENAME",
                    keytype="ENSEMBL",
                    multiVals="first")

head(res, 10)