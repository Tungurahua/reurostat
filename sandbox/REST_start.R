library(RCurl)
library(XML)
library(plyr)
library(dplyr)

# This script implements the example REST calls from the Eurostat website
#
# http://epp.eurostat.ec.europa.eu/portal/page/portal/sdmx_web_services/getting_started/rest_sdmx_2.1#ind_20_1

fetch_eustat_dataflow=function(){
		## Dataflow of available datasets
		# URL to download
		u1="http://ec.europa.eu/eurostat/SDMX/diss-web/rest/dataflow/ESTAT/all/latest" 

		doc=getURL(u1,httpheader=list('User-Agent'='R'), .encoding='UTF-8')

		docxml<-xmlParse(doc, asTree=T, addAttributeNamespaces=T, useInternalNodes=T,
						 fullNamespaceInfo=T, encoding="UTF-8")
		return(docxml)
}

docxml=fetch_eustat_dataflow()


create_user_dataflow=function(lang, eurostat_data_flow){
		descriptions=getNodeSet(docxml, paste0("//str:Dataflow/com:Name [@xml:lang=", lang, "]")) %>%
		sapply(.,  xmlValue)

		# Get the ids and attributes of those descriptions
		ids=getNodeSet(docxml, "//str:Dataflow [@id]") %>%
		sapply(., xmlGetAttr, "id")

		# Get the associated references to fetch the data structure for a particular set
		ref=getNodeSet(docxml, "//str:Dataflow/str:Structure/Ref [@id]") %>%
		sapply(., xmlGetAttr, "id")

		temp=data.frame(data_id=ids, data_description=descriptions, data_ref=ref)
		return(temp)
}

languages=list('"de"', '"en"', '"fr"')

eu_stat_ref=lapply(languages, create_user_dataflow)
names(eu_stat_ref)=languages


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


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



