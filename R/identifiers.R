#' @title Get identifiers
#' 
#' @description This function aims to pluck out just identifiers into a vector
#' for easy use downstream (e.g., use DOIs to fetch article metadata). You can 
#' still manually fetch additional data from outputs of functions in this package.
#' 
#' @export
#' @param x An object of class works, orcid, orcid_id, orcid_doi, or a list that 
#' contains any number of the previous objects.
#' @param type (character) One of doi (default), pmid, pmc, eid, other_id, 
#' orcid, scopus, researcherid. The orcid's here are for works, not individuals.
#' @param ... Ignored.
#' @return A vector of identifiers, or NULL if none found
#' @examples \dontrun{
#' # Result of call to works()
#' x <- works(orcid_id("0000-0001-8607-8025"))
#' # doi by default
#' identifiers(x)
#' # orcids
#' identifiers(x, "orcid")
#' # pmid
#' identifiers(x, "pmid")
#' # pmc 
#' identifiers(x, "pmc") 
#' # other_id
#' identifiers(x, "other_id")
#' 
#' # Result of call to orcid_id()
#' x <- orcid_id(orcid = "0000-0002-9341-7985")
#' identifiers(x, "doi")
#' identifiers(x, "eid")
#' 
#' # Result of call to orcid()
#' x <- orcid(query="carl+boettiger")
#' identifiers(x, "scopus")
#' identifiers(x, "researcherid")
#' 
#' # Result of call to orcid_doi()
#' x <- orcid_doi(dois="10.1087/20120404", fuzzy=TRUE)
#' identifiers(x, "scopus")
#' }
identifiers <- function(x, type = "doi", ...) {
  UseMethod("identifiers")
}

#' @export
#' @rdname identifiers
identifiers.works <- function(x, type = "doi", ...) {
  type <- check_type(type)
  if (type == "orcid") {
    x$data$`work-source.path`
  } else {
    tmp <- x$data$`work-external-identifiers.work-external-identifier`
    unlist(lapply(tmp, function(z) {
      z[tolower(z$`work-external-identifier-type`) %in% type, 
        "work-external-identifier-id.value"]
    }))
  }
}

#' @export
#' @rdname identifiers
identifiers.list <- function(x, type = "doi", ...) {
  lapply(x, identifiers, type = type, ...)
}

#' @export
#' @rdname identifiers
identifiers.orcid_id <- function(x, type = "doi", ...) {
  prof <- attr(x, "profile")
  tmp <- x$works$`work-external-identifiers.work-external-identifier`
  unlist(lapply(tmp, function(z) {
    z[tolower(z$`work-external-identifier-type`) %in% check_type(type), 
      "work-external-identifier-id.value"]
  }))
}

#' @export
#' @rdname identifiers
identifiers.orcid <- function(x, type = "doi", ...) {
  tmp <- x$data$`external-identifiers.external-identifier`
  unlist(lapply(tmp, function(z) {
    z[grep(check_type(type), tolower(z$`external-id-common-name.value`)), 
      "external-id-reference.value"]
  }))
}

#' @export
#' @rdname identifiers
identifiers.orcid_doi <- function(x, type = "doi", ...) {
  tmp <- x$data$`external-identifiers.external-identifier`
  unlist(lapply(tmp, function(z) {
    z[grep(check_type(type), tolower(z$`external-id-common-name.value`)), 
      "external-id-reference.value"]
  }))
}

# helpers ------------------
check_type <- function(y) {
  match.arg(y, c("doi", "pmid", "pmc", "eid", "other_id", 
                 "orcid", "scopus", "researcherid"))
}
