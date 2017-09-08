#' Check if ORCID API is up and running
#'
#' @export
#' @param ... Curl options passed on to [crul::HttpClient()]
#' @return a text string
#' @examples \dontrun{
#' orcid_ping()
#' }
orcid_ping <- function(...) {
  orc_GET(file.path(orcid_base(), "status"), ctype = "text/plain", ...)
}
