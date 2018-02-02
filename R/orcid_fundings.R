#' Get funding information for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @param summary (logical) get funding summary for a put code. 
#' Default: `FALSE` 
#' @template deets
#'
#' @examples \dontrun{
#' # all funding data
#' res <- orcid_fundings(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' names(res$`0000-0002-1642-628X`)
#' res$`0000-0002-1642-628X`$`group`
#' 
#' # individual funding records
#' orcid_fundings(orcid = "0000-0002-1642-628X", 385627)
#' 
#' # funding summary information
#' orcid_fundings(orcid = "0000-0002-1642-628X", 385627, summary = TRUE)
#' }
orcid_fundings <- function(orcid, put_code = NULL, 
                           format = "application/json", summary = FALSE, ...) {
  pth <- if (!summary) {
    if (is.null(put_code)) "fundings" else "funding"
  } else {
    if (is.null(put_code)) {
      stop("if summary == TRUE, must give 1 or more put_code")
    }
    "funding/summary"
  }
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
