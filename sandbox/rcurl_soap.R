################################################################################################

#       Filename: rcurl_soap.R

#       Author: Stefan Lüdtke

#       Created: Saturday 05 July 2014 21:38:26 CEST

#       Last modified: Tuesday 08 July 2014 10:30:28 CEST

################################################################################################

#	PURPOSE		########################################################################
#
#	Test the  soap service at EUstat

################################################################################################
library(RCurl)
library(XML)
################################################################################################


# GetDataflow for the list of available datasets from EU stat example

h = basicTextGatherer()

body='sandbox/example1.xml<?xml version="1.0" encoding="UTF-8" ?>
  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:web="http://www.sdmx.org/resources/sdmxml/schemas/v2_1/webservices"
    xmlns:mes="http://www.sdmx.org/resources/sdmxml/schemas/v2_1/message"
    xmlns:com="http://www.sdmx.org/resources/sdmxml/schemas/v2_1/common"
    xmlns:quer="http://www.sdmx.org/resources/sdmxml/schemas/v2_1/query">
    <soapenv:Header/>
    <soapenv:Body>
      <web:GetDataflow>
        <mes:DataflowQuery>
          <mes:Header>
            <mes:ID>QUERY</mes:ID>
            <mes:Test>false</mes:Test>
            <mes:Prepared>2012-09-14</mes:Prepared>
            <mes:Sender id="SENDER"/>
            <mes:Receiver id="RECEIVER"/>
          </mes:Header>
          <mes:Query>
            <quer:ReturnDetails detail="Full" returnMatchedArtefact="true">
              <quer:References processConstraints="false" detail="Full">
                <quer:None/>
              </quer:References>
            </quer:ReturnDetails>
            <quer:DataflowWhere/>
          </mes:Query>
        </mes:DataflowQuery>
      </web:GetDataflow>
    </soapenv:Body>\n'



# SOAP request
h$reset()
# curlPerform(url="http://www.ec.europa.eu/",
curlPerform(url="http://ec.europa.eu/eurostat/SDMX/diss-ws/SdmxServiceService",
      httpheader=c(Accept="text/xml", Accept="multipart/*",
		    SOAPAction='GetDataflow',
		   'Content-Type' = "text/xml; charset=utf-8",'User-Agent'='R'),
      postfields=body,
      writefunction = h$update,
      verbose = TRUE
     )

body=h$value()

# unformatted body
body

# ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

