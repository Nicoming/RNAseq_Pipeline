library(GenomicRanges)
gr <- GRanges(seqnames = c('chr1','chr2'), ranges = IRanges(start=1:2,end=4:5))
gr              
seqlevels(gr,force=TRUE) = 'chr1' #Dropping ranges outside chromosome 1
gr

#Drop chromosomes
gr <- GRanges(seqnames = c('chr1','chr2'), ranges = IRanges(start=1:2,end=4:5))
dropSeqlevels(gr,"chr2")
gr

#Keep chromosomes
gr <- GRanges(seqnames = c('chr1','chr2'), ranges = IRanges(start=1:2,end=4:5))
keepSeqlevels(gr,'chr1')

#Keep standard chrosomes drops "werid" looking chromosomes
gr <- GRanges(seqnames = c('chr1','chrU345'), ranges = IRanges(start=1:2,end=4:5))
keepStandardChromosomes(gr)

#Standard chromosome names depending on the style of the data set - sources and species
#chr1, chr01, chrI, 1, I
#Coverting styles in genomic ranges
gr <- GRanges(seqnames = c('chr1','chr2'), ranges = IRanges(start=1:2,end=4:5))
newStyle = mapSeqlevels(seqlevels(gr),"NCBI")
newStyle
gr = renameSeqlevels(gr,newStyle)
gr

