#' Get data for particular ORCID's
#'
#' @export
#'
#' @param orcid Orcid identifier(s), of the form XXXX-XXXX-XXXX-XXXX.
#' @param profile Bibliographic ("bio"), biographical ("works"), or profile ("profile").
#' Default: profile
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#'
#' @details This function is vectorized, so you can pass in many ORCID's, and there's an
#' element returned for each ORCID you put in.
#' @return A list of results for each Orcid ID passed in, with each element named by the Orcid ID
#'
#' @examples \dontrun{
#' orcid_id(orcid = "0000-0002-9341-7985")
#' orcid_id(orcid = "0000-0002-9341-7985", "works")
#' orcid_id(orcid = "0000-0002-9341-7985", "bio")
#' orcid_id(orcid = "0000-0003-1620-1408")
#' orcid_id(orcid = "0000-0002-9341-7985", profile="works")
#' ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
#' orcid_id(orcid = ids)
#'
#' library("httr")
#' orcid_id(orcid = "0000-0003-1620-1408", config=verbose())
#' }

orcid_id <- function(orcid = NULL, profile = "profile", ...){
	doit <- function(x) {
	  temp <- match.arg(profile, choices = c("bio", "works", "profile"))
	  url2 <- file.path(orcid_base(), x, paste0("orcid-", temp))
		out <- orc_GET_err(url2, ...)
		res <- jsonlite::fromJSON(out, flatten = TRUE)$`orcid-profile`
		works <- get_works(res)
		res <- pop(res, "orcid-activities")
		res$works <- works
		structure(res, class = "orcid_id", profile = profile)
	}
	setNames(lapply(orcid, doit), orcid)
}

get_works <- function(x){
  x$`orcid-activities`$`orcid-works`$`orcid-work`
}
