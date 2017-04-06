#' Get works data 
#' 
#' @export
#' @param x Input from a call to [orcid_id()] or [as.orcid()]
#' @param ... Ignored.
#' @return An S3 object of class `works`
#' @details The goal of this function is to get a pretty printed quick sense
#' of the works for 1 or more ORCID's. You can also access the complete
#' data.frame of results. If an ORCID has works, this function prints the 
#' titles of the first 10. 
#' @examples \dontrun{
#' out <- works(orcid_id("0000-0002-9341-7985"))
#' out
#' out$data
#' 
#' #works( orcid_id("0000-0003-1620-1408") )
#' works( orcid_id("0000-0002-1642-628X") )
#' works( orcid_id("0000-0003-1444-9135") )
#' works( orcid_id("0000-0003-1419-2405") )
#' 
#' out <- orcid(query="keyword:ecology")
#' works(orcid_id(out$`orcid-identifier.path`[7]))
#' works(orcid_id(out$`orcid-identifier.path`[8]))
#' works(orcid_id(out$`orcid-identifier.path`[9]))
#' works(orcid_id(out$`orcid-identifier.path`[10]))
#' 
#' works(as.orcid("0000-0002-1642-628X"))
#' }
works <- function(x) {
  tmp <- as.orcid(x)
  works <- tmp[[1]]$works
  if (is.null(works) || NROW(works) == 0) {
    structure(list(data = "None"), class = "works", orcid = names(tmp))
  } else {
    structure(list(data = works), class = "works", orcid = names(tmp))
  }
}

#' @export
print.works <- function(x, ..., n = 10) {
  if (inherits(unclass(x)$data, "character")) {
    y <- x
  } else {
    y <- x$data$`work-title.title.value`
  }
  cat(sprintf('<WORKS> %s', attr(x, "orcid")), sep = "\n\n")
  cat(sprintf('  Count: %s - First %s', NROW(x$data), n), sep = "\n\n")
  stopifnot(is.numeric(n))
  y <- y[1:min(n, length(y))]
  for (i in seq_along(y)) {
    cat(sprintf("- %s", y[i]), sep = "\n")
  }
}
