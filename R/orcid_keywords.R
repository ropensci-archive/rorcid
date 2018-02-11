#' Get education information for a person
#'
#' @export
#' @inheritParams orcid_works 
#' @template deets
#'
#' @examples \dontrun{
#' # all data
#' res <- orcid_keywords(orcid = "0000-0002-1642-628X")
#' res$`0000-0002-1642-628X`
#' names(res$`0000-0002-1642-628X`)
#' res$`0000-0002-1642-628X`$`keyword`
#' 
#' # individual ones
#' orcid_keywords("0000-0002-1642-628X", 31202)
#' }
orcid_keywords <- function(orcid, put_code = NULL, format = "application/json", 
                           ...) {
  orcid_putcode_helper("keywords", orcid, put_code, format, ...)
}
