#' Loads the index of available datasets from Eurostat.
#'
#' This function downloads the current index of available datasets from Eurostat
#' using the websites REST service.
#'
#' @param lang language used to display name of dataflow. \code{en} for english (default),
#' \code{de} for german or \code{fr} for french.
#' @param online Boolean to indicate if the data should be returned from a 
#' file included in this package (\code{FALSE}) or if it should be downloaded from 
#' Eurostat directly (\code{FALSE}). The local file will load faster but might 
#' be outdated). 
#' @param url address of the dataflow list (REST). This could be used when Eurostat
#' changes the respective address of the REST service
#' @import RCurl XML
#' @export
#' @return dataframe with two variables ID and name
estat_index <- function(lang = c("en","de","fr"), 
                        online = FALSE,
                        url = "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/dataflow/ESTAT/all/latest") 
  {
  # Test Arguments
  lang <- match.arg(lang)
  if(!is.logical(online)) stop("'online' must be either TRUE or FALSE")
  ## [TODO] test if url is url indeed a valid url
  
  ## get xml content
  if(online==FALSE){
    load(system.file("largedata/dataflowlist.rda", package="reurostat"))
  }
    
  if(online==TRUE){
  doc <- getURL(url,
                httpheader=list('User-Agent'='R'))
  }
  
  ## internal tree supposed to be faster according to doc
  xmlfile <- xmlInternalTreeParse(doc) 
  
  ## get the IDs of the dataflows
  ids <- xpathSApply(xmlfile, "//str:Dataflow[@id]", xmlGetAttr, "id")

  # Get the associated references to fetch the data structure for a particular set
  ids_ref <- xpathSApply(xmlfile, "//str:Structure/Ref [@id]", xmlGetAttr, "id")

  ## get the names of the dataflows (Language specified in 'lang')
  xpath <- paste0("//com:Name[@xml:lang='",lang,"']")
  description <- xpathSApply(xmlfile, xpath , xmlValue)
  
  # bind it all into a dataframe and return the result
  temp <- data.frame(data_id=ids, data_ref=ids_ref, data_description=description)
  return(temp)
}



