################################################################################################

#       Filename: rcurl_soap.R

#       Author: Stefan Lüdtke

#       Created: Saturday 05 July 2014 21:38:26 CEST

#       Last modified: Thursday 10 July 2014 15:48:52 CEST

################################################################################################

#	PURPOSE		########################################################################
#
#	Test the  soap service at EUstat

################################################################################################
library(RCurl)
library(XML)
################################################################################################
test=xmlParse("get_data_structure.xml")
doc=paste(readLines("./get_data_structure_2.0.xml"), "\n", collapse="")
test=xmlParse("./get_data_structure_2.0.xml")

doc=paste(readLines("./get_data_flow_2.1.xml"), "\n", collapse="")
doc=paste(readLines("./get_generic_data_2.1.xml"), "\n", collapse="")

doc=paste(readLines("./get_data_structure_2.1.xml"), "\n", collapse="")
# SOAP request
h = basicTextGatherer()
h$reset()
# curlPerform(url="http://www.ec.europa.eu/",
curlPerform(url="http://ec.europa.eu/eurostat/SDMX/diss-ws/SdmxServiceService",
      httpheader=c(Accept="text/xml", Accept="multipart/*",
		# SOAPAction='GetDataflow',
		SOAPAction='GetDataStructure',
		# SOAPAction='GetGenericData',
		# SOAPAction='QueryStructure',
		'Content-Type' = "text/xml; charset=utf-8",'User-Agent'='SENDER'),
      postfields=doc,
      writefunction = h$update,
      verbose = TRUE
     )
body=h$value()

doc=paste(readLines("./get_data_structure_2.0.xml"), "\n", collapse="")
test=xmlParse("./get_data_structure_2.0.xml")

showConnections(all = T)
closeAllConnections()


test_1=xmlParse(body)
test_2=xmlParse(body)


# ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
