rorcid
======



[![Build Status](https://api.travis-ci.org/ropensci/rorcid.png)](https://travis-ci.org/ropensci/rorcid)
[![Build status](https://ci.appveyor.com/api/projects/status/29hanha8jfe4uen8/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/rorcid/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/rorcid/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rorcid?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rorcid?color=2ED968)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rorcid)](https://cran.r-project.org/package=rorcid)

`rorcid` is an R programmatic interface to the Orcid public API. `rorcid` is not a product developed or distributed by ORCID®.

Orcid API docs:

* Public API docs: <http://members.orcid.org/api>
* Full API reference: <https://github.com/ORCID/ORCID-Source/wiki/full-api-reference>

## Installation

Stable version


```r
install.packages("rorcid")
```

Development version


```r
install.packages("devtools")
devtools::install_github("ropensci/rorcid")
```


```r
library('rorcid')
```

## The Orcid class

There's a function `as.orcid()` in this package to help coerce an Orcid ID to an object that holds details for that Orcid ID, prints a nice summary, and you can browse easily to that profile. E.g.


```r
as.orcid(x = "0000-0002-1642-628X")
#> $`0000-0002-1642-628X`
#> <ORCID> 0000-0002-1642-628X
#>   Name: Boettiger, Carl
#>   URL (first): 
#>   Country: US
#>   Keywords: Ecology, Evolution, Regime Shifts, Stochastic Dynamics
#>   Submission date: 2012-11-01 17:57:23
```

Or you can pass in many IDs


```r
as.orcid(c("0000-0003-1620-1408", "0000-0002-9341-7985"))
#> $`0000-0003-1620-1408`
#> <ORCID> 0000-0003-1620-1408
#>   Name: Johnson, Thomas
#>   URL (first): 
#>   Country: US
#>   Keywords: 
#>   Submission date: 2012-10-27 10:33:31
#> 
#> $`0000-0002-9341-7985`
#> <ORCID> 0000-0002-9341-7985
#>   Name: Binfield, Peter
#>   URL (first): 
#>   Country: US
#>   Keywords: 
#>   Submission date: 2012-10-16 04:39:18
```

The `browse()` function lets you browser to a profile easily with a single function call


```r
browse(as.orcid("0000-0002-1642-628X"))
```

![profile](http://f.cl.ly/items/3d1o0k1X3R1U110C0u1u/Screen%20Shot%202015-02-10%20at%207.21.57%20PM.png)

## Get works

The `works()` function helps get works data from an orcid data object. The output of `works()` uses a print method to just print citations for each work.


```r
(out <- works(orcid_id("0000-0002-0233-1757")))
#> <WORKS> 0000-0002-0233-1757
#>   Count: 6 - First 10
#> - Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite
#> - METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE
#> - Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host
#> - Presubmission Inquiry for PLOS Biology article on rOpenSci (PBIOLOGY-S-12-05379)
#> - git can facilitate greater reproducibility and increased transparency in science
#> - git repository for paper on git and reproducible science
```

And you can easily get to the entire data.frame of works details


```r
out$data
#> # A tibble: 6 × 30
#>   `put-code` `journal-title` `short-description`     `work-type`
#> *      <chr>           <lgl>               <lgl>           <chr>
#> 1    5296064              NA                  NA JOURNAL_ARTICLE
#> 2    5296065              NA                  NA JOURNAL_ARTICLE
#> 3    5296066              NA                  NA JOURNAL_ARTICLE
#> 4    9012984              NA                  NA JOURNAL_ARTICLE
#> 5    9012985              NA                  NA JOURNAL_ARTICLE
#> 6    9012986              NA                  NA JOURNAL_ARTICLE
#> # ... with 26 more variables: `work-source` <lgl>, `language-code` <lgl>,
#> #   country <lgl>, visibility <chr>, `work-title.subtitle` <lgl>,
#> #   `work-title.translated-title` <lgl>, `work-title.title.value` <chr>,
#> #   `work-citation.work-citation-type` <chr>,
#> #   `work-citation.citation` <chr>, `publication-date.media-type` <lgl>,
#> #   `publication-date.year.value` <chr>,
#> #   `publication-date.month.value` <chr>,
#> #   `publication-date.day.value` <chr>,
#> #   `work-external-identifiers.work-external-identifier` <list>,
#> #   `work-external-identifiers.scope` <lgl>, url.value <chr>,
#> #   `work-contributors.contributor` <list>,
#> #   `source.source-client-id` <lgl>, `source.source-orcid.value` <lgl>,
#> #   `source.source-orcid.uri` <chr>, `source.source-orcid.path` <chr>,
#> #   `source.source-orcid.host` <chr>, `source.source-name.value` <chr>,
#> #   `source.source-date.value` <dbl>, `created-date.value` <dbl>,
#> #   `last-modified-date.value` <dbl>
```

## Search Orcid

Get a list of names and Orcid IDs matching a name query


```r
orcid(query = "carl boettiger")
#> # A tibble: 10 × 36
#>    `relevancy-score.value` orcid `orcid-id` `orcid-deprecated`
#> *                    <dbl> <lgl>      <lgl>              <lgl>
#> 1                0.7664902    NA         NA                 NA
#> 2                0.6471822    NA         NA                 NA
#> 3                0.5177457    NA         NA                 NA
#> 4                0.3637124    NA         NA                 NA
#> 5                0.3600570    NA         NA                 NA
#> 6                0.3146512    NA         NA                 NA
#> 7                0.3146512    NA         NA                 NA
#> 8                0.3146512    NA         NA                 NA
#> 9                0.3146512    NA         NA                 NA
#> 10               0.3146512    NA         NA                 NA
#> # ... with 32 more variables: `orcid-preferences` <lgl>,
#> #   `orcid-history` <lgl>, `orcid-activities` <lgl>,
#> #   `orcid-internal` <lgl>, type <lgl>, `group-type` <lgl>,
#> #   `client-type` <lgl>, `orcid-identifier.value` <lgl>,
#> #   `orcid-identifier.uri` <chr>, `orcid-identifier.path` <chr>,
#> #   `orcid-identifier.host` <chr>, delegation <lgl>, scope <lgl>,
#> #   `personal-details.given-names.value` <chr>,
#> #   `personal-details.given-names.visibility` <chr>,
#> #   `personal-details.family-name.value` <chr>,
#> #   `personal-details.family-name.visibility` <chr>,
#> #   `personal-details.credit-name.value` <chr>,
#> #   `personal-details.credit-name.visibility` <chr>,
#> #   `personal-details.other-names.other-name` <list>,
#> #   `personal-details.other-names.visibility` <chr>,
#> #   biography.value <chr>, biography.visibility <chr>,
#> #   `researcher-urls.researcher-url` <list>,
#> #   `researcher-urls.visibility` <chr>, `contact-details.email` <list>,
#> #   `contact-details.address.country.value` <chr>,
#> #   `contact-details.address.country.visibility` <chr>,
#> #   keywords.keyword <list>, keywords.visibility <chr>,
#> #   `external-identifiers.external-identifier` <list>,
#> #   `external-identifiers.visibility` <chr>
```

You can string together many search terms


```r
orcid(query = "johnson cardiology houston")
#> # A tibble: 10 × 34
#>    `relevancy-score.value` orcid `orcid-id` `orcid-deprecated`
#> *                    <dbl> <lgl>      <lgl>              <lgl>
#> 1                0.4292993    NA         NA                 NA
#> 2                0.4078736    NA         NA                 NA
#> 3                0.3646636    NA         NA                 NA
#> 4                0.3592525    NA         NA                 NA
#> 5                0.3591200    NA         NA                 NA
#> 6                0.3260067    NA         NA                 NA
#> 7                0.3105809    NA         NA                 NA
#> 8                0.3078171    NA         NA                 NA
#> 9                0.3078171    NA         NA                 NA
#> 10               0.3078171    NA         NA                 NA
#> # ... with 30 more variables: `orcid-preferences` <lgl>,
#> #   `orcid-history` <lgl>, `orcid-activities` <lgl>,
#> #   `orcid-internal` <lgl>, type <lgl>, `group-type` <lgl>,
#> #   `client-type` <lgl>, `orcid-identifier.value` <lgl>,
#> #   `orcid-identifier.uri` <chr>, `orcid-identifier.path` <chr>,
#> #   `orcid-identifier.host` <chr>, `external-identifiers` <lgl>,
#> #   delegation <lgl>, scope <lgl>, `personal-details.credit-name` <lgl>,
#> #   `personal-details.given-names.value` <chr>,
#> #   `personal-details.given-names.visibility` <chr>,
#> #   `personal-details.family-name.value` <chr>,
#> #   `personal-details.family-name.visibility` <chr>,
#> #   `personal-details.other-names.other-name` <list>,
#> #   `personal-details.other-names.visibility` <chr>,
#> #   biography.value <chr>, biography.visibility <chr>,
#> #   `researcher-urls.researcher-url` <list>,
#> #   `researcher-urls.visibility` <chr>, `contact-details.email` <list>,
#> #   `contact-details.address.country.value` <chr>,
#> #   `contact-details.address.country.visibility` <chr>,
#> #   keywords.keyword <list>, keywords.visibility <chr>
```

And use boolean operators


```r
orcid("johnson AND(caltech OR 'California Institute of Technology')")
#> # A tibble: 10 × 35
#>    `relevancy-score.value` orcid `orcid-id` `orcid-deprecated`
#> *                    <dbl> <lgl>      <lgl>              <lgl>
#> 1                0.5884975    NA         NA                 NA
#> 2                0.4010760    NA         NA                 NA
#> 3                0.3629876    NA         NA                 NA
#> 4                0.3551019    NA         NA                 NA
#> 5                0.3551019    NA         NA                 NA
#> 6                0.3551019    NA         NA                 NA
#> 7                0.3489844    NA         NA                 NA
#> 8                0.3334039    NA         NA                 NA
#> 9                0.3319200    NA         NA                 NA
#> 10               0.3319200    NA         NA                 NA
#> # ... with 31 more variables: `orcid-preferences` <lgl>,
#> #   `orcid-history` <lgl>, `orcid-activities` <lgl>,
#> #   `orcid-internal` <lgl>, type <lgl>, `group-type` <lgl>,
#> #   `client-type` <lgl>, `orcid-identifier.value` <lgl>,
#> #   `orcid-identifier.uri` <chr>, `orcid-identifier.path` <chr>,
#> #   `orcid-identifier.host` <chr>, `external-identifiers` <lgl>,
#> #   delegation <lgl>, scope <lgl>,
#> #   `personal-details.given-names.value` <chr>,
#> #   `personal-details.given-names.visibility` <chr>,
#> #   `personal-details.family-name.value` <chr>,
#> #   `personal-details.family-name.visibility` <chr>,
#> #   `personal-details.credit-name.value` <chr>,
#> #   `personal-details.credit-name.visibility` <chr>,
#> #   `personal-details.other-names.other-name` <list>,
#> #   `personal-details.other-names.visibility` <chr>,
#> #   biography.value <chr>, biography.visibility <chr>,
#> #   `researcher-urls.researcher-url` <list>,
#> #   `researcher-urls.visibility` <chr>, `contact-details.email` <list>,
#> #   `contact-details.address.country.value` <chr>,
#> #   `contact-details.address.country.visibility` <chr>,
#> #   keywords.keyword <list>, keywords.visibility <chr>
```

And you can use start and rows arguments to do pagination


```r
orcid("johnson cardiology houston", start = 2, rows = 3)
#> # A tibble: 3 × 28
#>   `relevancy-score.value` orcid `orcid-id` `orcid-deprecated`
#> *                   <dbl> <lgl>      <lgl>              <lgl>
#> 1               0.3646636    NA         NA                 NA
#> 2               0.3592525    NA         NA                 NA
#> 3               0.3591200    NA         NA                 NA
#> # ... with 24 more variables: `orcid-preferences` <lgl>,
#> #   `orcid-history` <lgl>, `orcid-activities` <lgl>,
#> #   `orcid-internal` <lgl>, type <lgl>, `group-type` <lgl>,
#> #   `client-type` <lgl>, `orcid-identifier.value` <lgl>,
#> #   `orcid-identifier.uri` <chr>, `orcid-identifier.path` <chr>,
#> #   `orcid-identifier.host` <chr>, biography <lgl>,
#> #   `researcher-urls` <lgl>, `contact-details` <lgl>, keywords <lgl>,
#> #   `external-identifiers` <lgl>, delegation <lgl>, scope <lgl>,
#> #   `personal-details.credit-name` <lgl>,
#> #   `personal-details.other-names` <lgl>,
#> #   `personal-details.given-names.value` <chr>,
#> #   `personal-details.given-names.visibility` <chr>,
#> #   `personal-details.family-name.value` <chr>,
#> #   `personal-details.family-name.visibility` <chr>
```

Search specific fields. here, by text type


```r
orcid("text:English")
#> # A tibble: 10 × 35
#>    `relevancy-score.value` orcid `orcid-id` `orcid-deprecated`
#> *                    <dbl> <lgl>      <lgl>              <lgl>
#> 1                1.2265395    NA         NA                 NA
#> 2                0.9508344    NA         NA                 NA
#> 3                0.8929747    NA         NA                 NA
#> 4                0.8068097    NA         NA                 NA
#> 5                0.7955252    NA         NA                 NA
#> 6                0.7606675    NA         NA                 NA
#> 7                0.7606675    NA         NA                 NA
#> 8                0.7365131    NA         NA                 NA
#> 9                0.7365131    NA         NA                 NA
#> 10               0.7365131    NA         NA                 NA
#> # ... with 31 more variables: `orcid-preferences` <lgl>,
#> #   `orcid-history` <lgl>, `orcid-activities` <lgl>,
#> #   `orcid-internal` <lgl>, type <lgl>, `group-type` <lgl>,
#> #   `client-type` <lgl>, `orcid-identifier.value` <lgl>,
#> #   `orcid-identifier.uri` <chr>, `orcid-identifier.path` <chr>,
#> #   `orcid-identifier.host` <chr>, `external-identifiers` <lgl>,
#> #   delegation <lgl>, scope <lgl>,
#> #   `personal-details.given-names.value` <chr>,
#> #   `personal-details.given-names.visibility` <chr>,
#> #   `personal-details.family-name.value` <chr>,
#> #   `personal-details.family-name.visibility` <chr>,
#> #   `personal-details.credit-name.value` <chr>,
#> #   `personal-details.credit-name.visibility` <chr>,
#> #   `personal-details.other-names.other-name` <list>,
#> #   `personal-details.other-names.visibility` <chr>,
#> #   biography.value <chr>, biography.visibility <chr>,
#> #   `researcher-urls.researcher-url` <list>,
#> #   `researcher-urls.visibility` <chr>, `contact-details.email` <list>,
#> #   `contact-details.address.country.value` <chr>,
#> #   `contact-details.address.country.visibility` <chr>,
#> #   keywords.keyword <list>, keywords.visibility <chr>
```

## Search by Orcid ID


```r
out <- orcid_id(orcid = "0000-0002-9341-7985")
out$`0000-0002-9341-7985`$`orcid-identifier`
#> $value
#> NULL
#> 
#> $uri
#> [1] "http://orcid.org/0000-0002-9341-7985"
#> 
#> $path
#> [1] "0000-0002-9341-7985"
#> 
#> $host
#> [1] "orcid.org"
```

Get specific thing, either bibliographic ("bio"), biographical ("works"), profile ("profile"), or record ("record")


```r
out <- orcid_id(orcid = "0000-0002-9341-7985", profile = "works")
out$`0000-0002-9341-7985`$`orcid-history`
#> $`creation-method`
#> [1] "WEBSITE"
#> 
#> $`completion-date`
#> $`completion-date`$value
#> [1] 1.350393e+12
#> 
#> 
#> $`submission-date`
#> $`submission-date`$value
#> [1] 1.350388e+12
#> 
#> 
#> $`last-modified-date`
#> $`last-modified-date`$value
#> [1] 1.465944e+12
#> 
#> 
#> $claimed
#> $claimed$value
#> [1] TRUE
#> 
#> 
#> $source
#> NULL
#> 
#> $`deactivation-date`
#> NULL
#> 
#> $`verified-email`
#> $`verified-email`$value
#> [1] TRUE
#> 
#> 
#> $`verified-primary-email`
#> $`verified-primary-email`$value
#> [1] TRUE
#> 
#> 
#> $visibility
#> NULL
```

The function is vectorized, so you can pass in many Orcids


```r
ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
lapply(orcid_id(orcid = ids), "[[", "orcid-identifier")
#> $`0000-0003-1620-1408`
#> $`0000-0003-1620-1408`$value
#> NULL
#> 
#> $`0000-0003-1620-1408`$uri
#> [1] "http://orcid.org/0000-0003-1620-1408"
#> 
#> $`0000-0003-1620-1408`$path
#> [1] "0000-0003-1620-1408"
#> 
#> $`0000-0003-1620-1408`$host
#> [1] "orcid.org"
#> 
#> 
#> $`0000-0002-9341-7985`
#> $`0000-0002-9341-7985`$value
#> NULL
#> 
#> $`0000-0002-9341-7985`$uri
#> [1] "http://orcid.org/0000-0002-9341-7985"
#> 
#> $`0000-0002-9341-7985`$path
#> [1] "0000-0002-9341-7985"
#> 
#> $`0000-0002-9341-7985`$host
#> [1] "orcid.org"
```

## Search by DOIs

There is a helper function `check_dois()` that uses a regex checker to see if your DOIs are likely good or likely bad:

All good DOIs


```r
dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
       "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
check_dois(dois)
#> $good
#> [1] "10.1371/journal.pone.0025995" "10.1371/journal.pone.0053712"
#> [3] "10.1371/journal.pone.0054608" "10.1371/journal.pone.0055937"
#> 
#> $bad
#> NULL
```

Some good, some bad


```r
dois <- c("10.1016/j.medpal.2008.12.005","10.1080/00933104.2000.10505926","10.1037/a0024480",
        "10.1002/anie.196603172","2344","asdf","232","asdf","23dd")
check_dois(dois)
#> $good
#> [1] "10.1016/j.medpal.2008.12.005"   "10.1080/00933104.2000.10505926"
#> [3] "10.1037/a0024480"               "10.1002/anie.196603172"        
#> 
#> $bad
#> [1] "2344" "asdf" "232"  "asdf" "23dd"
```

Basic search


```r
orcid_doi(dois = "10.1087/20120404")
#> [[1]]
#> # A tibble: 8 × 36
#>   `relevancy-score.value` orcid `orcid-id` `orcid-deprecated`
#> *                   <dbl> <lgl>      <lgl>              <lgl>
#> 1              14.6023350    NA         NA                 NA
#> 2               8.2603270    NA         NA                 NA
#> 3               8.2603270    NA         NA                 NA
#> 4               7.2277865    NA         NA                 NA
#> 5               6.3229960    NA         NA                 NA
#> 6               5.0583970    NA         NA                 NA
#> 7               2.0650818    NA         NA                 NA
#> 8               0.9126459    NA         NA                 NA
#> # ... with 32 more variables: `orcid-preferences` <lgl>,
#> #   `orcid-history` <lgl>, `orcid-activities` <lgl>,
#> #   `orcid-internal` <lgl>, type <lgl>, `group-type` <lgl>,
#> #   `client-type` <lgl>, `orcid-identifier.value` <lgl>,
#> #   `orcid-identifier.uri` <chr>, `orcid-identifier.path` <chr>,
#> #   `orcid-identifier.host` <chr>, delegation <lgl>, scope <lgl>,
#> #   `personal-details.given-names.value` <chr>,
#> #   `personal-details.given-names.visibility` <chr>,
#> #   `personal-details.family-name.value` <chr>,
#> #   `personal-details.family-name.visibility` <chr>,
#> #   `personal-details.credit-name.value` <chr>,
#> #   `personal-details.credit-name.visibility` <chr>,
#> #   `personal-details.other-names.other-name` <list>,
#> #   `personal-details.other-names.visibility` <chr>,
#> #   biography.value <chr>, biography.visibility <chr>,
#> #   `researcher-urls.researcher-url` <list>,
#> #   `researcher-urls.visibility` <chr>, `contact-details.email` <list>,
#> #   `contact-details.address.country.value` <chr>,
#> #   `contact-details.address.country.visibility` <chr>,
#> #   keywords.keyword <list>, keywords.visibility <chr>,
#> #   `external-identifiers.external-identifier` <list>,
#> #   `external-identifiers.visibility` <chr>
#> 
#> attr(,"class")
#> [1] "orcid_doi"
```

This DOI is not a real one, but a partial DOI, then we can fuzzy search


```r
orcid_doi(dois = "10.1087/2", fuzzy = TRUE, rows = 5)
#> [[1]]
#> # A tibble: 5 × 34
#>   `relevancy-score.value` orcid `orcid-id` `orcid-deprecated`
#> *                   <dbl> <lgl>      <lgl>              <lgl>
#> 1               0.9109946    NA         NA                 NA
#> 2               0.7971203    NA         NA                 NA
#> 3               0.7585498    NA         NA                 NA
#> 4               0.7205114    NA         NA                 NA
#> 5               0.6944009    NA         NA                 NA
#> # ... with 30 more variables: `orcid-preferences` <lgl>,
#> #   `orcid-history` <lgl>, `orcid-activities` <lgl>,
#> #   `orcid-internal` <lgl>, type <lgl>, `group-type` <lgl>,
#> #   `client-type` <lgl>, `orcid-identifier.value` <lgl>,
#> #   `orcid-identifier.uri` <chr>, `orcid-identifier.path` <chr>,
#> #   `orcid-identifier.host` <chr>, biography <lgl>,
#> #   `external-identifiers` <lgl>, delegation <lgl>, scope <lgl>,
#> #   `personal-details.given-names.value` <chr>,
#> #   `personal-details.given-names.visibility` <chr>,
#> #   `personal-details.family-name.value` <chr>,
#> #   `personal-details.family-name.visibility` <chr>,
#> #   `personal-details.credit-name.value` <chr>,
#> #   `personal-details.credit-name.visibility` <chr>,
#> #   `personal-details.other-names.other-name` <list>,
#> #   `personal-details.other-names.visibility` <chr>,
#> #   `researcher-urls.researcher-url` <list>,
#> #   `researcher-urls.visibility` <chr>, `contact-details.email` <list>,
#> #   `contact-details.address.country.value` <chr>,
#> #   `contact-details.address.country.visibility` <chr>,
#> #   keywords.keyword <list>, keywords.visibility <chr>
#> 
#> attr(,"class")
#> [1] "orcid_doi"
```

Function is vectorized, search for many DOIs


```r
dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
       "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
res <- orcid_doi(dois = dois, fuzzy = TRUE)
res[[1]]
#> # A tibble: 10 × 34
#>    `relevancy-score.value` orcid `orcid-id` `orcid-deprecated`
#> *                    <dbl> <lgl>      <lgl>              <lgl>
#> 1                0.2332562    NA         NA                 NA
#> 2                0.1862045    NA         NA                 NA
#> 3                0.1645832    NA         NA                 NA
#> 4                0.1612579    NA         NA                 NA
#> 5                0.1612579    NA         NA                 NA
#> 6                0.1612579    NA         NA                 NA
#> 7                0.1612579    NA         NA                 NA
#> 8                0.1612579    NA         NA                 NA
#> 9                0.1612579    NA         NA                 NA
#> 10               0.1612579    NA         NA                 NA
#> # ... with 30 more variables: `orcid-preferences` <lgl>,
#> #   `orcid-history` <lgl>, `orcid-activities` <lgl>,
#> #   `orcid-internal` <lgl>, type <lgl>, `group-type` <lgl>,
#> #   `client-type` <lgl>, `orcid-identifier.value` <lgl>,
#> #   `orcid-identifier.uri` <chr>, `orcid-identifier.path` <chr>,
#> #   `orcid-identifier.host` <chr>, biography <lgl>, keywords <lgl>,
#> #   delegation <lgl>, scope <lgl>,
#> #   `personal-details.given-names.value` <chr>,
#> #   `personal-details.given-names.visibility` <chr>,
#> #   `personal-details.family-name.value` <chr>,
#> #   `personal-details.family-name.visibility` <chr>,
#> #   `personal-details.credit-name.value` <chr>,
#> #   `personal-details.credit-name.visibility` <chr>,
#> #   `personal-details.other-names.other-name` <list>,
#> #   `personal-details.other-names.visibility` <chr>,
#> #   `researcher-urls.researcher-url` <list>,
#> #   `researcher-urls.visibility` <chr>, `contact-details.email` <list>,
#> #   `contact-details.address.country.value` <chr>,
#> #   `contact-details.address.country.visibility` <chr>,
#> #   `external-identifiers.external-identifier` <list>,
#> #   `external-identifiers.visibility` <chr>
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rorcid/issues)
* License: MIT
* Get citation information for `rorcid` in R doing `citation(package = 'rorcid')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
