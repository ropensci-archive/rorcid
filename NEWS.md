rorcid 0.2.2
===============

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
===============

### NEW FEATURES

* released to CRAN
