# set up vcr
library("vcr")
invisible(vcr::vcr_configure(
    dir = "../fixtures",
    filter_sensitive_data = list("<<rorcid_bearer_token>>" = Sys.getenv('ORCID_TOKEN'))
))
