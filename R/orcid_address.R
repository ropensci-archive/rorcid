#' Get address information for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' # all addresses
#' res <- orcid_address(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' names(res$`0000-0002-1642-628X`)
#' res$`0000-0002-1642-628X`$`address`
#' 
#' # individual address
#' orcid_address(orcid = "0000-0002-1642-628X", 288064)
#' 
#' # format
#' orcid_address(orcid = "0000-0002-1642-628X", 288064, "application/xml")
#' }
orcid_address <- function(orcid, put_code = NULL, 
                          format = "application/json", ...) {
  orcid_putcode_helper("address", orcid, put_code, format, ...)
}
