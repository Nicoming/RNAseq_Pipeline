library(AnnotationHub)
ah = AnnotationHub() #Creating a local database via retireving from datrabase or using pre-existing cache

ah #snapshot is the state of that database on that specific date
#Structurally, AnnotationHub behaves like a vector

ah[1]
ah[1]$sourcetype

ah[[1]] #Actually retrieiving the data

#Working with AH
#Commonly subset ah to look at species of interest
ah = subset(ah, species == 'Homo sapiens')
ah
#query searches for a search term in all different components of the database
query(ah, "H3K4me3") #Histone modification data
query(ah, c('H3K4me3','Gm12878')) #In a specific cell ling

ah2 = display(ah) #Returning into a spreadsheet
ah2 #Containing selected rows
