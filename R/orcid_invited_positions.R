#' Get invited positions for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' res <- orcid_invited_positions(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' res$`0000-0002-1642-628X`$`created-date`
#' res$`0000-0002-1642-628X`$`affiliation-group`
#' res$`0000-0002-1642-628X`$path
#' }
orcid_invited_positions <- function(orcid, put_code = NULL, 
                          format = "application/json", summary = FALSE, ...) {
  pth <- path_picker(put_code, summary, "invited-position")
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}

