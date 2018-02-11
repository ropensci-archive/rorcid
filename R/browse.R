#' Navigate to an ORCID profile in your default browser
#'
#' @export
#' @param orcid An `or_cid` class object
#' @examples \dontrun{
#' browse(as.orcid("0000-0002-1642-628X"))
#' }
browse <- function(orcid){
  orcid <- as.orcid(orcid)
  utils::browseURL(paste0("https://orcid.org/", orcid[[1]]$name$path))
}
