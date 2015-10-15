#' Convert an ORCID or something like an ORCID object
#' 
#' @export 
#' @param x An ORCID id, passed to \code{print}
#' @param object An ORCID id, passed to \code{summary}
#' @param ... Further args passed on to \code{\link{orcid_id}}
#' @examples \dontrun{
#' as.orcid(x="0000-0002-1642-628X")
#' summary(as.orcid(x="0000-0002-1642-628X"))
#' out <- orcid("text:English", rows = 20)
#' as.orcid(out$data$`orcid-identifier.path`[1])
#' 
#' # Passon further args to orcid_id()
#' library("httr")
#' as.orcid("0000-0002-1642-628X", config=verbose())
#' 
#' # Browse to a profile
#' browse(as.orcid("0000-0002-1642-628X"))
#' }
as.orcid <- function(x, ...) UseMethod("as.orcid")

#' @export
#' @rdname as.orcid
as.orcid.character <- function(x, ...){
  structure(orcid_id(x, ...), class = "or_cid")
}

#' @export
#' @rdname as.orcid
as.orcid.or_cid <- function(x, ...) x

#' @export
#' @rdname as.orcid
print.or_cid <- function(x, ...){
  ob <- x[[1]]$`orcid-bio`
  cat(sprintf('<ORCID> %s', names(x)), sep = "\n")
  cat(sprintf('  Name: %s, %s', 
              cn(ob$`personal-details`$`family-name`$value), 
              cn(ob$`personal-details`$`given-names`$value)), sep = "\n")
  cat(sprintf('  URL (first): %s', cn(ob$`researcher-urls`$`researcher-url`$url.value[1])), sep = "\n")
  cat(sprintf('  Country: %s', cn(ob$`contact-details`$address$country$value)), sep = "\n")
  cat(sprintf('  Keywords: %s', paste0(cn(ob$keywords$keyword$value), collapse = ", ") ), sep = "\n")
  cat(sprintf('  Submission date: %s', cn(unixconv(x[[1]]$`orcid-history`$`submission-date`$value))), sep = "\n")
}

#' @export
#' @rdname as.orcid
summary.or_cid <- function(object, ...){
  ob <- object[[1]]$`orcid-bio`
  cat(sprintf('<ORCID Summary> %s', names(object)), sep = "\n")
  cat(sprintf('  Name: %s, %s', 
              cn(ob$`personal-details`$`family-name`$value), 
              cn(ob$`personal-details`$`given-names`$value)), sep = "\n")
  cat('  URLs:', sep = "\n")
  for (i in seq_along(apply(ob$`researcher-urls`$`researcher-url`, 1, as.list))) {
    cat(sprintf('     %s: %s', 
                cn(ob$`researcher-urls`$`researcher-url`[i,'url-name.value']),
                cn(ob$`researcher-urls`$`researcher-url`[i,'url.value'])), sep = "\n")
  }
  catn(sprintf('  Country: %s', cn(ob$`contact-details`$address$country$value)))
  catn(sprintf('  Keywords: %s', paste0(cn(ob$keywords$keyword$value), collapse = ", ") ))
  catn(sprintf('  Submission date: %s', cn(unixconv(ob[[1]]$`orcid-history`$`submission-date`$value))))
  cat('  Works:')
  cat(strwrap(works(object)$data$`work-title.title.value`, indent = 8, prefix = "\n"))
}

unixconv <- function(y){
  origdig <- getOption("digits")
  on.exit(options(digits = origdig))
  options(digits = 10)
  as.POSIXct(as.numeric(substring(y, 1, 10)), origin = "1970-01-01")
}

cn <- function(x){
  if (is.null(x) || length(x) == 0) {
    NULL
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
