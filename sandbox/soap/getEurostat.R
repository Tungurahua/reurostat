library(RCurl)
library(XML)

# This is the URL taken from the EUROSTAT REST Api Description
u = "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/ei_naag_q/Q..TOTAL.NA-B1G-CP-MIO-EUR.RO+DE/?startperiod=2012&endPeriod=2013" 
  

# We need to specify the User-Agent, otherwise the request will be denied
db = getURI(u, httpheader=list('User-Agent'='R')) 

# Parse the result as xm
doc = xmlParse(db,asText=T)
doc
