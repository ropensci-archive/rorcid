#' Get distinction for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#' @param summary (logical) get education summary for a put code. 
#' Default: `FALSE`
#'
#' @examples \dontrun{
#' res <- orcid_distinctions(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' res$`0000-0002-1642-628X`$`created-date`
#' res$`0000-0002-1642-628X`$`affiliation-group`
#' res$`0000-0002-1642-628X`$path
#' }
orcid_distinctions <- function(orcid, put_code = NULL, 
                          format = "application/json", summary = FALSE, ...) {
  pth <- path_picker(put_code, summary, "distinction")
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
