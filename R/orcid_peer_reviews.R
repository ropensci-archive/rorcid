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
  
  pth <- if (!summary) {
    if (is.null(put_code)) "peer-reviews" else "peer-review"
  } else {
    if (is.null(put_code)) {
      stop("if summary == TRUE, must give 1 or more put_code")
    }
    "peer-review/summary"
  }
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
