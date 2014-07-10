## Parsing the xml file of dataflow of available datasets
## Dataflow of available datasets

library(XML)
library(RCurl)
library(plyr)

## retrieving data
u3 <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/cdh_e_fos/..PC.FOS1.BE/?startperiod=2005&endPeriod=2011" 

doc3 <- getURL(u3,httpheader=list('User-Agent'='R'))
#docxml3 <- xmlParse(doc3)
#docxml3
# No success parsing directly to dataframe
# docdf <- xmlToDataFrame(docxml3)
# rm(docdf)


## xmltreeparse is preferable if you not intend to use xpath (?)
# the xml file is now saved as an object you can easily work with in R:
# Use the xmlTreePares-function to parse xml file directly from the web
#xmlfile <- xmlTreeParse(doc3) 
xmlfile <- xmlInternalTreeParse(doc3) 

# Find node named "generic:ObsValue" anywhere in the tree that has the attribute
# "value" and get the value of that attribute
rc = xpathApply(xmlfile, "//generic:ObsValue[@value]", xmlGetAttr, "value")

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




