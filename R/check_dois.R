#' Verify DOI's are likely good
#' @export
#' @param x One or more DOIs
#' @return A list of length two, one slot for good DOIs, one for bad
#' @examples \dontrun{
#' check_dois("10.1087/20120404")
#' 
#' dois=c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
#'        "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
#' check_dois(dois)
#' 
#' dois=c("10.1016/j.medpal.2008.12.005","10.1080/00933104.2000.10505926","10.1037/a0024480",
#'        "10.1002/anie.196603172","2344","asdf","232","asdf","23dd")
#' check_dois(dois)
#' }
check_dois <- function(x){
  doi_pattern <- "\\b(10[.][0-9]{4,}(?:[.][0-9]+)*/(?:(?![\"&\'<>])\\S)+)\\b"
  check <- sapply(x, function(y) grepl(doi_pattern, y, perl=TRUE))
  list(good = good(x, check), bad = bad(x, check))
}

good <- function(x, check){
  tmp <- x[check]
  if(length(tmp) == 0)
    NULL
  else
    tmp
}

bad <- function(x, check){
  tmp <- x[!check]
  if(length(tmp) == 0)
    NULL
  else
    tmp
}

bad_dois <- function(x){
  doi_pattern <- "\\b(10[.][0-9]{4,}(?:[.][0-9]+)*/(?:(?![\"&\'<>])\\S)+)\\b"
  check <- sapply(x, function(y) grepl(doi_pattern, y, perl=TRUE))
  if(!all(check)){
    stop(paste("The following are not DOIs:\n", paste(x[!check],collapse="\n ")), call. = FALSE)
  }
}
