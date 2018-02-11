rorcid 0.4.0
============

Most changes in this version are to update the package to work with the new ORCID API (`v2.1`). (#37) (#40)

### NEW FEATURES

* `rorcid` now support OAuth authentication. We still recommend to not use OAuth, but to get a token and store that as an environment variable. See `?orcid_auth` for help (#26)
* To work with the new ORCID API, we've introduced new functions: `orcid_activities()`, `orcid_address()`, `orcid_auth()`, `orcid_bio()`, `orcid_educations()`, `orcid_email()`, `orcid_employments()`, `orcid_external_identifiers()`, `orcid_fundings()`, `orcid_keywords()`, `orcid_other_names()`, `orcid_peer_reviews()`, `orcid_person()`, `orcid_ping()`, `orcid_researcher_urls()`, `orcid_works()`
* we've introduced a new packcage import `data.table` for binding lists together into a data.frame

### MINOR IMPROVEMENTS

* Fixes to `identifiers()` for new API. Includes better failure behavior on classes it doesn't support (#34) (#39)
* No changes here other than adding some examples, but ORCID API now allows ot search on some works metadata (e.g., titles) (#33)
* Examples added for searching on specific fields (#36)
* `orcid_id()` changed internally; now wraps the new function `orcid_person()` (#41)
* using Markdown docs now (#35)
* replaced `httr` with `crul` for HTTP requests. we have retained `httr` only to do OAuth (#32)
* `orcid_id()` loses its `profile` parameter due to the ORCID API change. it does pass on parameters to `orcid_person()`, so see that man file
* `works()` now returns a tibble/data.frame instead of a list of items
* A much updated package level man file with lots of docs


rorcid 0.3.0
============

### NEW FEATURES

* Added a vignette (#20)
* `orcid_id()` function gains output for employment and funding (#24) (#29)

### MINOR IMPROVEMENTS

* change all `is()` calls to `inherits()` (#30)
* using `tibble` package now for compact data.frame outputs instead
of internal code. an associated change in the output of both `orcid()`
and `orcid_doi()` is that we now return a tibble (data.frame) instead of
a data.frame as a slot in a list. we add how many results are returned from 
your search as an attribute on the data.frame. Access it like 
`attr(out, "found")` (#25)
* base ORCID API URL changed from `http` to `https` scheme
* genereal improvements to documentation throughout package

### DEPRECATED AND DEFUNCT

* `summary.or_id()` is now defunct. see `?rorcid-defunct`


rorcid 0.2.2
============

### NEW FEATURES

* Require `httr >= v1.1.0` (#23)

### MINOR IMPROVEMENTS

* Updated `dplyr` tidy data.frame internal code (#21)
* Changes to internal use of `httr::content()` to parse to text, then read JSON
manually using `jsonlite` & to always set `encoding` explicitly in the same calls (#22)

### BUG FIXES

* Fix to `as.orcid()` and presumably other function calls by requiring
`httr >= v1.1.0` because older versions cause a problem when parsing
responses (#23) thanks @ericwatt


rorcid 0.2.0
============

### NEW FEATURES

* released to CRAN
