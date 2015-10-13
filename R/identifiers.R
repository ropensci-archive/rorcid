#' Get identifiers
#' 
#' @export
#' @param x An object of class works, other things in the future
#' @param type (character) One of doi (default), pmid, pmc, other_id
#' @param ... Ignored.
#' @examples \dontrun{
#' x <- works(orcid_id("0000-0001-8607-8025"))
#' # doi by default
#' identifiers(x)
#' 
#' # pmid
#' identifiers(x, "pmid")
#' 
#' # pmc 
#' identifiers(x, "pmc") 
#' 
#' # other_id
#' identifiers(x, "other_id") 
#' }
identifiers <- function(x, type = "doi", ...) {
  UseMethod("identifiers")
}

#' @export
identifiers.works <- function(x, type = "doi", ...) {
  tmp <- x$data$`work-external-identifiers.work-external-identifier`
  unlist(lapply(tmp, function(z) {
    z[tolower(z$`work-external-identifier-type`) %in% type, 
      "work-external-identifier-id.value"]
  }))
}
