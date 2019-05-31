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
#' res <- orcid_peer_reviews(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' names(res$`0000-0002-1642-628X`)
#' res$`0000-0002-1642-628X`$`group`
#' 
#' # get individual works
#' orcid_peer_reviews("0000-0003-1444-9135", 75565)
#' 
#' # summary
#' orcid_peer_reviews("0000-0003-1444-9135", 75565, summary = TRUE)
#' }
orcid_peer_reviews <- function(orcid, put_code = NULL, 
                          format = "application/json", summary = FALSE, ...) {
  pth <- path_picker(put_code, summary, "peer-review")
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
