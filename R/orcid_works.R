#' Get works for a person
#'
#' @export
#' @param orcid (character) Orcid identifier(s), of the form 
#' XXXX-XXXX-XXXX-XXXX. required.
#' @param put_code (character/integer) one or more put codes. optional
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
#' res$`0000-0002-9341-7985`$group
#' res$`0000-0002-9341-7985`$group$`work-summary`
#' res$`0000-0002-9341-7985`$group$`work-summary`[[1]]
#' str(res$`0000-0002-9341-7985`$group$`work-summary`[[1]])
#' 
#' # get individual works
#' orcid_works(orcid = "0000-0002-9341-7985", 5011717)
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
#' vapply(x[[1]]$group$`work-summary`, function(z) {
#'   orcid_works(id, put_code = z$`put-code`)[[1]]$citation$`citation-value`
#'   }, "")
#' }
orcid_works <- function(orcid, put_code = NULL, format = "application/json", 
  ...) {

  if (!is.null(put_code)) {
    if (length(orcid) > 1) {
      stop("if 'put_code' is given, 'orcid' must be length 1")
    }
  }
  pth <- if (is.null(put_code)) "works" else file.path("work", put_code)
  if (length(pth) > 1) {
    stats::setNames(
      Map(function(z) orcid_prof_helper(orcid, z, ctype = format), pth), 
      put_code)
  } else {
    nmd <- if (!is.null(put_code)) put_code else orcid
    stats::setNames(
      lapply(orcid, orcid_prof_helper, path = pth, ctype = format, ...), nmd)
  }
}
