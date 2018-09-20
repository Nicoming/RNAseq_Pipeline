#S4 Methods
library(GenomicRanges)

############################## A 'template' example
mimicMethod <- function(x) {
  if (is(x,'matrix'))
    method1(x)
  if (is(x,'data.frame'))
    method2(x)
  if (is(x,'IRanges'))
    method3(x)
} #To be more specific, an example of generic function as here is where if statements happen


################
as.data.frame #Example of an S4 method
base::as.data.frame #Not an S4 method. UseMethod is a way to tell it's an S3

showMethods('as.data.frame')

getMethod('as.data.frame', signature(x='GenomicRanges'))

#Getting help page
method?'as.data.frame,DataFrame' #Loking for data.frame when x=dataframe
?'as.data.frame,DataFrame-method'
?'as.data.frame,GenomicRanges-method'

showMethods('findOverlaps')
#Two arguments: query and subject; different codes are ran depending on input query and subjects
getMethod('findOverlaps',signature(query='Ranges',subject='Ranges'))
?'findOverlaps,Ranges,Ranges-method'

