library(RCurl)
library(XML)

# This script implements the example REST calls from the Eurostat website
#
# http://epp.eurostat.ec.europa.eu/portal/page/portal/sdmx_web_services/getting_started/rest_sdmx_2.1#ind_20_1
#
# !! If a HTML redirect message is returned, you probably need to strip the 
# "www" from the beginning of the URL

## Dataflow of available datasets
# URL to download
u1 <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/dataflow/ESTAT/all/latest" 

doc<-getURL(u1,httpheader=list('User-Agent'='R'), .encoding='UTF-8')

docxml<-xmlParse(doc, asTree=T, addAttributeNamespaces=T, useInternalNodes=T,
			     fullNamespaceInfo=T, encoding="UTF-8")

# Get all long german descriptions
test=getNodeSet(docxml, "//str:Dataflow/com:Name [@xml:lang='de']")

# Get all long descriptions
test=getNodeSet(docxml, "//str:Dataflow/com:Name [@xml:lang]")

# Get the attributes of those descriptions
sapply(test, function(temp) xmlGetAttr(temp, "xml:lang"))



getNodeSet(docxml, namespaces = xmlNamespaceDefinitions(doc, simplify = TRUE), 
                    fun = NULL)

## Datastructure for a dataset structure definition (DSD)
u2 <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/datastructure/ESTAT/DSD_nama_gdp_c" 

doc2 <- getURL(u2,httpheader=list('User-Agent'='R'))

docxml2 <- xmlParse(doc2)
docxml2

## retrieving data
u3 <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/cdh_e_fos/..PC.FOS1.BE/?startperiod=2005&endPeriod=2011" 

doc3 <- getURL(u3,httpheader=list('User-Agent'='R'))
docxml <- xmlParse(doc3)
docxml



##http://technistas.com/2012/06/16/using-rest-apis-from-r-xml-operations/
#campaignDOM = xmlRoot(xmlTreeParse(db))
