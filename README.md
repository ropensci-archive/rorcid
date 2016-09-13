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
#>         Data from: Early warning signals and the prosecutor's 
#> fallacy 
#>         Data from: No early warning signals for stochastic 
#> transitions: insights from large deviation theory 
#>         Early warning signals: the charted and uncharted 
#> territories 
#>         No early warning signals for stochastic transitions: 
#> Insights from large deviation theory 
#>         Tipping points: From patterns to predictions 
#>         Data from: Fluc­tu­a­tion domains in adap­tive 
#> evo­lu­tion 
#>         Data from: Is your phylogeny informative? Measuring the 
#> power of comparative methods 
#>         Early warning signals and the prosecutor's fallacy 
#>         Is your phylogeny informative? Measuring the power of 
#> comparative methods 
#>         Modeling stabilizing selection: Expanding the 
#> Ornstein-Uhlenbeck model of adaptive evolution 
#>         Quantifying limits to detection of early warning for 
#> critical transitions 
#>         Regime shifts in ecology and evolution (PhD Dissertation) 
#>         Rfishbase: Exploring, manipulating and visualizing 
#> FishBase data from R 
#>         The cost of open access [2] 
#>         Treebase: An R package for discovery, access and 
#> manipulation of online phylogenies 
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
#> - git can facilitate greater reproducibility and increased transparency in science
#> - git repository for paper on git and reproducible science
```

And you can easily get to the entire data.frame of works details


```r
out$data[1:5, 1:5]
#>   put-code journal-title short-description       work-type work-source
#> 1  5296064            NA                NA JOURNAL_ARTICLE          NA
#> 2  5296065            NA                NA JOURNAL_ARTICLE          NA
#> 3  5296066            NA                NA JOURNAL_ARTICLE          NA
#> 4  9012984            NA                NA JOURNAL_ARTICLE          NA
#> 5  9012985            NA                NA JOURNAL_ARTICLE          NA
```

## Search Orcid

Get a list of names and Orcid IDs matching a name query


```r
orcid(query="carl boettiger")
#> <Orcid Search>
#> Found: 4914
#> Size: 10 X 36
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.7664279    NA       NA               NA                NA
#> 2              0.6470457    NA       NA               NA                NA
#> 3              0.5176365    NA       NA               NA                NA
#> 4              0.3637067    NA       NA               NA                NA
#> 5              0.3600513    NA       NA               NA                NA
#> 6              0.3148093    NA       NA               NA                NA
#> 7              0.3148093    NA       NA               NA                NA
#> 8              0.3148093    NA       NA               NA                NA
#> 9              0.3148093    NA       NA               NA                NA
#> 10             0.3148093    NA       NA               NA                NA
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
#> Found: 36763
#> Size: 10 X 34
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.4294077    NA       NA               NA                NA
#> 2              0.4079776    NA       NA               NA                NA
#> 3              0.3647970    NA       NA               NA                NA
#> 4              0.3593926    NA       NA               NA                NA
#> 5              0.3592269    NA       NA               NA                NA
#> 6              0.3261285    NA       NA               NA                NA
#> 7              0.3106890    NA       NA               NA                NA
#> 8              0.3079087    NA       NA               NA                NA
#> 9              0.3079087    NA       NA               NA                NA
#> 10             0.3079087    NA       NA               NA                NA
#> Variables not shown: orcid-history (lgl), orcid-activities (lgl),
#>   orcid-internal (lgl), type (lgl), group-type (lgl), client-type (lgl),
#>   orcid-identifier.value (lgl), orcid-identifier.uri (chr),
#>   orcid-identifier.path (chr), orcid-identifier.host (chr),
#>   external-identifiers (lgl), delegation (lgl), scope (lgl),
#>   personal-details.credit-name (lgl), personal-details.given-names.value
#>   (chr), personal-details.given-names.visibility (chr),
#>   personal-details.family-name.value (chr),
#>   personal-details.family-name.visibility (chr),
#>   personal-details.other-names.other-name (list),
#>   personal-details.other-names.visibility (chr), biography.value (chr),
#>   biography.visibility (chr), researcher-urls.researcher-url (list),
#>   researcher-urls.visibility (chr), contact-details.email (list),
#>   contact-details.address.country.value (chr),
#>   contact-details.address.country.visibility (chr), keywords.keyword
#>   (list), keywords.visibility (chr).
```

And use boolean operators


```r
orcid("johnson AND(caltech OR 'California Institute of Technology')")
#> <Orcid Search>
#> Found: 21049
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.5886935    NA       NA               NA                NA
#> 2              0.4012654    NA       NA               NA                NA
#> 3              0.3631530    NA       NA               NA                NA
#> 4              0.3552699    NA       NA               NA                NA
#> 5              0.3552699    NA       NA               NA                NA
#> 6              0.3552699    NA       NA               NA                NA
#> 7              0.3491456    NA       NA               NA                NA
#> 8              0.3335620    NA       NA               NA                NA
#> 9              0.3320770    NA       NA               NA                NA
#> 10             0.3320770    NA       NA               NA                NA
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

