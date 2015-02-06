#' Get data for particular ORCID ID's.
#' 
#' @export
#' 
#' @param orcid Orcid identifier(s), of the form XXXX-XXXX-XXXX-XXXX.
#' @param profile Bibliographic ("bio"), biographical ("works"), or 
#' 		both ("both", the default).
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' 
#' @return A list of results for each Orcid ID passed in, with each element named by the Orcid ID
#' 
#' @examples \dontrun{
#' orcid_id(orcid = "0000-0002-9341-7985")
#' orcid_id(orcid = "0000-0002-9341-7985")
#' orcid_id(orcid = "0000-0003-1620-1408")
#' orcid_id(orcid = "0000-0002-9341-7985", profile="works")
#' ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
#' orcid_id(orcid = ids)
#' }

orcid_id <- function(orcid = NULL, profile = NULL, ...){
	doit <- function(x) {
		if(!is.null(profile)){
			temp <- match.arg(profile, choices=c("bio", "works", "profile", "record"))
			url2 <- file.path(orcid_base(), x, paste0("orcid-", temp))
		} else { 
		  url2 <- file.path(orcid_base(), x, "orcid-profile") 
		}
		out <- orc_GET(url2)
		structure(jsonlite::fromJSON(out)$`orcid-profile`, class="orcid_profile")
	}
	setNames(lapply(orcid, doit), orcid)
}
