#' Get data for particular ORCID's
#'
#' @export
#'
#' @param orcid Orcid identifier(s), of the form XXXX-XXXX-XXXX-XXXX.
#' @param profile Bibliographic ("bio"), biographical ("works"), or 
#' profile ("profile"). Default: profile
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#'
#' @details This function is vectorized, so you can pass in many ORCID's, and 
#' there's an element returned for each ORCID you put in.
#' @return A list of results for each Orcid ID passed in, with each element 
#' named by the Orcid ID
#'
#' @examples \dontrun{
#' res <- orcid_id(orcid = "0000-0002-9341-7985")
#' res$`0000-0002-9341-7985`
#' res$`0000-0002-9341-7985`$`orcid-identifier`
#' res$`0000-0002-9341-7985`$`orcid-preferences`
#' res$`0000-0002-9341-7985`$`orcid-history`
#' res$`0000-0002-9341-7985`$`orcid-bio`
#' res$`0000-0002-9341-7985`$works
#' 
#' orcid_id(orcid = "0000-0002-9341-7985", "works")
#' orcid_id(orcid = "0000-0002-9341-7985", "bio")
#' orcid_id(orcid = "0000-0003-1620-1408")
#' orcid_id(orcid = "0000-0002-9341-7985", profile="works")
#' ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
#' orcid_id(orcid = ids)
#'
#' library("httr")
#' orcid_id(orcid = "0000-0003-1620-1408", config=verbose())
#' 
#' # only certain orcid's make employment/funding/eduction public
#' ## some egs where it is public
#' ### education and employment
#' res <- orcid_id('0000-0003-1444-9135')
#' res[[1]]$`orcid-activities`$affiliations$affiliation
#' 
#' ### education, employment, and funding
#' res <- orcid_id('0000-0002-1642-628X')
#' res[[1]]$`orcid-activities`$affiliations$affiliation
#' res[[1]]$`orcid-activities`$`funding-list`$funding
#' }

orcid_id <- function(orcid = NULL, profile = "profile", ...){
	doit <- function(x) {
	  temp <- match.arg(profile, choices = c("bio", "works", "profile"))
	  url2 <- file.path(orcid_base(), x, paste0("orcid-", temp))
		out <- orc_GET_err(url2, ...)
		res <- jsonlite::fromJSON(out, flatten = TRUE)$`orcid-profile`
		res$works <- get_works(res)
		res$`orcid-activities`$`orcid-works`$`orcid-work` <- NULL
		structure(res, class = "orcid_id", profile = profile)
	}
	stats::setNames(lapply(orcid, doit), orcid)
}

get_works <- function(x){
  tibble::as_data_frame(x$`orcid-activities`$`orcid-works`$`orcid-work`)
}
