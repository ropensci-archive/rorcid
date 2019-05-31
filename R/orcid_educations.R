#' Get education information for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @param summary (logical) get education summary for a put code. 
#' Default: `FALSE`
#' @template deets
#'
#' @examples \dontrun{
#' # all education data
#' res <- orcid_educations(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' names(res$`0000-0002-1642-628X`)
#' res$`0000-0002-1642-628X`$`education-summary`
#' 
#' # individual education records
#' orcid_educations(orcid = "0000-0002-1642-628X", 148494)
#' 
#' # education summary information
#' orcid_educations(orcid = "0000-0002-1642-628X", 148494, summary = TRUE)
#' }
orcid_educations <- function(orcid, put_code = NULL, 
                          format = "application/json", summary = FALSE, ...) {
  pth <- path_picker(put_code, summary, "education")
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
