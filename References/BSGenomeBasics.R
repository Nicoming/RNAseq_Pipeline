#BSgenome
library(BSgenome) #A pacakge dealing with full genomes in Bioconductor
available.genomes() #Listing all genomes available for direct download via bioconductor
library(BSgenome.Scerevisiae.UCSC.sacCer2)

Scerevisiae

seqlengths(Scerevisiae)
#NOTHING has been loaded into local memory yet
#BSgenome allows loading and unloading on the flight
#Pr4eventing memory depletion

Scerevisiae$chrI
letterFrequency(Scerevisiae$chrI, 'GC')
letterFrequency(Scerevisiae$chrI, 'GC', as.prob = TRUE)
letterFrequency(Scerevisiae$chrI, 'CG', as.prob = TRUE)
param = new('BSParams', X=Scerevisiae, FUN = letterFrequency)#bsapply() #Loads and unloads as computation proceeds - bsparams
bsapply(param,'GC')
unlist(bsapply(param,'GC'))
sum(unlist(bsapply(param,'GC'))) / sum(seqlengths(Scerevisiae))

unlist(bsapply(param,'GC',as.prob=TRUE))
