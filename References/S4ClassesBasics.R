#S4 classes
#S4 classes are methods and different and separate
#Serves to represent complicated data structures

library(ALL)
library(GenomicRanges)


#An S4
df <- data.frame(y = rnorm(10), x = rnorm(10))
df
lm.object <- lm(y~x, data=df)
lm.object

class(lm.object)
names(lm.object)

#An S3 - a list
xx = list(a = letters[1:3], b=rnorm(4))
xx
class(xx)
class(xx) = 'lm'
xx #Not a S4

#
data(ALL)
ALL #ExpSet
class(ALL)
isS4(ALL)
#Help in S4, examples:
class?ExpressionSet
?'ExpressionSet-class'

#A class starts in capital letter and haves a constructor with the same name of the class
new('ExpressionSet')
#A classic way of building a new set, but a bit outdated

getClass('ExpressionSet')
#getting definition

#Accessing the slots:
ALL@annotation
slot(ALL,'annotation')

#However, as an user, it is not recommneded to access the data thinking slots, a lot slots aren't meant to be accessed:
annotation(ALL)

#Important: shoulod always be true
#updateObject(OLD_OBJECT)
#validObject(ALL) - this sometimes takes a long time to run so it's not automatically ran
