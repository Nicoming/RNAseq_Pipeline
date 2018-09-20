#Genomic Ranges
library(GenomicRanges) #Similar to IRanges with additional abilities to deal with chromosomal information

gr = GRanges(seqnames = c('chr1'), strand = c("+","-","+"), ranges = IRanges(start=c(1,3,5), width =3))
gr #strand can be +,- or * where * indicates either unknown or present on both strands

flank(gr,5) #flanking sequence is in accord with direction with transcription, ie. - goes right and postiive goes left
promoters(gr) #2000bp upstream and 200 bp downstream of start of trasncription

seqinfo(gr)

seqlengths(gr) = c('chr1'=10)
seqinfo(gr)
seqlevels(gr)

gaps(gr) #Everything on the chromosome that is not covered by IRanges


#Reconstructing GRanges to indicate there are two chromosomes
seqlevels(gr)  =c('chr1','chr2')
seqnames(gr) = c('chr1','chr2','chr1')
gr
sort(gr) #Sorting is relative to the order of level

#Genome
genome(gr) = 'hg19'
gr
seqinfo(gr) #Genomic Ranges can have ranges from different genome, for example synthetic spiking-in can co-exist with human genome

