# don't run tests is token not set
if ( 
  identical(Sys.getenv("NOT_CRAN"), "true") &&
  Sys.getenv("ORCID_TOKEN", "") == ""
) {
  stop("set an ORCID_TOKEN env var before running tests", 
    call. = FALSE)
}

# set up vcr
library("vcr")
invisible(vcr::vcr_configure(
  dir = "../fixtures",
  filter_sensitive_data =
    list("<<rorcid_bearer_token>>" = Sys.getenv('ORCID_TOKEN'))
))
