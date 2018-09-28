#' Get citations
#'
#' @export
#' @param orcid (character) Orcid identifier(s), of the form 
#' XXXX-XXXX-XXXX-XXXX. required.
#' @param put_code (character/integer) one or more put codes. up to 
#' 50. optional
#' @param ... Curl options passed on to [crul::HttpClient()]
#' @template deets
#' @details This function is focused on getting citations only.
#' You can get all citations for an ORCID, or for certain works
#' using a PUT code, or for many PUT codes.
#' 
#' We attempt to get citations via Crossref using \pkg{rcrossref} 
#' whenever possible as they are the most flexible and don't have as 
#' many mistakes in the text. If there is no DOI, we fetch the 
#' citation from ORCID.
#' 
#' Right now we get JSON citation back. We'd like to support bibtex
#' format. DOI.org supports this but not ORCID.
#'
#' @return data.frame, with the columns:
#' 
#' - put: ORCID PUT code, identifying the work identifier in ORCID's records
#' - id: the external identifier
#' - id_type: the type of external identifier
#' - citation: the citation as JSON
#' 
#' @examples \dontrun{
#' (res <- orcid_citations(orcid = "0000-0002-9341-7985"))
#' (res2 <- orcid_citations(orcid = "0000-0002-1642-628X"))
#' 
#' # get individual works
#' ## a single put code
#' (a <- orcid_citations(orcid = "0000-0002-9341-7985", put_code = 5011717))
#' ## many put codes
#' (b <- orcid_citations(orcid = "0000-0002-9341-7985", 
#'    put_code = c(5011717, 15536016)))
#' }
orcid_citations <- function(orcid, put_code = NULL, ...) {
  if (!is.null(put_code)) {
    if (length(orcid) > 1) {
      stop("if 'put_code' is given, 'orcid' must be length 1")
    }
  }

  tmp <- orcid_works(orcid, put_code)
  dat <- if (!is.null(put_code)) {
    list(tmp[[1]]$works)
  } else {
    split(tmp[[1]]$works, tmp[[1]]$works$`put-code`)
  }
  cites <- lapply(dat, function(z) {
    # fix for when > 1 put code to make column names more useable
    if (all(grepl("work", names(z)))) {
      names(z) <- gsub("^work\\.", "", names(z))
    }
    pc <- z$`put-code`
    if (!is.null(put_code)) {
      if (length(put_code) == 1) {
        df <- z$`external-ids`$`external-id`[[1]]
        process_cites(df, pc, orcid, ...)
      } else {
        # df <- as_dt(z$`external-ids`)
        df <- z$`external-ids`
        Map(process_cites, df, pc, orcid = orcid, ...)
      } 
    } else {
      df <- z$`external-ids.external-id`[[1]]
      process_cites(df, pc, orcid, ...)
    }
  })
  # unnest if no names at top level
  if (is.null(names(cites[[1]])) && length(cites[[1]]) > 1) cites <- unlist(cites, FALSE)
  # combine
  as_dt(cites)
}

process_cites <- function(df, pc, orcid, ...) {
  if ("doi" %in% df$`external-id-type`) {
    id <- df[df$`external-id-type` %in% "doi", "external-id-value"]
    type <- "doi"
    ct <- cite_doi(id, ...)
  } else {
    id <- df[df$`external-id-type` %in% "eid", "external-id-value"]
    type <- "eid"
    ct <- cite_put(orcid, pc, ...)
  }
  list(put = pc, id = id, id_type = type, citation = ct)
}

chkpkg <- function(x) {
  if (!requireNamespace(x, quietly = TRUE)) {
    stop("Please install ", x, call. = FALSE)
  } else {
    invisible(TRUE)
  }
}

cite_doi <- function(x, ...) {
  chkpkg('rcrossref')
  rcrossref::cr_cn(x, format = 'citeproc-json-ish', raw = TRUE, ...)
}

cite_put <- function(orcid, pc, ...) {
  orcid_prof_helper(orcid, file.path("work", pc), 
    ctype = "application/vnd.citationstyles.csl+json", 
    # ctype = "application/x-bibtex", 
    parse = FALSE, ...)
}
