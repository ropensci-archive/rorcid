#' Get external identifiers for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' # all data
#' res <- orcid_external_identifiers(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' names(res$`0000-0002-1642-628X`)
#' res$`0000-0002-1642-628X`$`external-identifier`
#' 
#' # individual records
#' orcid_external_identifiers(orcid = "0000-0002-1642-628X", 141736)
#' }
orcid_external_identifiers <- function(orcid, put_code = NULL, 
                                       format = "application/json", ...) {
  orcid_putcode_helper("external-identifiers", orcid, put_code, format, ...)
}
