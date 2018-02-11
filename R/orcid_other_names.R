#' Get education information for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' # all data
#' res <- orcid_other_names(orcid = "0000-0001-7893-4389")
#' res$`0000-0001-7893-4389`
#' names(res$`0000-0001-7893-4389`)
#' res$`0000-0001-7893-4389`$`other-name`
#' 
#' # individual ones
#' orcid_other_names("0000-0001-7893-4389", 239534)
#' 
#' # formats
#' orcid_other_names("0000-0001-7893-4389", format = "application/xml")
#' }
orcid_other_names <- function(orcid, put_code = NULL, 
                              format = "application/json", ...) {
  orcid_putcode_helper("other-names", orcid, put_code, format, ...)
}
