#' Get activities for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' res <- orcid_activities(orcid = "0000-0002-9341-7985")
#' res$`0000-0002-9341-7985`
#' names(res$`0000-0002-9341-7985`)
#' res$`0000-0002-9341-7985`$`last-modified`
#' res$`0000-0002-9341-7985`$`educations`
#' res$`0000-0002-9341-7985`$`fundings`
#' res$`0000-0002-9341-7985`$`peer-reviews`
#' res$`0000-0002-9341-7985`$`works`
#' }
orcid_activities <- function(orcid, ...) {
  stats::setNames(
    lapply(orcid, orcid_prof_helper, path = "activities", ...), 
    orcid
  )
}
