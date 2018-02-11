#' Get employment information for a person
#'
#' @export
#' @inheritParams orcid_works
#' @param summary (logical) get employment summary for a put code. 
#' Default: `FALSE` 
#' @template deets
#'
#' @examples \dontrun{
#' # all employment data
#' res <- orcid_employments(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' names(res$`0000-0002-1642-628X`)
#' res$`0000-0002-1642-628X`$`employment-summary`
#' 
#' # individual employment records
#' orcid_employments(orcid = "0000-0002-1642-628X", 1115445)
#' orcid_employments(orcid = "0000-0002-1642-628X", 148496)
#' 
#' # employment summary information
#' orcid_employments(orcid = "0000-0002-1642-628X", 1115445, summary = TRUE)
#' }
orcid_employments <- function(orcid, put_code = NULL, 
                          format = "application/json", summary = FALSE, ...) {
  
  pth <- if (!summary) {
    if (is.null(put_code)) "employments" else "employment"
  } else {
    if (is.null(put_code)) {
      stop("if summary == TRUE, must give 1 or more put_code")
    }
    "employment/summary"
  }
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
