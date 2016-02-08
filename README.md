rorcid
======



[![Build Status](https://api.travis-ci.org/ropensci/rorcid.png)](https://travis-ci.org/ropensci/rorcid)
[![Build status](https://ci.appveyor.com/api/projects/status/29hanha8jfe4uen8/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/rorcid/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/rorcid/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rorcid?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rorcid?color=2ED968)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rorcid)](http://cran.rstudio.com/web/packages/rorcid)

`rorcid` is an R programmatic interface to the Orcid public API. `rorcid` is not a product developed or distributed by ORCID®.

Orcid API docs:

* http://members.orcid.org/api
* https://github.com/ORCID/ORCID-Source/wiki/full-api-reference

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
as.orcid(x="0000-0002-1642-628X")
#> <ORCID> 0000-0002-1642-628X
#>   Name: Boettiger, Carl
#>   URL (first): http://www.carlboettiger.info
#>   Country: US
#>   Keywords: Ecology, Evolution, Regime Shifts, Stochastic Dynamics
#>   Submission date: 2012-11-01 17:57:23
```

You by default get the print method above, but you can use `summary()` as well to get more detailed information.


```r
summary( as.orcid(x="0000-0002-1642-628X") )
#> <ORCID Summary> 0000-0002-1642-628X
#>   Name: Boettiger, Carl
#>   URLs:
#>      carlboettiger.info: http://www.carlboettiger.info
#>   Country: US
#>   Keywords: Ecology, Evolution, Regime Shifts, Stochastic Dynamics
#>   Submission date: 
#>   Works:
#>         Tipping points: From patterns to predictions 
#>         No early warning signals for stochastic transitions: 
#> Insights from large deviation theory 
#>         Early warning signals: the charted and uncharted 
#> territories 
#>         Data from: No early warning signals for stochastic 
#> transitions: insights from large deviation theory 
#>         Data from: Early warning signals and the prosecutor's 
#> fallacy 
#>         Treebase: An R package for discovery, access and 
#> manipulation of online phylogenies 
#>         The cost of open access [2] 
#>         Rfishbase: Exploring, manipulating and visualizing 
#> FishBase data from R 
#>         Regime shifts in ecology and evolution (PhD Dissertation) 
#>         Quantifying limits to detection of early warning for 
#> critical transitions 
#>         Modeling stabilizing selection: Expanding the 
#> Ornstein-Uhlenbeck model of adaptive evolution 
#>         Is your phylogeny informative? Measuring the power of 
#> comparative methods 
#>         Early warning signals and the prosecutor's fallacy 
#>         Data from: Is your phylogeny informative? Measuring the 
#> power of comparative methods 
#>         Data from: Fluc­tu­a­tion domains in adap­tive 
#> evo­lu­tion 
#>         Fluctuation domains in adaptive evolution 
#>         The shape, multiplicity, and evolution of superclusters 
#> in ACDM cosmology
```

Or you can pass in many IDs


```r
lapply(c("0000-0003-1620-1408", "0000-0002-9341-7985"), as.orcid)
#> [[1]]
#> <ORCID> 0000-0003-1620-1408
#>   Name: Johnson, Thomas
#>   URL (first): 
#>   Country: 
#>   Keywords: 
#>   Submission date: 2012-10-27 10:33:31
#> 
#> [[2]]
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
out <- works(orcid_id("0000-0002-0233-1757"))
out
#> <WORKS> 0000-0002-0233-1757
#>   Count: 3 - First 10
#> - Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite
#> - METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE
#> - Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host
```

And you can easily get to the entire data.frame of works details


```r
head(out$data)
#>   put-code journal-title short-description       work-type url work-source
#> 1  5296064            NA                NA JOURNAL_ARTICLE  NA          NA
#> 2  5296065            NA                NA JOURNAL_ARTICLE  NA          NA
#> 3  5296066            NA                NA JOURNAL_ARTICLE  NA          NA
#>   language-code country visibility work-title.subtitle
#> 1            NA      NA     PUBLIC                  NA
#> 2            NA      NA     PUBLIC                  NA
#> 3            NA      NA     PUBLIC                  NA
#>   work-title.translated-title
#> 1                          NA
#> 2                          NA
#> 3                          NA
#>                                                                             work-title.title.value
#> 1 Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite
#> 2                  METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE
#> 3       Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host
#>   work-citation.work-citation-type
#> 1            FORMATTED_UNSPECIFIED
#> 2            FORMATTED_UNSPECIFIED
#> 3            FORMATTED_UNSPECIFIED
#>                                                                                                                                                                                      work-citation.citation
#> 1                               Dugaw, C & Ram, K, 2011, 'Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite', <i>Oecologia</i>, vol. 27, no. 2, pp. 154-325.
#> 2                       Ram, K, Preisser, E, Gruner, D & Strong, D, 2008, 'METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE', <i>Ecology</i>, vol. 38, no. 12, pp. 119-3297.
#> 3 Gruner, D, Ram, K & Strong, D, 2007, 'Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host', <i>Journal of Invertebrate Pathology</i>, vol. 108, no. 6, pp. 167-19.
#>   publication-date.media-type publication-date.year.value
#> 1                          NA                        2011
#> 2                          NA                        2008
#> 3                          NA                        2007
#>   publication-date.month.value publication-date.day.value
#> 1                           06                         27
#> 2                           12                       <NA>
#> 3                           01                       <NA>
#>   work-external-identifiers.work-external-identifier
#> 1                     DOI, 10.1007/s00442-010-1844-5
#> 2                             DOI, 10.1890/08-0228.1
#> 3                     DOI, 10.1016/j.jip.2006.08.009
#>   work-external-identifiers.scope work-contributors.contributor
#> 1                              NA     NA, NA, NA, FIRST, AUTHOR
#> 2                              NA     NA, NA, NA, FIRST, AUTHOR
#> 3                              NA     NA, NA, NA, FIRST, AUTHOR
#>   source.source-client-id source.source-orcid.value
#> 1                      NA                        NA
#> 2                      NA                        NA
#> 3                      NA                        NA
#>                source.source-orcid.uri source.source-orcid.path
#> 1 http://orcid.org/0000-0002-0233-1757      0000-0002-0233-1757
#> 2 http://orcid.org/0000-0002-0233-1757      0000-0002-0233-1757
#> 3 http://orcid.org/0000-0002-0233-1757      0000-0002-0233-1757
#>   source.source-orcid.host source.source-name.value
#> 1                orcid.org              Karthik Ram
#> 2                orcid.org              Karthik Ram
#> 3                orcid.org              Karthik Ram
#>   source.source-date.value created-date.value last-modified-date.value
#> 1             1.362714e+12       1.362714e+12             1.437088e+12
#> 2             1.362714e+12       1.362714e+12             1.437088e+12
#> 3             1.362714e+12       1.362714e+12             1.437088e+12
```

## Search Orcid

Get a list of names and Orcid IDs matching a name query


```r
orcid(query="carl boettiger")
#> <Orcid Search>
#> Found: 3388
#> Size: 10 X 36
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.9250884    NA       NA               NA                NA
#> 2              0.6547679    NA       NA               NA                NA
#> 3              0.3718410    NA       NA               NA                NA
#> 4              0.3305628    NA       NA               NA                NA
#> 5              0.3305628    NA       NA               NA                NA
#> 6              0.3305628    NA       NA               NA                NA
#> 7              0.3305628    NA       NA               NA                NA
#> 8              0.3129017    NA       NA               NA                NA
#> 9              0.2988593    NA       NA               NA                NA
#> 10             0.2946455    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), delegation
#>   (lgl), scope (lgl), personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl), keywords.keyword
#>   (list), keywords.visibility (lgl),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (lgl).
```

You can string together many search terms


```r
orcid(query="johnson cardiology houston")
#> <Orcid Search>
#> Found: 27028
#> Size: 10 X 33
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.4372813    NA       NA               NA                NA
#> 2              0.4153811    NA       NA               NA                NA
#> 3              0.3714895    NA       NA               NA                NA
#> 4              0.3696327    NA       NA               NA                NA
#> 5              0.3645557    NA       NA               NA                NA
#> 6              0.3332218    NA       NA               NA                NA
#> 7              0.3124763    NA       NA               NA                NA
#> 8              0.3124763    NA       NA               NA                NA
#> 9              0.3110496    NA       NA               NA                NA
#> 10             0.3064326    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   researcher-urls (lgl), external-identifiers (lgl), delegation (lgl),
#>   scope (lgl), personal-details.other-names (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl), keywords.keyword
#>   (list), keywords.visibility (lgl).
```

And use boolean operators


```r
orcid("johnson AND(caltech OR 'California Institute of Technology')")
#> <Orcid Search>
#> Found: 15473
#> Size: 10 X 36
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.6064259    NA       NA               NA                NA
#> 2              0.4127287    NA       NA               NA                NA
#> 3              0.3722699    NA       NA               NA                NA
#> 4              0.3692747    NA       NA               NA                NA
#> 5              0.3539956    NA       NA               NA                NA
#> 6              0.3475673    NA       NA               NA                NA
#> 7              0.3451672    NA       NA               NA                NA
#> 8              0.3380194    NA       NA               NA                NA
#> 9              0.3350665    NA       NA               NA                NA
#> 10             0.3231154    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), delegation
#>   (lgl), scope (lgl), personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl), keywords.keyword
#>   (list), keywords.visibility (lgl),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (lgl).
```

And you can use start and rows arguments to do pagination


```r
orcid("johnson cardiology houston", start = 2, rows = 3)
#> <Orcid Search>
#> Found: 27028
#> Size: 3 X 29
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                   (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1             0.3714895    NA       NA               NA                NA
#> 2             0.3696327    NA       NA               NA                NA
#> 3             0.3645557    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   researcher-urls (lgl), contact-details (lgl), keywords (lgl),
#>   external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.credit-name (lgl), personal-details.other-names (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl).
```

Search specific fields. here, by text type


```r
orcid("text:English")
#> <Orcid Search>
#> Found: 16117
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.9140396    NA       NA               NA                NA
#> 2              0.8142912    NA       NA               NA                NA
#> 3              0.7786113    NA       NA               NA                NA
#> 4              0.7786113    NA       NA               NA                NA
#> 5              0.7538872    NA       NA               NA                NA
#> 6              0.7538872    NA       NA               NA                NA
#> 7              0.7538872    NA       NA               NA                NA
#> 8              0.7538872    NA       NA               NA                NA
#> 9              0.7538872    NA       NA               NA                NA
#> 10             0.7538872    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl), keywords.keyword
#>   (list), keywords.visibility (lgl).
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
out <- orcid_id(orcid = "0000-0002-9341-7985", profile="works")
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
#> [1] 1.453659e+12
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
orcid_doi(dois="10.1087/20120404")
#> [[1]]
#> <Orcid DOI Search> 10.1087/20120404
#> Found: 8
#> Size: 8 X 36
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                   (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1             14.390273    NA       NA               NA                NA
#> 2              7.195137    NA       NA               NA                NA
#> 3              6.231171    NA       NA               NA                NA
#> 4              6.105276    NA       NA               NA                NA
#> 5              5.756109    NA       NA               NA                NA
#> 6              4.984937    NA       NA               NA                NA
#> 7              1.798784    NA       NA               NA                NA
#> 8              1.259149    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), delegation
#>   (lgl), scope (lgl), personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl), keywords.keyword
#>   (list), keywords.visibility (lgl),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (lgl).
```

This DOI is not a real one, but a partial DOI, then we can fuzzy search


```r
orcid_doi(dois="10.1087/2", fuzzy=TRUE, rows=5)
#> [[1]]
#> <Orcid DOI Search> 10.1087/2
#> Found: 252909
#> Size: 5 X 35
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                   (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1             0.9009679    NA       NA               NA                NA
#> 2             0.7883469    NA       NA               NA                NA
#> 3             0.7507699    NA       NA               NA                NA
#> 4             0.7269728    NA       NA               NA                NA
#> 5             0.7150497    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl), keywords.keyword
#>   (list), keywords.visibility (lgl).
```

Function is vectorized, search for many DOIs


```r
dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
       "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
orcid_doi(dois=dois, fuzzy = TRUE)
#> [[1]]
#> <Orcid DOI Search> 10.1371/journal.pone.0025995
#> Found: 38495
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.2427311    NA       NA               NA                NA
#> 2              0.1935129    NA       NA               NA                NA
#> 3              0.1710429    NA       NA               NA                NA
#> 4              0.1675871    NA       NA               NA                NA
#> 5              0.1675871    NA       NA               NA                NA
#> 6              0.1675871    NA       NA               NA                NA
#> 7              0.1675871    NA       NA               NA                NA
#> 8              0.1675871    NA       NA               NA                NA
#> 9              0.1580027    NA       NA               NA                NA
#> 10             0.1550260    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), keywords
#>   (lgl), delegation (lgl), scope (lgl), personal-details.given-names.value
#>   (chr), personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (lgl).
#> 
#> [[2]]
#> <Orcid DOI Search> 10.1371/journal.pone.0053712
#> Found: 38495
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.3215808    NA       NA               NA                NA
#> 2              0.1935129    NA       NA               NA                NA
#> 3              0.1710429    NA       NA               NA                NA
#> 4              0.1675871    NA       NA               NA                NA
#> 5              0.1675871    NA       NA               NA                NA
#> 6              0.1675871    NA       NA               NA                NA
#> 7              0.1675871    NA       NA               NA                NA
#> 8              0.1675871    NA       NA               NA                NA
#> 9              0.1580027    NA       NA               NA                NA
#> 10             0.1550260    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl), keywords.keyword
#>   (list), keywords.visibility (lgl).
#> 
#> [[3]]
#> <Orcid DOI Search> 10.1371/journal.pone.0054608
#> Found: 38495
#> Size: 10 X 34
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.1863107    NA       NA               NA                NA
#> 2              0.1646769    NA       NA               NA                NA
#> 3              0.1613498    NA       NA               NA                NA
#> 4              0.1613498    NA       NA               NA                NA
#> 5              0.1613498    NA       NA               NA                NA
#> 6              0.1613498    NA       NA               NA                NA
#> 7              0.1613498    NA       NA               NA                NA
#> 8              0.1521221    NA       NA               NA                NA
#> 9              0.1492562    NA       NA               NA                NA
#> 10             0.1397330    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), keywords
#>   (lgl), external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl).
#> 
#> [[4]]
#> <Orcid DOI Search> 10.1371/journal.pone.0055937
#> Found: 38495
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.1979634    NA       NA               NA                NA
#> 2              0.1749766    NA       NA               NA                NA
#> 3              0.1714413    NA       NA               NA                NA
#> 4              0.1714413    NA       NA               NA                NA
#> 5              0.1714413    NA       NA               NA                NA
#> 6              0.1714413    NA       NA               NA                NA
#> 7              0.1714413    NA       NA               NA                NA
#> 8              0.1616364    NA       NA               NA                NA
#> 9              0.1585914    NA       NA               NA                NA
#> 10             0.1500076    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), keywords
#>   (lgl), delegation (lgl), scope (lgl), personal-details.given-names.value
#>   (chr), personal-details.given-names.visibility (lgl),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (lgl),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (lgl),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (lgl), biography.value (chr),
#>   biography.visibility (lgl), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (lgl), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (lgl),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (lgl).
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rorcid/issues)
* License: MIT
* Get citation information for `rorcid` in R doing `citation(package = 'rorcid')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
