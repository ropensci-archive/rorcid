# set up vcr
library("vcr")
invisible(vcr::vcr_configure(
    dir = "../fixtures",
    filter_sensitive_data = list("<<rorcid_bearer_token>>" = Sys.getenv('ORCID_TOKEN'))
))

has_internet <- function() {
  z <- try(suppressWarnings(readLines('https://www.google.com', n = 1)), 
    silent = TRUE)
  !inherits(z, "try-error")
}

skip_if_net_down <- function() {
  if (has_internet()) {
    return()
  }
  testthat::skip("no internet")
}
