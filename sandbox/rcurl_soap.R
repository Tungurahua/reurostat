################################################################################################

#       Filename: rcurl_soap.R

#       Author: Stefan Lüdtke

#       Created: Saturday 05 July 2014 21:38:26 CEST

#       Last modified: Thursday 10 July 2014 00:56:10 CEST

################################################################################################

#	PURPOSE		########################################################################
#
#	Test the  soap service at EUstat

################################################################################################
library(RCurl)
library(XML)
################################################################################################

doc=paste(readLines("get_data_flow.xml"), "\n", collapse="")
doc=paste(readLines("get_data_structure.xml"), "\n", collapse="")
doc=paste(readLines("get_generic_data.xml"), "\n", collapse="")

# SOAP request
h = basicTextGatherer()
h$reset()
# curlPerform(url="http://www.ec.europa.eu/",
curlPerform(url="http://ec.europa.eu/eurostat/SDMX/diss-ws/SdmxServiceService",
      httpheader=c(Accept="text/xml", Accept="multipart/*",
		# SOAPAction='GetDataflow',
		# SOAPAction='GetDataStructure',
		# SOAPAction='GetGenericData',
		'Content-Type' = "text/xml; charset=utf-8",'User-Agent'='TEST'),
      postfields=doc,
      writefunction = h$update,
      verbose = TRUE
     )
body=h$value()

showConnections(all = T)
closeAllConnections()



test_1=xmlParse(body)
test_2=xmlParse(body)


# ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
