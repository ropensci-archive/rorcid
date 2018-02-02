#' Get data for particular ORCID's
#'
#' @export
#'
#' @param orcid (character) A single Orcid identifier, of the 
#' form XXXX-XXXX-XXXX-XXXX
#' @param ... Curl options passed on to [crul::HttpClient()]
#'
#' @return A named list of results - from a call to [orcid_person()]
#'
#' @examples \dontrun{
#' res <- orcid_id(orcid = "0000-0002-9341-7985")
#' res$`0000-0002-9341-7985`
#' res$`0000-0002-9341-7985`$`name`
#' res$`0000-0002-9341-7985`$`other-names`
#' res$`0000-0002-9341-7985`$`biography`
#' res$`0000-0002-9341-7985`$`researcher-urls`
#' res$`0000-0002-9341-7985`$`emails`
#' res$`0000-0002-9341-7985`$`addresses`
#' res$`0000-0002-9341-7985`$`keywords`
#' res$`0000-0002-9341-7985`$`external-identifiers`
#' res$`0000-0002-9341-7985`$`emails`
#' 
#' ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
#' res <- lapply(ids, orcid_id)
#' vapply(res, function(x) x[[1]]$name$`family-name`$value, "")
#' }
orcid_id <- function(orcid, ...) {
	stopifnot(is.character(orcid))
	stopifnot(length(orcid) == 1)
	structure(orcid_person(orcid, ...), class = "orcid_id")
}
