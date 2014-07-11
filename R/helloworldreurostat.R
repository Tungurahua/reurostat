#' Print hello
#'
#' This function prints hello 
#'
#' @param fname First name
#' @param lname Last name
#' @export

#' @examples
#' helloreurostat(fname="Albrecht",lname="Gradmann")
#' helloreurostat(fname="Stefan",lname="Luedtke")

helloreurostat <- function(fname, lname){
	cat(paste0("Your name is", fname, lname, "\n"))
}
