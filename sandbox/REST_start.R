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

doc1 <- getURL(u1,httpheader=list('User-Agent'='R'))

docxml1 <- xmlParse(doc1)
docxml1

## Datastructure for a dataset structure definition (DSD)
u2 <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/datastructure/ESTAT/DSD_nama_gdp_c" 

doc2 <- getURL(u2,httpheader=list('User-Agent'='R'))
docxml2 <- xmlParse(doc2)
docxml2

## retrieving data
u3 <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/cdh_e_fos/..PC.FOS1.BE/?startperiod=2005&endPeriod=2011" 

doc3 <- getURL(u3,httpheader=list('User-Agent'='R'))
docxml3 <- xmlParse(doc3)
docxml3



##http://technistas.com/2012/06/16/using-rest-apis-from-r-xml-operations/
#campaignDOM = xmlRoot(xmlTreeParse(db))
