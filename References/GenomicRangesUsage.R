library(GenomicRanges)

ir = IRanges(start = 1:3, width=2)
df = DataFrame(ir = ir, score = rnorm(3))

df

df[1,1]
df$ir

df2 = data.frame(ir=ir) #3 separate columnbs, don't keep things together
df2


gr <- GRanges(seqnames = 'chr1', strand = c("+","-","+"), ranges = IRanges(start=c(1,3,5), width = 3))
gr
values(gr) #Data frame with values in it
values(gr) = DataFrame(score = rnorm(3)) #Creating a metadata column and assigning them three random variavbles in this examople
gr
values(gr)
mcols(gr) #metadata column
gr$score
gr$score2 = gr$score/3 #Manipulations
gr

#findOverlaps_setup
gr2 <- GRanges(seqnames = c('chr1','chr2','chr1'), strand = c('*'), ranges = IRanges(start = c(1,3,5), width = 3))
gr2 #same ranges but different chromosomes and strand
gr

findOverlaps(gr,gr2) #Note '*" strand overlaps with both '+' and '-'
findOverlaps(gr,gr2, ignore.strand=TRUE)

subsetByOverlaps(gr,gr2)
subsetByOverlaps(gr2,gr)

#makeGRanges
df = data.frame(chr='chr1', start=1:3, end=4:6,score=rnorm(3))
makeGRangesFromDataFrame(df) #Converting a data frame containing structure similar to that of GRanges into Genomic Ranges
makeGRangesFromDataFrame(df,keep.extra.columns = TRUE) #Keeping the additional extra metadata column
