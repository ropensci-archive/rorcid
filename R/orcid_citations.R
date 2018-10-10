#' Get citations
#'
#' @export
#' @param orcid (character) Orcid identifier(s) of the form 
#' XXXX-XXXX-XXXX-XXXX. required.
#' @param put_code (character/integer) one or more put codes. up to 
#' 50. optional
#' @param cr_format Used in Crossref queries only. Name of the format. One of 
#' "rdf-xml", "turtle",
#' "citeproc-json", "citeproc-json-ish", "text", "ris", "bibtex" (default), 
#' "crossref-xml", "datacite-xml","bibentry", or "crossref-tdm". The format 
#' "citeproc-json-ish" is a format that is not quite proper citeproc-json.
#' passed to `rcrossref::cr_cn`
#' @param cr_style Used in Crossref queries only. A CSL style (for text 
#' format only). See ‘get_styles()’ for options. Default: apa. 
#' passed to `rcrossref::cr_cn`
#' @param cr_locale Used in Crossref queries only. Language locale. 
#' See [Sys.getlocale], passed to `rcrossref::cr_cn`
#' @param ... Curl options passed on to [crul::HttpClient]
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
#' Right now we get JSON citations back. We'd like to support bibtex
#' format. DOI.org supports this but not ORCID.
#'
#' @return data.frame, with the columns:
#' 
#' - put: ORCID PUT code, identifying the work identifier in ORCID's records
#' - id: the external identifier
#' - id_type: the type of external identifier
#' - format: the citation format retrieved
#' - citation: the citation as JSON
#' 
#' @examples \dontrun{
#' (res <- orcid_citations(orcid = "0000-0002-9341-7985"))
#' (res2 <- orcid_citations(orcid = "0000-0002-1642-628X"))
#' (res2 <- orcid_citations(orcid = c("0000-0002-9341-7985", "0000-0002-1642-628X")))
#' 
#' # get individual works
#' ## a single put code
#' (a <- orcid_citations(orcid = "0000-0002-9341-7985", put_code = 5011717))
#' ## many put codes
#' (b <- orcid_citations(orcid = "0000-0002-9341-7985", 
#'    put_code = c(5011717, 15536016)))
#' 
#' # request other formats, Crossref only
#' orcid_citations(orcid = "0000-0002-9341-7985", cr_format = "turtle")
#' 
#' # parse citation data if you wish
#' # for parsing bibtex can use bibtex package or others
#' (res <- orcid_citations(orcid = "0000-0002-9341-7985"))
#' lapply(res[res$format == "csl-json", "citation"][[1]], jsonlite::fromJSON)
#' 
#' # lots of citations
#' orcid_citations(orcid = "0000-0001-8642-6325")
#' 
#' # example with no external identifier, returns NA's
#' orcid_citations(orcid = "0000-0001-8642-6325", 26222265)
#' }
orcid_citations <- function(orcid, put_code = NULL, cr_format = "bibtex", 
  cr_style = "apa", cr_locale = "en-US", ...) {

  if (!is.null(put_code)) {
    if (length(orcid) > 1) {
      stop("if 'put_code' is given, 'orcid' must be length 1")
    }
  }

  tmp <- orcid_works(orcid, put_code)
  
  dat <- if (!is.null(put_code)) {
    list(list(tmp[[1]]$works))
  } else {
    lapply(tmp, function(w) split(w$works, w$works$`put-code`))
  }

  if (length(orcid) > 1) {
    Map(function(a, b) each_orcid(a, b, put_code, cr_format, cr_style, cr_locale), 
      dat, orcid, ...) 
  } else {
    each_orcid(dat[[1]], orcid, put_code, cr_format, cr_style, cr_locale, ...)
  }
}

each_orcid <- function(m, orcid, put_code, cr_format, cr_style, cr_locale, ...) {
  cites <- lapply(m, function(z) {
    # fix for whenevern > 1 put code to make column names more useable
    if (all(grepl("work", names(z)))) {
      names(z) <- gsub("^work\\.", "", names(z))
    }
    pc <- z$`put-code`
    if (!is.null(put_code)) {
      if (length(put_code) == 1) {
        df <- z$`external-ids`$`external-id`[[1]]
        process_cites(df, pc, orcid, cr_format, cr_style, cr_locale, ...)
      } else {
        df <- z$`external-ids`
        Map(process_cites, df, pc, orcid = orcid, cr_format = cr_format, 
          cr_style = cr_style, cr_locale = cr_locale, ...)
      } 
    } else {
      df <- z$`external-ids.external-id`[[1]]
      process_cites(df, pc, orcid, cr_format, cr_style, cr_locale, ...)
    }
  })
  # unnest if no names at top level
  if (is.null(names(cites[[1]])) && length(cites[[1]]) > 1) cites <- unlist(cites, FALSE)
  # combine
  as_dt(cites)
}

process_cites <- function(df, pc, orcid, cr_format, cr_style, cr_locale, ...) {
  if (length(df) == 0) {
    return(list(put = pc, id = NA_character_, id_type = NA_character_, 
      format = NA_character_, citation = ""))
  }
  if ("doi" %in% df$`external-id-type`) {
    id <- df[df$`external-id-type` %in% "doi", "external-id-value"]
    type <- "doi"
    fmat <- cr_format
    ct <- cite_doi(id, cr_format, cr_style, cr_locale, ...) %||% ""
  } else {
    id <- df[df$`external-id-type` %in% "eid", "external-id-value"]
    type <- "eid"
    fmat <- 'csl-json'
    ct <- cite_put(orcid, pc, ...) %||% ""
  }
  list(put = pc, id = id, id_type = type, format = fmat, citation = ct)
}

chkpkg <- function(x) {
  if (!requireNamespace(x, quietly = TRUE)) {
    stop("Please install ", x, call. = FALSE)
  } else {
    invisible(TRUE)
  }
}

cite_doi <- function(x, cr_format = "bibtex", cr_style = "apa", cr_locale = "en-US", ...) {
  chkpkg('rcrossref')
  rcrossref::cr_cn(x, format = cr_format, style = cr_style, locale = cr_locale, raw = TRUE, ...)
}

cite_put <- function(orcid, pc, ...) {
  orcid_prof_helper(orcid, file.path("work", pc), 
    ctype = "application/vnd.citationstyles.csl+json", 
    # ctype = "application/x-bibtex", 
    parse = FALSE, ...)
}
