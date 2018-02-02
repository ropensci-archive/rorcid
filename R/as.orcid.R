#' Convert an ORCID or something like an ORCID object
#' 
#' @export 
#' 
#' @param x An ORCID id, passed to `print`
#' @param ... Further args passed on to [orcid_id()]
#' 
#' @return an S3 object of class `or_cid`, which pretty prints 
#' for brevity
#' 
#' @examples \dontrun{
#' as.orcid(x="0000-0002-1642-628X")
#' out <- orcid("text:English", rows = 20)
#' as.orcid(out$`orcid-identifier.path`[1])
#' 
#' # Passon further args to orcid_id()
#' as.orcid("0000-0002-1642-628X", verbose = TRUE)
#' 
#' # Browse to a profile
#' # browse(as.orcid("0000-0002-1642-628X"))
#' 
#' # many ORCIDs as a character vector
#' ids <- c("0000-0002-1642-628X", "0000-0002-9341-7985")
#' as.orcid(ids)
#' 
#' # many in a list via orcid_id()
#' (x <- lapply(ids, orcid_id))
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
  if (length(x) > 1) return(lapply(x, function(z) as.orcid(orcid_id(z, ...))))
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
  ob <- x[[1]]
  cat(sprintf('<ORCID> %s', ob$name$path), sep = "\n")
  cat(sprintf('  Name: %s, %s', 
              cn(ob$name$`family-name`$value), 
              cn(ob$name$`given-names`$value)), sep = "\n")
  cat(sprintf('  URL (first): %s', 
              cn(ob$`researcher-urls`$`researcher-url`$url.value[1])), 
      sep = "\n")
  cat(sprintf('  Country: %s', 
              cn(ob$addresses$address$country)), sep = "\n")
  cat(sprintf('  Keywords: %s', paste0(cn(ob$keywords$keyword$content), 
                                       collapse = ", ") ), sep = "\n")
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
