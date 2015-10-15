rorcid
======



[![Build Status](https://api.travis-ci.org/ropensci/rorcid.png)](https://travis-ci.org/ropensci/rorcid)
[![Build status](https://ci.appveyor.com/api/projects/status/29hanha8jfe4uen8/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/rorcid/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/rorcid/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rorcid?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rorcid?color=2ED968)](https://github.com/metacran/cranlogs.app)

`rorcid` is an R programmatic interface to the Orcid public API. `rorcid` is not a product developed or distributed by ORCID®.

Orcid API docs: 

* http://members.orcid.org/api
* https://github.com/ORCID/ORCID-Source/wiki/full-api-reference

## Installation


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
#> 
#> 
#>   Keywords: 
#>   Submission date: 2012-10-27 10:33:31
#> 
#> [[2]]
#> <ORCID> 0000-0002-9341-7985
#>   Name: Binfield, Peter
#> 
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
#> - Dugaw, C & Ram, K, 2011, 'Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite', <i>Oecologia</i>, vol. 27, no. 2, pp. 154-325.
#> - Ram, K, Preisser, E, Gruner, D & Strong, D, 2008, 'METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE', <i>Ecology</i>, vol. 38, no. 12, pp. 119-3297.
#> - Gruner, D, Ram, K & Strong, D, 2007, 'Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host', <i>Journal of Invertebrate Pathology</i>, vol. 108, no. 6, pp. 167-19.
```

And you can easily get to the entire data.frame of works details


```r
head(out$data)
#>   put-code journal-title short-description       work-type url source
#> 1  5296064            NA                NA JOURNAL_ARTICLE  NA     NA
#> 2  5296065            NA                NA JOURNAL_ARTICLE  NA     NA
#> 3  5296066            NA                NA JOURNAL_ARTICLE  NA     NA
#>   created-date last-modified-date language-code country visibility
#> 1           NA                 NA            NA      NA     PUBLIC
#> 2           NA                 NA            NA      NA     PUBLIC
#> 3           NA                 NA            NA      NA     PUBLIC
#>   work-title.subtitle work-title.translated-title
#> 1                  NA                          NA
#> 2                  NA                          NA
#> 3                  NA                          NA
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
#>   work-source.value                      work-source.uri
#> 1                NA http://orcid.org/0000-0002-0233-1757
#> 2                NA http://orcid.org/0000-0002-0233-1757
#> 3                NA http://orcid.org/0000-0002-0233-1757
#>      work-source.path work-source.host
#> 1 0000-0002-0233-1757        orcid.org
#> 2 0000-0002-0233-1757        orcid.org
#> 3 0000-0002-0233-1757        orcid.org
```

## Search Orcid

Get a list of names and Orcid IDs matching a name query


```r
orcid(query="carl boettiger")
#> <Orcid Search>
#> Found: 2776
#> Size: 10 X 36
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              0.9144474    NA       NA               NA                NA
#> 2              0.6513379    NA       NA               NA                NA
#> 3              0.5136184    NA       NA               NA                NA
#> 4              0.3192722    NA       NA               NA                NA
#> 5              0.3192722    NA       NA               NA                NA
#> 6              0.3192722    NA       NA               NA                NA
#> 7              0.3192722    NA       NA               NA                NA
#> 8              0.3192722    NA       NA               NA                NA
#> 9              0.3022143    NA       NA               NA                NA
#> 10             0.2972937    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), delegation (lgl), scope (lgl),
#>      personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl), keywords.keyword
#>      (list), keywords.visibility (lgl),
#>      external-identifiers.external-identifier (list),
#>      external-identifiers.visibility (lgl), orcid-activities.affiliations
#>      (lgl), orcid-activities.orcid-works (lgl),
#>      orcid-activities.funding-list (lgl)
```

You can string together many search terms


```r
orcid(query="johnson cardiology houston")
#> <Orcid Search>
#> Found: 21940
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              0.6441083    NA       NA               NA                NA
#> 2              0.4313030    NA       NA               NA                NA
#> 3              0.4098923    NA       NA               NA                NA
#> 4              0.3691051    NA       NA               NA                NA
#> 5              0.3626695    NA       NA               NA                NA
#> 6              0.3294507    NA       NA               NA                NA
#> 7              0.3108596    NA       NA               NA                NA
#> 8              0.3108596    NA       NA               NA                NA
#> 9              0.3038268    NA       NA               NA                NA
#> 10             0.3035739    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), external-identifiers (lgl), delegation
#>      (lgl), scope (lgl), personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl), keywords.keyword
#>      (list), keywords.visibility (lgl), orcid-activities.affiliations
#>      (lgl), orcid-activities.orcid-works (lgl),
#>      orcid-activities.funding-list (lgl)
```

And use boolean operators


```r
orcid("johnson AND(caltech OR 'California Institute of Technology')")
#> <Orcid Search>
#> Found: 12434
#> Size: 10 X 36
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              0.5956504    NA       NA               NA                NA
#> 2              0.3978453    NA       NA               NA                NA
#> 3              0.3647148    NA       NA               NA                NA
#> 4              0.3599079    NA       NA               NA                NA
#> 5              0.3493960    NA       NA               NA                NA
#> 6              0.3493960    NA       NA               NA                NA
#> 7              0.3265852    NA       NA               NA                NA
#> 8              0.3259330    NA       NA               NA                NA
#> 9              0.3237784    NA       NA               NA                NA
#> 10             0.3226557    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), delegation (lgl), scope (lgl),
#>      personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl), keywords.keyword
#>      (list), keywords.visibility (lgl),
#>      external-identifiers.external-identifier (list),
#>      external-identifiers.visibility (lgl), orcid-activities.affiliations
#>      (lgl), orcid-activities.orcid-works (lgl),
#>      orcid-activities.funding-list (lgl)
```

And you can use start and rows arguments to do pagination


```r
orcid("johnson cardiology houston", start = 2, rows = 3)
#> <Orcid Search>
#> Found: 21940
#> Size: 3 X 29
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1             0.4098923    NA       NA               NA                NA
#> 2             0.3691051    NA       NA               NA                NA
#> 3             0.3626695    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), researcher-urls (lgl), contact-details
#>      (lgl), keywords (lgl), external-identifiers (lgl), delegation (lgl),
#>      scope (lgl), personal-details.credit-name (lgl),
#>      personal-details.other-names (lgl),
#>      personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr), biography.value (chr),
#>      biography.visibility (lgl), orcid-activities.affiliations (lgl),
#>      orcid-activities.orcid-works (lgl), orcid-activities.funding-list
#>      (lgl)
```

Search specific fields. here, by text type


```r
orcid("text:English")
#> <Orcid Search>
#> Found: 12631
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              1.0387812    NA       NA               NA                NA
#> 2              0.8613118    NA       NA               NA                NA
#> 3              0.8097423    NA       NA               NA                NA
#> 4              0.7742617    NA       NA               NA                NA
#> 5              0.7742617    NA       NA               NA                NA
#> 6              0.7496757    NA       NA               NA                NA
#> 7              0.7496757    NA       NA               NA                NA
#> 8              0.7496757    NA       NA               NA                NA
#> 9              0.7496757    NA       NA               NA                NA
#> 10             0.7496757    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), external-identifiers (lgl), delegation
#>      (lgl), scope (lgl), personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl), keywords.keyword
#>      (list), keywords.visibility (lgl), orcid-activities.affiliations
#>      (lgl), orcid-activities.orcid-works (lgl),
#>      orcid-activities.funding-list (lgl)
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
#> [1] 1.437748e+12
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
#> NULL
#> 
#> $`verified-primary-email`
#> NULL
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
#> Found: 6
#> Size: 6 X 36
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              9.650854    NA       NA               NA                NA
#> 2              5.790513    NA       NA               NA                NA
#> 3              5.459348    NA       NA               NA                NA
#> 4              3.860342    NA       NA               NA                NA
#> 5              2.047255    NA       NA               NA                NA
#> 6              1.194232    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), delegation (lgl), scope (lgl),
#>      personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl), keywords.keyword
#>      (list), keywords.visibility (lgl),
#>      external-identifiers.external-identifier (list),
#>      external-identifiers.visibility (lgl), orcid-activities.affiliations
#>      (lgl), orcid-activities.orcid-works (lgl),
#>      orcid-activities.funding-list (lgl)
```

This DOI is not a real one, but a partial DOI, then we can fuzzy search


```r
orcid_doi(dois="10.1087/2", fuzzy=TRUE, rows=5)
#> [[1]]
#> <Orcid DOI Search> 10.1087/2
#> Found: 206586
#> Size: 5 X 35
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1             0.8613721    NA       NA               NA                NA
#> 2             0.7537006    NA       NA               NA                NA
#> 3             0.7175421    NA       NA               NA                NA
#> 4             0.6946154    NA       NA               NA                NA
#> 5             0.6826138    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), external-identifiers (lgl), delegation
#>      (lgl), scope (lgl), personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl), keywords.keyword
#>      (list), keywords.visibility (lgl), orcid-activities.affiliations
#>      (lgl), orcid-activities.orcid-works (lgl),
#>      orcid-activities.funding-list (lgl)
```

Function is vectorized, search for many DOIs


```r
dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
       "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
orcid_doi(dois=dois, fuzzy = TRUE)
#> [[1]]
#> <Orcid DOI Search> 10.1371/journal.pone.0025995
#> Found: 31061
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              0.2352983    NA       NA               NA                NA
#> 2              0.1830770    NA       NA               NA                NA
#> 3              0.1618187    NA       NA               NA                NA
#> 4              0.1585493    NA       NA               NA                NA
#> 5              0.1585493    NA       NA               NA                NA
#> 6              0.1585493    NA       NA               NA                NA
#> 7              0.1585493    NA       NA               NA                NA
#> 8              0.1585493    NA       NA               NA                NA
#> 9              0.1494817    NA       NA               NA                NA
#> 10             0.1466326    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), keywords (lgl), delegation (lgl), scope
#>      (lgl), personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl),
#>      external-identifiers.external-identifier (list),
#>      external-identifiers.visibility (lgl), orcid-activities.affiliations
#>      (lgl), orcid-activities.orcid-works (lgl),
#>      orcid-activities.funding-list (lgl)
#> 
#> [[2]]
#> <Orcid DOI Search> 10.1371/journal.pone.0053712
#> Found: 31061
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              0.3070936    NA       NA               NA                NA
#> 2              0.1861446    NA       NA               NA                NA
#> 3              0.1645301    NA       NA               NA                NA
#> 4              0.1612059    NA       NA               NA                NA
#> 5              0.1612059    NA       NA               NA                NA
#> 6              0.1612059    NA       NA               NA                NA
#> 7              0.1612059    NA       NA               NA                NA
#> 8              0.1612059    NA       NA               NA                NA
#> 9              0.1519864    NA       NA               NA                NA
#> 10             0.1490895    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), external-identifiers (lgl), delegation
#>      (lgl), scope (lgl), personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl), keywords.keyword
#>      (list), keywords.visibility (lgl), orcid-activities.affiliations
#>      (lgl), orcid-activities.orcid-works (lgl),
#>      orcid-activities.funding-list (lgl)
#> 
#> [[3]]
#> <Orcid DOI Search> 10.1371/journal.pone.0054608
#> Found: 31061
#> Size: 10 X 34
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              0.1721643    NA       NA               NA                NA
#> 2              0.1521732    NA       NA               NA                NA
#> 3              0.1490986    NA       NA               NA                NA
#> 4              0.1490986    NA       NA               NA                NA
#> 5              0.1490986    NA       NA               NA                NA
#> 6              0.1490986    NA       NA               NA                NA
#> 7              0.1490986    NA       NA               NA                NA
#> 8              0.1405715    NA       NA               NA                NA
#> 9              0.1378922    NA       NA               NA                NA
#> 10             0.1291232    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), keywords (lgl), external-identifiers
#>      (lgl), delegation (lgl), scope (lgl),
#>      personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl),
#>      orcid-activities.affiliations (lgl), orcid-activities.orcid-works
#>      (lgl), orcid-activities.funding-list (lgl)
#> 
#> [[4]]
#> <Orcid DOI Search> 10.1371/journal.pone.0055937
#> Found: 31061
#> Size: 10 X 34
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#> 1              0.1721643    NA       NA               NA                NA
#> 2              0.1521732    NA       NA               NA                NA
#> 3              0.1490986    NA       NA               NA                NA
#> 4              0.1490986    NA       NA               NA                NA
#> 5              0.1490986    NA       NA               NA                NA
#> 6              0.1490986    NA       NA               NA                NA
#> 7              0.1490986    NA       NA               NA                NA
#> 8              0.1405715    NA       NA               NA                NA
#> 9              0.1378922    NA       NA               NA                NA
#> 10             0.1291232    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-internal (lgl), type
#>      (lgl), group-type (lgl), client-type (lgl), orcid-identifier.value
#>      (lgl), orcid-identifier.uri (chr), orcid-identifier.path (chr),
#>      orcid-identifier.host (chr), keywords (lgl), external-identifiers
#>      (lgl), delegation (lgl), scope (lgl),
#>      personal-details.given-names.value (chr),
#>      personal-details.family-name.value (chr),
#>      personal-details.credit-name.value (chr),
#>      personal-details.credit-name.visibility (lgl),
#>      personal-details.other-names.other-name (list),
#>      personal-details.other-names.visibility (lgl), biography.value (chr),
#>      biography.visibility (lgl), researcher-urls.researcher-url (list),
#>      researcher-urls.visibility (lgl), contact-details.email (list),
#>      contact-details.address.country.value (chr),
#>      contact-details.address.country.visibility (lgl),
#>      orcid-activities.affiliations (lgl), orcid-activities.orcid-works
#>      (lgl), orcid-activities.funding-list (lgl)
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rorcid/issues)
* License: MIT
* Get citation information for `rorcid` in R doing `citation(package = 'rorcid')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
