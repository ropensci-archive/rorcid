#' Get biography data for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' res <- orcid_bio(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' res$`0000-0002-1642-628X`$`created-date`
#' res$`0000-0002-1642-628X`$`last-modified-date`
#' res$`0000-0002-1642-628X`$`content`
#' res$`0000-0002-1642-628X`$`visibility`
#' res$`0000-0002-1642-628X`$path
#' }
orcid_bio <- function(orcid, format = "application/json", ...) {
  stats::setNames(
    lapply(orcid, orcid_prof_helper, path = "biography", ctype = format, ...), 
    orcid
  )
}
