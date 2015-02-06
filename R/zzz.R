ocom <- function (l) Filter(Negate(is.null), l)

orcid_base <- function() "http://pub.orcid.org/v1.1"

orc_GET <- function(url, args=list(), ...){
  tt <- GET(url, query=args, accept('application/orcid+json'), ...)
  stop_for_status(tt)
  content(tt, "text")
}
