#' Get personal data for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @param details (logical). also get details. Default: `FALSE`
#' @template deets
#'
#' @examples \dontrun{
#' res <- orcid_person(orcid = "0000-0002-9341-7985")
#' res$`0000-0002-9341-7985`
#' names(res$`0000-0002-9341-7985`)
#' res$`0000-0002-9341-7985`$`last-modified`
#' res$`0000-0002-9341-7985`$`keywords`
#' res$`0000-0002-9341-7985`$`biography`
#' }
orcid_person <- function(orcid, details = FALSE, ...) {
  pth <- if (details) "person-details" else "person"
  stats::setNames(lapply(orcid, orcid_prof_helper, path = pth, ...), orcid)
}
