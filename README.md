rorcid
======



[![Build Status](https://api.travis-ci.org/ropensci/rorcid.png)](https://travis-ci.org/ropensci/rorcid)
[![Build status](https://ci.appveyor.com/api/projects/status/29hanha8jfe4uen8/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/rorcid/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/rorcid/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rorcid?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rorcid?color=2ED968)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rorcid)](http://cran.rstudio.com/web/packages/rorcid)

`rorcid` is an R programmatic interface to the Orcid public API. `rorcid` is not a product developed or distributed by ORCID®.

Orcid API docs:

* [http://members.orcid.org/api](http://members.orcid.org/api)
* [https://github.com/ORCID/ORCID-Source/wiki/full-api-reference](https://github.com/ORCID/ORCID-Source/wiki/full-api-reference)

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
#>   URL (first): 
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
#>   Country: US
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
#>   Count: 6 - First 10
#> - Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite
#> - METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE
#> - Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host
#> - Presubmission Inquiry for PLOS Biology article on rOpenSci (PBIOLOGY-S-12-05379)
#> - git repository for paper on git and reproducible science
#> - git can facilitate greater reproducibility and increased transparency in science
```

And you can easily get to the entire data.frame of works details


```r
head(out$data)
#>   put-code journal-title short-description       work-type work-source
#> 1  5296064            NA                NA JOURNAL_ARTICLE          NA
#> 2  5296065            NA                NA JOURNAL_ARTICLE          NA
#> 3  5296066            NA                NA JOURNAL_ARTICLE          NA
#> 4  9012984            NA                NA JOURNAL_ARTICLE          NA
#> 5  9012986            NA                NA JOURNAL_ARTICLE          NA
#> 6  9012985            NA                NA JOURNAL_ARTICLE          NA
#>   language-code country visibility work-title.subtitle
#> 1            NA      NA     PUBLIC                  NA
#> 2            NA      NA     PUBLIC                  NA
#> 3            NA      NA     PUBLIC                  NA
#> 4            NA      NA     PUBLIC                  NA
#> 5            NA      NA     PUBLIC                  NA
#> 6            NA      NA     PUBLIC                  NA
#>   work-title.translated-title
#> 1                          NA
#> 2                          NA
#> 3                          NA
#> 4                          NA
#> 5                          NA
#> 6                          NA
#>                                                                             work-title.title.value
#> 1 Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite
#> 2                  METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE
#> 3       Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host
#> 4                 Presubmission Inquiry for PLOS Biology article on rOpenSci (PBIOLOGY-S-12-05379)
#> 5                                         git repository for paper on git and reproducible science
#> 6                 git can facilitate greater reproducibility and increased transparency in science
#>   work-citation.work-citation-type
#> 1            FORMATTED_UNSPECIFIED
#> 2            FORMATTED_UNSPECIFIED
#> 3            FORMATTED_UNSPECIFIED
#> 4                FORMATTED_CHICAGO
#> 5                FORMATTED_CHICAGO
#> 6                FORMATTED_CHICAGO
#>                                                                                                                                                                                                  work-citation.citation
#> 1                                           Dugaw, C & Ram, K, 2011, 'Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite', <i>Oecologia</i>, vol. 27, no. 2, pp. 154-325.
#> 2                                   Ram, K, Preisser, E, Gruner, D & Strong, D, 2008, 'METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE', <i>Ecology</i>, vol. 38, no. 12, pp. 119-3297.
#> 3             Gruner, D, Ram, K & Strong, D, 2007, 'Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host', <i>Journal of Invertebrate Pathology</i>, vol. 108, no. 6, pp. 167-19.
#> 4 Presubmission Inquiry for PLOS Biology article on rOpenSci (PBIOLOGY-S-12-05379). Karthik Ram, Carl Boettiger, Edmund Hart, Scott Chamberlain. figshare.\n                http://dx.doi.org/10.6084/m9.figshare.97222
#> 5                                                                        git repository for paper on git and reproducible science. Karthik Ram. figshare.\n                http://dx.doi.org/10.6084/m9.figshare.155613
#> 6                                                git can facilitate greater reproducibility and increased transparency in science. Karthik Ram. figshare.\n                http://dx.doi.org/10.6084/m9.figshare.153821
#>   publication-date.media-type publication-date.year.value
#> 1                          NA                        2011
#> 2                          NA                        2008
#> 3                          NA                        2007
#> 4                          NA                        <NA>
#> 5                          NA                        <NA>
#> 6                          NA                        <NA>
#>   publication-date.month.value publication-date.day.value
#> 1                           06                         27
#> 2                           12                       <NA>
#> 3                           01                       <NA>
#> 4                         <NA>                       <NA>
#> 5                         <NA>                       <NA>
#> 6                         <NA>                       <NA>
#>   work-external-identifiers.work-external-identifier
#> 1                     DOI, 10.1007/s00442-010-1844-5
#> 2                             DOI, 10.1890/08-0228.1
#> 3                     DOI, 10.1016/j.jip.2006.08.009
#> 4                                               NULL
#> 5                                               NULL
#> 6                                               NULL
#>   work-external-identifiers.scope
#> 1                              NA
#> 2                              NA
#> 3                              NA
#> 4                              NA
#> 5                              NA
#> 6                              NA
#>                                      url.value
#> 1                                         <NA>
#> 2                                         <NA>
#> 3                                         <NA>
#> 4  http://dx.doi.org/10.6084/m9.figshare.97222
#> 5 http://dx.doi.org/10.6084/m9.figshare.155613
#> 6 http://dx.doi.org/10.6084/m9.figshare.153821
#>   work-contributors.contributor source.source-client-id
#> 1     NA, NA, NA, FIRST, AUTHOR                      NA
#> 2     NA, NA, NA, FIRST, AUTHOR                      NA
#> 3     NA, NA, NA, FIRST, AUTHOR                      NA
#> 4                          NULL                      NA
#> 5                          NULL                      NA
#> 6                          NULL                      NA
#>   source.source-orcid.value              source.source-orcid.uri
#> 1                        NA http://orcid.org/0000-0002-0233-1757
#> 2                        NA http://orcid.org/0000-0002-0233-1757
#> 3                        NA http://orcid.org/0000-0002-0233-1757
#> 4                        NA http://orcid.org/0000-0001-9892-9368
#> 5                        NA http://orcid.org/0000-0001-9892-9368
#> 6                        NA http://orcid.org/0000-0001-9892-9368
#>   source.source-orcid.path source.source-orcid.host
#> 1      0000-0002-0233-1757                orcid.org
#> 2      0000-0002-0233-1757                orcid.org
#> 3      0000-0002-0233-1757                orcid.org
#> 4      0000-0001-9892-9368                orcid.org
#> 5      0000-0001-9892-9368                orcid.org
#> 6      0000-0001-9892-9368                orcid.org
#>     source.source-name.value source.source-date.value created-date.value
#> 1                Karthik Ram             1.362714e+12       1.362714e+12
#> 2                Karthik Ram             1.362714e+12       1.362714e+12
#> 3                Karthik Ram             1.362714e+12       1.362714e+12
#> 4 figshare ORCID integration             1.369327e+12       1.369327e+12
#> 5 figshare ORCID integration             1.369327e+12       1.369327e+12
#> 6 figshare ORCID integration             1.369327e+12       1.369327e+12
#>   last-modified-date.value
#> 1             1.460227e+12
#> 2             1.437088e+12
#> 3             1.437088e+12
#> 4             1.460227e+12
#> 5             1.460227e+12
#> 6             1.460227e+12
```

## Search Orcid

Get a list of names and Orcid IDs matching a name query


```r
orcid(query="carl boettiger")
#> <Orcid Search>
#> Found: 4029
#> Size: 10 X 36
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.9177030    NA       NA               NA                NA
#> 2              0.6513650    NA       NA               NA                NA
#> 3              0.5210920    NA       NA               NA                NA
#> 4              0.3685639    NA       NA               NA                NA
#> 5              0.3245929    NA       NA               NA                NA
#> 6              0.3245929    NA       NA               NA                NA
#> 7              0.3245929    NA       NA               NA                NA
#> 8              0.3245929    NA       NA               NA                NA
#> 9              0.3127369    NA       NA               NA                NA
#> 10             0.3072508    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), delegation
#>   (lgl), scope (lgl), personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr), biography.value (chr),
#>   biography.visibility (chr), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (chr), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (chr), keywords.keyword
#>   (list), keywords.visibility (chr),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (chr).
```

You can string together many search terms


```r
orcid(query="johnson cardiology houston")
#> <Orcid Search>
#> Found: 31166
#> Size: 10 X 33
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.4370659    NA       NA               NA                NA
#> 2              0.4150437    NA       NA               NA                NA
#> 3              0.3666709    NA       NA               NA                NA
#> 4              0.3649021    NA       NA               NA                NA
#> 5              0.3622111    NA       NA               NA                NA
#> 6              0.3289190    NA       NA               NA                NA
#> 7              0.3104667    NA       NA               NA                NA
#> 8              0.3104667    NA       NA               NA                NA
#> 9              0.3104667    NA       NA               NA                NA
#> 10             0.3070803    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   researcher-urls (lgl), external-identifiers (lgl), delegation (lgl),
#>   scope (lgl), personal-details.other-names (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr), biography.value (chr),
#>   biography.visibility (chr), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (chr), keywords.keyword
#>   (list), keywords.visibility (chr).
```

And use boolean operators


```r
orcid("johnson AND(caltech OR 'California Institute of Technology')")
#> <Orcid Search>
#> Found: 17748
#> Size: 10 X 36
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.5991007    NA       NA               NA                NA
#> 2              0.4152702    NA       NA               NA                NA
#> 3              0.4090322    NA       NA               NA                NA
#> 4              0.4076645    NA       NA               NA                NA
#> 5              0.3684099    NA       NA               NA                NA
#> 6              0.3676560    NA       NA               NA                NA
#> 7              0.3676560    NA       NA               NA                NA
#> 8              0.3451793    NA       NA               NA                NA
#> 9              0.3436569    NA       NA               NA                NA
#> 10             0.3351491    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), delegation
#>   (lgl), scope (lgl), personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr), biography.value (chr),
#>   biography.visibility (chr), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (chr), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (chr), keywords.keyword
#>   (list), keywords.visibility (chr),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (chr).
```

And you can use start and rows arguments to do pagination


```r
orcid("johnson cardiology houston", start = 2, rows = 3)
#> <Orcid Search>
#> Found: 31166
#> Size: 3 X 28
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                   (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1             0.3666709    NA       NA               NA                NA
#> 2             0.3649021    NA       NA               NA                NA
#> 3             0.3622111    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), biography
#>   (lgl), researcher-urls (lgl), contact-details (lgl), keywords (lgl),
#>   external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.credit-name (lgl), personal-details.other-names (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr).
```

Search specific fields. here, by text type


```r
orcid("text:English")
#> <Orcid Search>
#> Found: 19208
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.8907263    NA       NA               NA                NA
#> 2              0.7935221    NA       NA               NA                NA
#> 3              0.7587522    NA       NA               NA                NA
#> 4              0.7587522    NA       NA               NA                NA
#> 5              0.7587522    NA       NA               NA                NA
#> 6              0.7346586    NA       NA               NA                NA
#> 7              0.7346586    NA       NA               NA                NA
#> 8              0.7346586    NA       NA               NA                NA
#> 9              0.7346586    NA       NA               NA                NA
#> 10             0.7346586    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr), biography.value (chr),
#>   biography.visibility (chr), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (chr), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (chr), keywords.keyword
#>   (list), keywords.visibility (chr).
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
#> 1             14.393827    NA       NA               NA                NA
#> 2              7.196914    NA       NA               NA                NA
#> 3              7.124581    NA       NA               NA                NA
#> 4              6.232710    NA       NA               NA                NA
#> 5              6.106784    NA       NA               NA                NA
#> 6              4.986168    NA       NA               NA                NA
#> 7              2.035595    NA       NA               NA                NA
#> 8              1.079537    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), delegation
#>   (lgl), scope (lgl), personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr), biography.value (chr),
#>   biography.visibility (chr), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (chr), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (chr), keywords.keyword
#>   (list), keywords.visibility (chr),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (chr).
```

This DOI is not a real one, but a partial DOI, then we can fuzzy search


```r
orcid_doi(dois="10.1087/2", fuzzy=TRUE, rows=5)
#> [[1]]
#> <Orcid DOI Search> 10.1087/2
#> Found: 288010
#> Size: 5 X 34
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                   (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1             0.8978900    NA       NA               NA                NA
#> 2             0.7856538    NA       NA               NA                NA
#> 3             0.7480600    NA       NA               NA                NA
#> 4             0.7242350    NA       NA               NA                NA
#> 5             0.7119772    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   researcher-urls (lgl), external-identifiers (lgl), delegation (lgl),
#>   scope (lgl), personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr), biography.value (chr),
#>   biography.visibility (chr), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (chr), keywords.keyword
#>   (list), keywords.visibility (chr).
```

Function is vectorized, search for many DOIs


```r
dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
       "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
orcid_doi(dois=dois, fuzzy = TRUE)
#> [[1]]
#> <Orcid DOI Search> 10.1371/journal.pone.0025995
#> Found: 43982
#> Size: 10 X 34
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.2436585    NA       NA               NA                NA
#> 2              0.1880206    NA       NA               NA                NA
#> 3              0.1661883    NA       NA               NA                NA
#> 4              0.1628306    NA       NA               NA                NA
#> 5              0.1628306    NA       NA               NA                NA
#> 6              0.1628306    NA       NA               NA                NA
#> 7              0.1628306    NA       NA               NA                NA
#> 8              0.1628306    NA       NA               NA                NA
#> 9              0.1506209    NA       NA               NA                NA
#> 10             0.1410154    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), biography
#>   (lgl), keywords (lgl), delegation (lgl), scope (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr),
#>   researcher-urls.researcher-url (list), researcher-urls.visibility (chr),
#>   contact-details.email (list), contact-details.address.country.value
#>   (chr), contact-details.address.country.visibility (chr),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (chr).
#> 
#> [[2]]
#> <Orcid DOI Search> 10.1371/journal.pone.0053712
#> Found: 43982
#> Size: 10 X 34
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.3111266    NA       NA               NA                NA
#> 2              0.1955029    NA       NA               NA                NA
#> 3              0.1728018    NA       NA               NA                NA
#> 4              0.1693105    NA       NA               NA                NA
#> 5              0.1693105    NA       NA               NA                NA
#> 6              0.1693105    NA       NA               NA                NA
#> 7              0.1693105    NA       NA               NA                NA
#> 8              0.1693105    NA       NA               NA                NA
#> 9              0.1566150    NA       NA               NA                NA
#> 10             0.1466272    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), biography
#>   (lgl), external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr),
#>   researcher-urls.researcher-url (list), researcher-urls.visibility (chr),
#>   contact-details.email (list), contact-details.address.country.value
#>   (chr), contact-details.address.country.visibility (chr),
#>   keywords.keyword (list), keywords.visibility (chr).
#> 
#> [[3]]
#> <Orcid DOI Search> 10.1371/journal.pone.0054608
#> Found: 43982
#> Size: 10 X 33
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.1810417    NA       NA               NA                NA
#> 2              0.1600197    NA       NA               NA                NA
#> 3              0.1567867    NA       NA               NA                NA
#> 4              0.1567867    NA       NA               NA                NA
#> 5              0.1567867    NA       NA               NA                NA
#> 6              0.1567867    NA       NA               NA                NA
#> 7              0.1567867    NA       NA               NA                NA
#> 8              0.1450302    NA       NA               NA                NA
#> 9              0.1357813    NA       NA               NA                NA
#> 10             0.1357813    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), biography
#>   (lgl), keywords (lgl), external-identifiers (lgl), delegation (lgl),
#>   scope (lgl), personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr),
#>   researcher-urls.researcher-url (list), researcher-urls.visibility (chr),
#>   contact-details.email (list), contact-details.address.country.value
#>   (chr), contact-details.address.country.visibility (chr).
#> 
#> [[4]]
#> <Orcid DOI Search> 10.1371/journal.pone.0055937
#> Found: 43982
#> Size: 10 X 34
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.1923333    NA       NA               NA                NA
#> 2              0.1700003    NA       NA               NA                NA
#> 3              0.1665656    NA       NA               NA                NA
#> 4              0.1665656    NA       NA               NA                NA
#> 5              0.1665656    NA       NA               NA                NA
#> 6              0.1665656    NA       NA               NA                NA
#> 7              0.1665656    NA       NA               NA                NA
#> 8              0.1540759    NA       NA               NA                NA
#> 9              0.1503415    NA       NA               NA                NA
#> 10             0.1442500    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr), biography
#>   (lgl), keywords (lgl), delegation (lgl), scope (lgl),
#>   personal-details.given-names.value (chr),
#>   personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.credit-name.value (chr),
#>   personal-details.credit-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr),
#>   researcher-urls.researcher-url (list), researcher-urls.visibility (chr),
#>   contact-details.email (list), contact-details.address.country.value
#>   (chr), contact-details.address.country.visibility (chr),
#>   external-identifiers.external-identifier (list),
#>   external-identifiers.visibility (chr).
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rorcid/issues)
* License: MIT
* Get citation information for `rorcid` in R doing `citation(package = 'rorcid')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
