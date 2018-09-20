#Usecase of AnnotationHub and GRanges
#This case study investigates histone mark H3K4 trimethylation to promoters



#Getting ENCODE data from AH
library(AnnotationHub)
library(GenomicRanges)
library(rtracklayer)
ahub = AnnotationHub()
ahub = subset(ahub, species == 'Homo sapiens')
qhs=query(ahub, c('H3K4me3','Gm12878'))
#Looking at the queries, wg from ENCODE and E116 from internal ID of Road Maphuman genomics project

gr1 = qhs[[2]]
gr2 = qhs[[4]]
gr1
gr2

summary(width(gr1)) #Example of a braod peak
summary(width(gr2)) #Example of a narrow peal
table(width(gr2))
peaks = gr2 #Setting histone modification peaks
qhs[4]

#refseq gives a very validated set of genes, but very limited - often only single isoforms present

qhs = query(ahub,'RefSeq')
qhs
genes = qhs[[1]]
genes
table(genes$name) #How often does a the name of a transcript occur
table(table(genes$name)) #A distribution of different numbers of a transcript

prom = promoters(genes) #This function respects strand information
table(width(prom)) #2k upstream and 200 downstream of TF start site
args(promoters) #Indicated here

#Now trying to find overlaps
ov = findOverlaps(prom, peaks)
length(unique(queryHits(ov)))
length(unique(subjectHits(ov)))
subsetByOverlaps(peaks,prom,ignore.strand = TRUE)

length(subsetByOverlaps(peaks,prom,ignore.strand=TRUE))
length(subsetByOverlaps(peaks,prom,ignore.strand=TRUE)) / length(peaks)
#30%, seems okay

length(subsetByOverlaps(prom,peaks,ignore.strand=TRUE)) / length(prom)
#50% promoters overalp in the trimethylation data

sum(width(reduce(peaks,ignore.strand=TRUE))) / 10^6 #Number of mega bases the peaks cover
sum(width(reduce(prom, ignore.strand=TRUE))) / 10^6 #Number of bases the promoters cover

sum(width(intersect(peaks, prom, ignore.strand=TRUE))) / 10^6 #Intersections

#Looking for significant enrichments
inOut = matrix(0,ncol=2,nrow=2) #2X2 matrix
colnames(inOut) = c('in','out')
rownames(inOut) = c('in','out')

inOut

inOut[1,1] = sum(width(intersect(peaks,prom,ignore.strand=TRUE)))
inOut[1,2] = sum(width(setdiff(peaks,prom,ignore.strand=TRUE))) #In the peaks and not in the promoters
inOut[2,1] = sum(width(setdiff(prom,peaks,ignore.strand=TRUE)))

inOut

colSums(inOut)
rowSums(inOut)

inOut[2,2] = 3*10^9 - sum(inOut)
inOut

fisher.test(inOut)$statistics
#Overflow problems
#Computing by hand
oddsRatio = inOut[1,1] * inOut[2,2] / (inOut[2,1]*inOut[1,2])
oddsRatio
#Values greater than 1 equals enrichment

#If 3 million the right number?
#Probably wrong, because not all are mappable
#Analysing using a sensitivity ratio
inOut[2,2] = 0
inOut[2,2] = 1.5 * 10^9 - sum(inOut) #Taking half for example, probably an underestimate

oddsRatio = inOut[1,1] * inOut[2,2] / (inOut[2,1]*inOut[1,2])
oddsRatio

#Is this even a right model/analysis?