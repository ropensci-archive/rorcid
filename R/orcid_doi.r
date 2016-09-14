#' Search for ORCID ID's using DOIs
#' 
#' @export
#' 
#' @param dois (character) Digital object identifier (DOI), a vector fo DOIs.
#' @param start (integer) Result number to start on. Keep in mind that pages 
#' start at 0.
#' @param rows (integer) Numer of results to return.
#' @param fuzzy (logical) Use fuzzy matching on input DOIs. Defaults to FALSE. 
#' If FALSE, we stick "digital-object-ids" before the DOI so that the search 
#' sent to ORCID is for that exact DOI. If TRUE, we use some regex to find 
#' the DOI.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' 		
#' @examples \dontrun{
#' orcid_doi(dois="10.1087/20120404", fuzzy=TRUE)
#' 
#' # fuzzy is FALSE by default
#' orcid_doi(dois="10.1087/20120404", fuzzy=FALSE)
#' 
#' # This DOI is not a real one, but a partial DOI, then we can fuzzy search
#' # get more than defualt 10 records (or rows)
#' orcid_doi(dois="10.1087/2", fuzzy=TRUE, rows=20) 
#' 
#' # If you don't input proper DOIs, the function will get mad
#' dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
#'        "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
#' orcid_doi(dois=dois)
#' 
#' # dois <- c("10.1016/j.medpal.2008.12.005","10.1080/00933104.2000.10505926",
#' #          "10.1037/a0024480", "10.1002/anie.196603172","2344","asdf","232",
#' #          "asdf","23dd")
#' # orcid_doi(dois=dois)
#' 
#' orcid_doi(dois="10.1087/20120404", fuzzy=FALSE) 
#' orcid_doi(dois="10.1371/journal.pone.0025995", fuzzy=FALSE)
#' }

orcid_doi <- function(dois = NULL, start = NULL, rows = NULL, fuzzy = FALSE, ...){
  bad_dois(dois)
	getdata <- function(x){
		args <- ocom(list(q = fuzzydoi(x, fuzzy), start = start, rows = rows))
		out <- orc_GET_err(
		  file.path(orcid_base(), "search/orcid-bio"), args, orcid_auth(), ...)
		structure(orc_parse(out), doi = x)
	}
	getdata_safe <- failwith(NULL, getdata)
	structure(ocom(lapply(dois, getdata_safe)), class = "orcid_doi")
}
