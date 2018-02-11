#' Get biography data for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' res <- orcid_bio(orcid = "0000-0002-9341-7985")
#' res$`0000-0002-9341-7985`
#' res$`0000-0002-9341-7985`$`created-date`
#' res$`0000-0002-9341-7985`$`last-modified-date`
#' res$`0000-0002-9341-7985`$`content`
#' res$`0000-0002-9341-7985`$`visibility`
#' res$`0000-0002-9341-7985`$path
#' 
#' orcid_bio(orcid = "0000-0003-1620-1408")
#' }
orcid_bio <- function(orcid, format = "application/json", ...) {
  stats::setNames(
    lapply(orcid, orcid_prof_helper, path = "biography", ctype = format, ...), 
    orcid
  )
}
