#' Get peer review information for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @param summary (logical) get peer review summary for a put code. 
#' Default: `FALSE` 
#' @template deets
#'
#' @examples \dontrun{
#' # all peer review data
#' res <- orcid_peer_reviews(orcid = "0000-0001-7678-8656")
#' res$`0000-0001-7678-8656`
#' names(res$`0000-0001-7678-8656`)
#' res$`0000-0001-7678-8656`$`group`
#' 
#' # get individual works
#' orcid_peer_reviews("0000-0003-1444-9135", 75565)
#' 
#' # summary
#' orcid_peer_reviews("0000-0003-1444-9135", 75565, summary = TRUE)
#' 
#' # get Journal titles via ISSN's provided in results, using the 
#' # provided issn_title dataset
#' x <- orcid_peer_reviews("0000-0001-7678-8656", put_code = "220419")
#' issn <- strsplit(x[[1]]$`review-group-id`, ":")[[1]][[2]]
#' issn_title[[issn]]
#' }
orcid_peer_reviews <- function(orcid, put_code = NULL, 
                          format = "application/json", summary = FALSE, ...) {
  pth <- path_picker(put_code, summary, "peer-review")
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
