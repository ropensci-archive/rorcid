#' Get services
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#' @param summary (logical) get education summary for a put code. 
#' Default: `FALSE`
#'
#' @examples \dontrun{
#' res <- orcid_services(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' res$`0000-0002-1642-628X`$`last-modified-date`
#' res$`0000-0002-1642-628X`$`affiliation-group`
#' res$`0000-0002-1642-628X`$path
#' }
orcid_services <- function(orcid, put_code = NULL, 
                          format = "application/json", summary = FALSE, ...) {
  pth <- path_picker(put_code, summary, "service")
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
