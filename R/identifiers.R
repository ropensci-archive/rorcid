#' @title Get identifiers
#' 
#' @description This function aims to pluck out just identifiers into a vector
#' for easy use downstream (e.g., use DOIs to fetch article metadata). You 
#' can still manually fetch additional data from outputs of functions in 
#' this package.
#' 
#' @export
#' @param x An object of class works, orcid, orcid_id, orcid_doi, or a list 
#' that contains any number of the previous objects.
#' @param type (character) One of doi (default), pmid, pmc, eid, other_id, 
#' orcid, scopus, researcherid. The orcid's here are for works, not 
#' individuals. This parameter is ignored for classes `orcid` and `orcid_doi`
#' both of which would go down a rabbit hole of getting works for all 
#' ORCIDs which could take a while.
#' @param ... Ignored.
#' @return (character) vector of identifiers, or NULL if none found
#' @references list of identifiers 
#' <https://pub.qa.orcid.org/v2.0/identifiers?locale=en>
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
#' identifiers(x)
#' 
#' # Result of call to orcid_doi()
#' x <- orcid_doi(dois="10.1087/20120404", fuzzy=TRUE)
#' identifiers(x)
#' }
identifiers <- function(x, type = "doi", ...) {
  UseMethod("identifiers")
}

identifiers.default <- function(x, type = "doi", ...) {
  stop("no 'identifiers' method for ", class(x), call. = FALSE)
}

#' @export
#' @rdname identifiers
identifiers.works <- function(x, type = "doi", ...) {
  type <- check_type(type)
  if (type == "orcid") {
    Filter(Negate(is.na), x$`source.source-orcid.path`)
  } else {
    tmp <- x$`external-ids.external-id`
    unlist(lapply(tmp, function(z) {
      z[tolower(z$`external-id-type`) %in% type, 
        "external-id-value"]
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
  # prof <- attr(x, "profile")
  wks <- works(x)
  tmp <- wks$`external-ids.external-id`
  unlist(lapply(tmp, function(z) {
    z[tolower(z$`external-id-type`) %in% check_type(type), 
      "external-id-value"]
  }))
}

#' @export
#' @rdname identifiers
identifiers.orcid <- function(x, type = "doi", ...) {
  x$`orcid-identifier.path`
}

#' @export
#' @rdname identifiers
identifiers.orcid_doi <- function(x, type = "doi", ...) {
  x[[1]]$`orcid-identifier.path`
}

# helpers ------------------
check_type <- function(y) {
  match.arg(y, c("doi", "pmid", "pmc", "eid", "other_id", 
                 "orcid", "scopus", "researcherid"))
}
