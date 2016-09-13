#' Convert an ORCID or something like an ORCID object
#' 
#' @export 
#' 
#' @param x An ORCID id, passed to \code{print}
#' @param object An ORCID id, passed to \code{summary}
#' @param ... Further args passed on to \code{\link{orcid_id}}
#' 
#' @return an S3 object of class \code{or_cid}, which pretty prints 
#' for brevity
#' 
#' @examples \dontrun{
#' as.orcid(x="0000-0002-1642-628X")
#' out <- orcid("text:English", rows = 20)
#' as.orcid(out$`orcid-identifier.path`[1])
#' 
#' # Passon further args to orcid_id()
#' library("httr")
#' as.orcid("0000-0002-1642-628X", config=verbose())
#' 
#' # Browse to a profile
#' # browse(as.orcid("0000-0002-1642-628X"))
#' 
#' # many ORCIDs as a character vector
#' ids <- c("0000-0002-1642-628X", "0000-0002-9341-7985")
#' as.orcid(ids)
#' 
#' # many in a list via orcid_id()
#' (x <- orcid_id(orcid = ids))
#' as.orcid(x)
#' }
as.orcid <- function(x, ...) {
  UseMethod("as.orcid")
}

#' @export
as.orcid.default <- function(x, ...){
  stop("no 'as.orcid' method for ", class(x), call. = FALSE)
}

#' @export
as.orcid.character <- function(x, ...){
  as.orcid(orcid_id(x, ...))
}

#' @export
as.orcid.or_cid <- function(x, ...) x

#' @export
as.orcid.orcid_id <- function(x, ...) {
  structure(x, class = "or_cid")
}

#' @export
as.orcid.list <- function(x, ...) {
  lapply(x, as.orcid)
}

#' @export
print.or_cid <- function(x, ...){
  ob <- x$`orcid-bio`
  cat(sprintf('<ORCID> %s', x$`orcid-identifier`$path), sep = "\n")
  cat(sprintf('  Name: %s, %s', 
              cn(ob$`personal-details`$`family-name`$value), 
              cn(ob$`personal-details`$`given-names`$value)), sep = "\n")
  cat(sprintf('  URL (first): %s', cn(ob$`researcher-urls`$`researcher-url`$url.value[1])), sep = "\n")
  cat(sprintf('  Country: %s', cn(ob$`contact-details`$address$country$value)), sep = "\n")
  cat(sprintf('  Keywords: %s', paste0(cn(ob$keywords$keyword$value), collapse = ", ") ), sep = "\n")
  cat(sprintf('  Submission date: %s', cn(unixconv(x$`orcid-history`$`submission-date`$value))), sep = "\n")
}

unixconv <- function(y){
  origdig <- getOption("digits")
  on.exit(options(digits = origdig))
  options(digits = 10)
  as.POSIXct(as.numeric(substring(y, 1, 10)), origin = "1970-01-01")
}

cn <- function(x){
  if (is.null(x) || length(x) == 0) {
    ''
  } else {
    x
  }
}

catn <- function(x){
  if (!is.null(x) && length(x) != 0) {
    cat(x, sep = "\n")
  } else {
    NULL
  }
}
