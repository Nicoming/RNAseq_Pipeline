library(Biostrings)

dna1 = DNAString('ACGT-G')
dna1 #Although it merely resembles a string object, there are many behind the scene available functionalities that will make analysis easier

dna2 = DNAStringSet(c('ACG','ACGT','ACGTT')) #A collection of DNAString objects
dna2

IUPAC_CODE_MAP #Representing strings more efficeintly

dna1[2:4] #Subsetting a DNAString returns a subsequence
dna2[1:2] #Another set
dna2[[1]] #A DNAString

names(dna2) = paste0('seq',1:3) #Naming
dna2

width(dna2) #Number of bases in each DNAString object
rev(dna2) #Different ordering of the sets
rev(dna1) #Actually reversing the sequence for DNAString

reverse(dna2) #True biologcial sequence reversing including DNAStringSet objects
reverseComplement((dna2))
translate(dna2) #Errors due to not mupltiplyers of 3 (condon reading)

alphabetFrequency(dna2) #Efficient for counting ACGT contents
letterFrequency(dna2,letters="GC")
dinucleotideFrequency(dna2)
trinucleotideFrequency(dna2)
consensusMatrix(dna2) #How many DNAStrings have that nucleotide at that specific location

#RNAString, AAString and BString (more general) are also available
#
