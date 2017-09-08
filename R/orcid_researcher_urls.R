#' Get researcher urls for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' # all data
#' res <- orcid_researcher_urls(orcid = "0000-0003-1444-9135")
#' res$`0000-0003-1444-9135`
#' names(res$`0000-0003-1444-9135`)
#' res$`0000-0003-1444-9135`$`researcher-url`
#' 
#' # individual ones
#' orcid_researcher_urls("0000-0003-1444-9135", 304093)
#' orcid_researcher_urls("0000-0003-1444-9135", c(332241, 304093))
#' 
#' # formats
#' orcid_researcher_urls("0000-0003-1444-9135", 304093, 
#'   format = "application/xml")
#' }
orcid_researcher_urls <- function(orcid, put_code = NULL, 
                                  format = "application/json", ...) {
  orcid_putcode_helper("researcher-urls", orcid, put_code, format, ...)
}
