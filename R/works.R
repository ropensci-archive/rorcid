#' Get works data 
#' 
#' @export
#' @param x Anything that can be coerced via [as.orcid()], see 
#' [as.orcid()] for help
#' @param ... curl options passed on to [crul::HttpClient]
#' @return A tibble (data.frame)
#' @details This function gets works using the function [orcid_works]
#' and packages up the data in a data.frame for easier processing
#' @examples \dontrun{
#' out <- works(orcid_id("0000-0002-9341-7985"))
#' out
#' out$type
#' out$path
#' 
#' works( orcid_id("0000-0002-1642-628X") )
#' works( orcid_id("0000-0003-1444-9135") )
#' works( orcid_id("0000-0003-1419-2405") )
#' 
#' out <- orcid(query="keyword:ecology")
#' works(orcid_id(out$`orcid-identifier.path`[7]))
#' works(orcid_id(out$`orcid-identifier.path`[8]))
#' works(orcid_id(out$`orcid-identifier.path`[9]))
#' works(orcid_id(out$`orcid-identifier.path`[10]))
#' }
works <- function(x) {
  tmp <- as.orcid(x)
  works <- orcid_works(tmp[[1]]$name$path)
  if (is.null(works) || NROW(works[[1]][[1]]) == 0) {
    dat <- tibble::data_frame()
    structure(dat, class = c(class(dat), "works"), 
      orcid = names(tmp))
  } else {
    dat <- tibble::as_tibble(works[[1]][[1]])
    structure(dat, class = c(class(dat), "works"), 
      orcid = names(tmp))
  }
}
