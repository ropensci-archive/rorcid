#' Get education information for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' res <- orcid_email(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' names(res$`0000-0002-1642-628X`)
#' res$`0000-0002-1642-628X`$`email`
#' }
orcid_email <- function(orcid, ...) {
  stats::setNames(lapply(orcid, orcid_prof_helper, path = "email", ...), 
    orcid)
}
