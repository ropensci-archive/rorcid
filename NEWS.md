rorcid 0.4.0
============

Most changes in this version are to update the package to work with the new ORCID API (`v2.1`). 

### NEW FEATURES

* xxx (#xx)
* xxx (#xx)
* xxx (#xx)

### MINOR IMPROVEMENTS

* Fixes to `identifiers` (#34)
* xxx (#xx)
* xxx (#xx)

## BUG FIXES

* xxx (#xx)
* xxx (#xx)
* xxx (#xx)


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
