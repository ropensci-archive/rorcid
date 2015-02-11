#' Navigate to an ORCID profile in your default browser
#'
#' @export
#' @param orcid An \code{or_cid} class object
#' @examples \dontrun{
#' browse(as.orcid("0000-0002-1642-628X"))
#' }
browse <- function(orcid){
  orcid <- as.orcid(orcid)
  browseURL(orcid[[1]]$`orcid-identifier`$uri)
}
