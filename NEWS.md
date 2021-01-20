rorcid 0.6.4
============

### MINOR IMPROVEMENTS

* removed `recursive` parameter in `orcid()` function as it wasn't used internally (#65)
* fix doc title for `orcid_external_identifiers()` (#81)
* in `orcid_search()` removed parameters `current_prim_inst` and `patent_number` as those have been removed from ORCID; added additional fields to query on in the `orcid()` function: `peer-review-type`, `peer-review-role`, `peer-review-group-id`, `biography`, and `external-id-type-and-value` (#82)

### BUG FIXES 

* remove unused param definition for `...` in `works()` - via R-devel checks  (#84)


rorcid 0.6.0
============

### NEW FEATURES

* `orcid_citations()` gains new internal function `extract_bibtex` to attempt to better parse bibtex (#74) thanks @RLumSK
* `orcid_search()` gains new parameter `affiliation_org` to search by affiliation organization name, and parses `affiliation_org` output (#75)
* `orcid_search()` gains new parameters `ringgold_org_id` and `grid_org_id`, as well as parsing those outputs if present (#76)

### MINOR IMPROVEMENTS

* clarify names of variables to store the ORCID API token (#71) thanks @fmichonneau
* dont run tests if ORCID token not found (#79)

### BUG FIXES 

* fix to `orcid_search()`: parsing issues were fixed by giving default NA's when no results found for certain result sections (#72)
* tests now using cached requests/responses via vcr (#73)
* `orcid_search()` fix: `orcid-identifier.path` was not returned when no results found; now we check for that in the results, and return an empty tibble if not found (#75)
* in `orcid_search()`, keywords have to be passed as multiple instances of `keyword` rather than as `keywords`; fixed now; user facing still just uses `keywords` as the input param (#77)

rorcid 0.5.2
============

### DEPLOYMENT

* Switched from using TravisCI and Appveyor to using only GitHub Actions for
  _R_.

rorcid 0.5.0
============

`rorcid` now works with the v3 ORCID API (#63) (#68) (#70)

### NEW FEATURES

* with ORCID v3 API, new functions added: `orcid_distinctions()`, `orcid_invited_positions()`, `orcid_memberships()`, `orcid_qualifications()`, `orcid_research_resources()`, and `orcid_services()`
* gains new fxn `orcid_citations()` for getting citations for an ORCID ID in user specified formats - leverages `rcrossref` and `handlr` packages (#51) (#69)
* new function added `orcid_search()`, a wrapper around `orcid()` function as an easier interface than `orcid()` - see ropensci/codemetar issue 83 for discussion (#54)
* requires R 3.5 or greater

### MINOR IMPROVEMENTS

* dataset added to the package `issn_title`, a named vector, with values as journal names and names as their ISSN values (sourced from Crossref). see `?orcid_peer_reviews` examples for an example of using the dataset to gather journal titles from jorunal ISSN's (#52)
* added documentation on ORCID authentication to README (#60) thanks @maelle
* use `fauxpas::find_error_class` method instead of internal hack (#61)
* Added more examples to the vignette (#56) thanks @bomeara
* fix many typos (#59) thanks @maelle 
* add section to `?orcid_auth` documentation about "Computing evironments without browsers" - you can't do OAuth flow in a non-interactive session (#55) thanks @pkraker for the find
* changes for `orcid_works()`: `put_code` parameter now accepts up to 50 put codes; significant changes internally to make it easier to combine results into a data.frame  (#44) thanks @gorkang

### BUG FIXES 

* `httpuv` package added to Suggests and used inside only the `orcid_auth()` function when doing the OAuth flow because out of band (OOB) OAuth doesn't work without httpuv (#67) thanks @ciakovx for finding that
* fix to `identifiers()` function - was failing on results that gave zero length lists (#40) thanks @agbarnett


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
