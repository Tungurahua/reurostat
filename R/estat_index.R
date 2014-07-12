#' Loads the index of available datasets from Eurostat.
#'
#' This function downloads the current index of available datasets from Eurostat
#' using the websites REST service.
#'
#' @param lang language used to display name of dataflow. \code{en} for english (default),
#' \code{de} for german or \code{fr} for french. 
#' @param url address of the dataflow list (REST) 
#' @import RCurl XML
#' @export
#' @return dataframe with two variables ID and name
estat_index <- function(lang = c("en","de","fr"), 
                        url = "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/dataflow/ESTAT/all/latest") 
  {
  lang <- match.arg(lang)
  ## [TODO] test if url is url indeed
  
  ## get xml content
  doc <- getURL(url,
                httpheader=list('User-Agent'='R'))
  
  ## internal tree supposed to be faster according to doc
  xmlfile <- xmlInternalTreeParse(doc) 
  
  ## get the IDs of the dataflows
  IDs  <-  xpathSApply(xmlfile, "//str:Dataflow[@id]", xmlGetAttr, "id")
  
  
  ## get the names of the dataflows (Language specified in 'lang')
  xpath <- paste0("//com:Name[@xml:lang='",lang,"']")
  names <-  xpathSApply(xmlfile, xpath , xmlValue)
  
  # bind it all into a dataframe and return the result
  temp <- data.frame(data_id=IDs, data_description=names)
  return(temp)
}



