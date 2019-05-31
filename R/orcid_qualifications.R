#' Get qualifications for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @param summary (logical) get peer review summary for a put code. 
#' Default: `FALSE` 
#' @template deets
orcid_qualifications <- function(orcid, put_code = NULL, 
                          format = "application/json", summary = FALSE, ...) {
  pth <- path_picker(put_code, summary, "qualification")
  orcid_putcode_helper(pth, orcid, put_code, format, ...)
}
