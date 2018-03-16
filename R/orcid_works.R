#' Get works for a person
#'
#' @export
#' @param orcid (character) Orcid identifier(s), of the form 
#' XXXX-XXXX-XXXX-XXXX. required.
#' @param put_code (character/integer) one or more put codes. up to 
#' 50. optional
#' @param format (character) Name of the content-type format. One of
#' "application/vnd.orcid+xml; qs=5", "application/orcid+xml; qs=3",
#' "application/xml", "application/vnd.orcid+json; qs=4",
#' "application/orcid+json; qs=2", "application/json"
#' "application/vnd.citationstyles.csl+json". optional
#' @param ... Curl options passed on to [crul::HttpClient()]
#' @template deets
#'
#' @examples \dontrun{
#' # get all works
#' res <- orcid_works(orcid = "0000-0002-9341-7985")
#' res$`0000-0002-9341-7985`
#' res$`0000-0002-9341-7985`$type
#' str(res$`0000-0002-9341-7985`)
#' 
#' # get individual works
#' orcid_works(orcid = "0000-0002-9341-7985", put_code = 5011717)
#' orcid_works(orcid = "0000-0002-9341-7985", put_code = c(5011717, 15536016))
#' 
#' # change formats
#' orcid_works("0000-0002-9341-7985", 5011717, "application/json")
#' orcid_works("0000-0002-9341-7985", 5011717, "application/xml")
#' orcid_works("0000-0002-9341-7985", 5011717, 
#'   "application/vnd.orcid+xml; qs=5")
#' orcid_works("0000-0002-9341-7985", 5011717, 
#'   "application/vnd.citationstyles.csl+json")
#' 
#' # get citations
#' id <- "0000-0001-7678-8656"
#' x <- orcid_works(id)
#' orcid_works(id, put_code = x[[1]]$`put-code`)[[1]]$`work.citation.citation-value`
#' 
#' ## or send many put codes at once, will be split into chunks of 50 each
#' id <- "0000-0001-6758-5101"
#' x <- orcid_works(id)
#' pcodes <- x[[1]]$`put-code`
#' length(pcodes)
#' res <- orcid_works(orcid = id, put_code = pcodes)
#' lapply(res$`0000-0001-6758-5101`, head, n = 1)
#' }
orcid_works <- function(orcid, put_code = NULL, format = "application/json", 
  ...) {

  if (!is.null(put_code)) {
    if (length(orcid) > 1) {
      stop("if 'put_code' is given, 'orcid' must be length 1")
    }
  }

  pth <- if (is.null(put_code)) {
    "works" 
  } else {
    if (length(put_code) > 1) {
      chunks <- split(put_code, ceiling(seq_along(put_code) / 50))
      lapply(chunks, function(z) file.path("works", paste0(z, collapse = ",")))
    } else {
      file.path("work", put_code)
    }
  }

  if (length(pth) > 1) {
    tmp <- Map(function(z) orcid_prof_helper(orcid, z, ctype = format), pth)
    tt <- unname(lapply(tmp, function(z) z$bulk))
    stats::setNames(list(tt), orcid)
  } else {
    tmp <- lapply(orcid, orcid_prof_helper, path = pth, ctype = format, ...)
    tt <- lapply(tmp, function(z) {
      if (grepl("works", pth) || (is.list(pth) && grepl("works/", pth[[1]]))) {
        if (is.null(put_code)) {
          bb <- z$group$`work-summary`
          if (is_json(format)) list(as_dt(bb, FALSE)) else list(bb)
        } else {
          list(z$bulk)
        }
      } else if (grepl("work/", pth)) {
        if (is_json(format)) {
          jsonlite::fromJSON(
            jsonlite::toJSON(list(z, z), auto_unbox=TRUE)
          )[1,]
        } else {
          z
        }
      } else {
        z$bulk
      }
    })
    stats::setNames(tt, orcid)
  }
}

is_json <- function(format) grepl("json", format)
