

plotRanges <- function(x, xlim = x, main = deparse(substitute(x)),col = "black",sep=0.5){
  height <- 1
  if (is(xlim,"Ranges"))
    xlim <- c(min(start(xlim)),max(end(xlim)))
  blins <- disjointBins(IRanges(start(x),end(x)+1))
  plot.new()
  plot.window(xlim,c(0,max(blins)*(height+sep)))
  ybottom <- blins * (sep +height) - height
  rect(start(x)-0.5,ybottom,end(x)+0.5,ybottom+height,col=col)
  title(main)
  axis(1)
}
par(mfrow=c(2,1))
ir <- IRanges(start=c(1,3,7,9),end=c(4,4,8,10))
plotRanges(ir1)
plotRanges(reduce(ir1))
plotRanges(disjoin(ir1))

#Manipulations
resize(ir,width=1,fix='start')
resize(ir,width=1, fix='center')

ir1 <- IRanges(start=c(1,3,5),width=1)
ir2 <- IRanges(start=c(4,5,6),width=1)

union(ir1,ir2)
reduce(c(ir1,ir2)) #Essentially the same as untion is concatenating two IRanges and merging them

plotRanges(c(ir1,ir2))
plotRanges(ir2)
intersect(ir1,ir2)
disjoin(c(ir1,ir2)) #not equivalent to intersection, disjoin returns individual segments

#Relating IRanges
ir1 <- IRanges(start=c(1,4,8),end=c(3,7,10))
ir2 <- IRanges(start=c(3,4),width=3)
ov <- findOverlaps(ir1,ir2)
queryHits(ov)
subjectHits(ov)
unique(queryHits(ov)) #Elements of the query that overlaps with anything in the subject

args(findOverlaps) #Many arguments possible in findOverlaps function, depending on the task

countOverlaps(ir1,ir2)
nearest(ir1,ir2) #For i-th element in ir1, j-th element in ir2 is the most similar; finding nearest gene for example

sessionInfo()
