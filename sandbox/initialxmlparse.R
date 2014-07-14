## Parsing the xml file of dataflow of available datasets
## Dataflow of available datasets

library(XML)
library(RCurl)
library(plyr)

## set url
u <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/dataflow/ESTAT/all/latest" 

## get xml content
doc <- getURL(u,httpheader=list('User-Agent'='R'))

## internal tree supposed to be faster
xmlfile <- xmlInternalTreeParse(doc) 

root <- xmlRoot(xmlfile)

class(root)

names(root)
names(root[[1]])
names(root[[2]])


# Find node named "generic:ObsValue" anywhere in the tree that has the attribute
# "value" and get the value of that attribute
codes = xpathSApply(xmlfile, "//str:Dataflow[@id]", xmlGetAttr, "id")
codes

names_de = xpathSApply(xmlfile, "//com:Name[@xml:lang='de']", xmlValue)
names_de

ids <- xpathSApply(xmlfile, "")

temp=data.frame(data_id=codes, data_description=names_de)

text_de = xpathSApply
rc
# Get a set of nodes






precip <- xmlSApply(xmlfile[[2]], function(x) xmlSApply(x, xmlAttrs))



# the xml file is now saved as an object you can easily work with in R:
class(xmlfile)

# Use the xmlRoot-function to access the top node
xmltop = xmlRoot(xmlfile)

# first node
xmlName(xmltop)

# Traverste through the tree
names(xmltop[[2]][[1]])

# give the observations
names(xmltop[[2]][["Obs"]][["ObsValue"]])

names(xmltop[[2]][[1]])


out <- xpathApply(a3, "//ObsValue", function(x){
  coords <- xmlAttrs(x)
  data.frame(precip = xmlValue(x), lon = coords[1], lat = coords[2], stringsAsFactors = FALSE)
})


# have a look at the XML-code of the first subnodes:
print(xmltop)[[1]][1:2]

# To extract the XML-values from the document, use xmlSApply:

plantcat <- xmlSApply(xmltop, function(x) xmlSApply(x, xmlValue))


# Finally, get the data in a data-frame and have a look at the first rows and columns

plantcat_df <- data.frame(t(plantcat),row.names=NULL)
plantcat_df[1:5,1:4]




