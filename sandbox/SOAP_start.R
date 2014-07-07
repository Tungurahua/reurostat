# worked along example from here:
# http://arademaker.github.io/blog/2012/01/02/package-SSOAP.html

## needs SSOAP package from omegahat !!
#install.packages("SSOAP", repos = "http://www.omegahat.org/R", 
#                   dependencies = TRUE, 
#                   type = "source")

library(SSOAP)
library(XML)
library(RCurl)


## All server dfinitions should be given in *.wsdl file
## wsdl uris from Eurostat 
# 2.0 http://ec.europa.eu/eurostat/SDMX/diss-ws/NSIStdV20Service?wsdl
# 2.1 http://ec.europa.eu/eurostat/SDMX/diss-ws/SdmxServiceService?wsdl
# wsdl <- getURL("http://ec.europa.eu/eurostat/SDMX/diss-ws/NSIStdV20Service?wsdl")
## getURL doesn't work so I download a local copy
#doc <- xmlInternalTreeParse(wsdl)

# from local file
doc <- xmlInternalTreeParse("sandbox/SdmxServiceService.wsdl")

def <- processWSDL(doc)

ff  <- genSOAPClientInterface(def = def)
# again some hickup. Problems with the Eurostat WSDL or with the SSOAP package?

