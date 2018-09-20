#biomaRt: n interface from R to a biomaRt - a front end for a database for biological database
#Any kind of data can be presented and navigated in biomaRt interface with common tools - e.g. EMSEMBLE, UNIPROT and NCBI

library(biomaRt)

#In biomaRt, databse = marts/data centre
head(listMarts())
mart <- useMart('ensembl')
head(listDatasets(mart)) # Genes from many organisms, each organism representing a dataset

#Creating a pointer
ensembl <- useDataset('hsapiens_gene_ensembl', mart)

#Setting up a biomaRt query
#Attributes, filters and values
#Given Affymetrix probe IDs, getting back gene names
values <- c('202763_at','209310_s_at','207500_at')
getBM(attributes = c('ensembl_gene_id','affy_hg_u133_plus_2'),filters = 'affy_hg_u133_plus_2',values = values, mart=ensembl)

#Attributes are the things to be retrieved, filter sets selective criteria, values are the actual values for the filters
#In this example, affy IDs needed to be retrieved and it also functions as a filter
#Helpful functions in deciding the fields:
attributes <- listAttributes(ensembl)
nrow(attributes) #Number of attributes/rows
head(attributes) #Names
tail(attributes, n = 500)
#Note how there are non-human gene IDs in this hg query, this is because they are useful in going from a human gene to an ortholog

filters <- listFilters(ensembl)
nrow(filters)
head(filters)
#Setting up a query requires understadning of the nature of these filters and attributes
#To help this process, attributes are organized into pages, which are internal to the databse strucutre and sometimes are exposed to the user
attributePages(ensembl)
attributes <- listAttributes(ensembl,page='feature_page') #limits the search to  a classifeid page
attributes

#Query having attributes of different pages are not possible, so some attributes belong to mulriple pages in order to keep the mart linked
#So it is a better practice to query attributes in query for attributes in the same pages separately and then merge them together