And you can use start and rows arguments to do pagination


```r
orcid("johnson cardiology houston", start = 2, rows = 3)
#> <Orcid Search>
#> Found: 36763
#> Size: 3 X 28
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                   (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1             0.3647970    NA       NA               NA                NA
#> 2             0.3593926    NA       NA               NA                NA
#> 3             0.3592269    NA       NA               NA                NA
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
#> Found: 22905
#> Size: 10 X 35
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              1.2268523    NA       NA               NA                NA
#> 2              0.9510769    NA       NA               NA                NA
#> 3              0.8932024    NA       NA               NA                NA
#> 4              0.8070154    NA       NA               NA                NA
#> 5              0.7957280    NA       NA               NA                NA
#> 6              0.7608615    NA       NA               NA                NA
#> 7              0.7608615    NA       NA               NA                NA
#> 8              0.7367010    NA       NA               NA                NA
#> 9              0.7367010    NA       NA               NA                NA
#> 10             0.7367010    NA       NA               NA                NA
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
orcid_doi(dois="10.1087/20120404")
#> [[1]]
#> <Orcid DOI Search> 10.1087/20120404
#> Found: 8
#> Size: 8 X 36
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                   (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1            14.6007440    NA       NA               NA                NA
#> 2             8.2594280    NA       NA               NA                NA
#> 3             8.2594280    NA       NA               NA                NA
#> 4             7.2269993    NA       NA               NA                NA
#> 5             6.3223076    NA       NA               NA                NA
#> 6             5.0578460    NA       NA               NA                NA
#> 7             2.0648570    NA       NA               NA                NA
#> 8             0.9125465    NA       NA               NA                NA
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
#> Found: 337792
#> Size: 5 X 34
#> 
#>   relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                   (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1             0.9108731    NA       NA               NA                NA
#> 2             0.7970139    NA       NA               NA                NA
#> 3             0.7584557    NA       NA               NA                NA
#> 4             0.7204461    NA       NA               NA                NA
#> 5             0.6943043    NA       NA               NA                NA
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
```

Function is vectorized, search for many DOIs


```r
dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
       "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
res <- orcid_doi(dois = dois, fuzzy = TRUE)
res[[1]]
#> <Orcid DOI Search> 10.1371/journal.pone.0025995
#> Found: 52203
#> Size: 10 X 34
#> 
#>    relevancy-score.value orcid orcid-id orcid-deprecated orcid-preferences
#>                    (dbl) (lgl)    (lgl)            (lgl)             (lgl)
#> 1              0.2359032    NA       NA               NA                NA
#> 2              0.1839927    NA       NA               NA                NA
#> 3              0.1626281    NA       NA               NA                NA
#> 4              0.1593424    NA       NA               NA                NA
#> 5              0.1593424    NA       NA               NA                NA
#> 6              0.1593424    NA       NA               NA                NA
#> 7              0.1593424    NA       NA               NA                NA
#> 8              0.1593424    NA       NA               NA                NA
#> 9              0.1593424    NA       NA               NA                NA
#> 10             0.1593424    NA       NA               NA                NA
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
