rorcid
======

[![Build Status](https://api.travis-ci.org/ropensci/rorcid.png)](https://travis-ci.org/ropensci/rorcid)
[![Build status](https://ci.appveyor.com/api/projects/status/29hanha8jfe4uen8/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/rorcid/branch/master)

`rorcid` is an R programmatic interface to the Orcid public API. `rorcid` is not a product developed or distributed by ORCID®.

[Orcid API docs](http://support.orcid.org/knowledgebase/articles/132354-searching-with-the-public-api)

## Installation


```r
install.packages("devtools")
devtools::install_github("ropensci/rorcid")
```


```r
library('rorcid')
```

## Search Orcid

Get a list of names and Orcid IDs matching a name query


```r
orcid(query="carl+boettiger")
```

```
## <Orcid Search>
## Found: 1842
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.9225469    NA   NA         NA          NA
## 2              0.6665400    NA   NA         NA          NA
## 3              0.5300450    NA   NA         NA          NA
## 4              0.3367504    NA   NA         NA          NA
## 5              0.3367504    NA   NA         NA          NA
## 6              0.3367504    NA   NA         NA          NA
## 7              0.3367504    NA   NA         NA          NA
## 8              0.3187587    NA   NA         NA          NA
## 9              0.3042325    NA   NA         NA          NA
## 10             0.2999430    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl), researcher-urls.researcher-url (list),
##      researcher-urls.visibility (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl),
##      external-identifiers.external-identifier (list),
##      external-identifiers.visibility (lgl)
```

You can string together many search terms


```r
orcid(query="johnson+cardiology+houston")
```

```
## <Orcid Search>
## Found: 14287
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4489328    NA   NA         NA          NA
## 2              0.4265880    NA   NA         NA          NA
## 3              0.4265880    NA   NA         NA          NA
## 4              0.3765330    NA   NA         NA          NA
## 5              0.3420485    NA   NA         NA          NA
## 6              0.3227426    NA   NA         NA          NA
## 7              0.3164982    NA   NA         NA          NA
## 8              0.3157548    NA   NA         NA          NA
## 9              0.2879193    NA   NA         NA          NA
## 10             0.2848599    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl), researcher-urls.researcher-url
##      (list), researcher-urls.visibility (lgl),
##      external-identifiers.external-identifier (list),
##      external-identifiers.visibility (lgl)
```

And use boolean operators


```r
orcid("johnson+AND(caltech+OR+'California+Institute+of+Technology')")
```

```
## <Orcid Search>
## Found: 291969
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.7797481    NA   NA         NA          NA
## 2              0.5777802    NA   NA         NA          NA
## 3              0.4998535    NA   NA         NA          NA
## 4              0.4479071    NA   NA         NA          NA
## 5              0.4292156    NA   NA         NA          NA
## 6              0.3984009    NA   NA         NA          NA
## 7              0.3895665    NA   NA         NA          NA
## 8              0.3602871    NA   NA         NA          NA
## 9              0.3532453    NA   NA         NA          NA
## 10             0.3521410    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl), researcher-urls.researcher-url (list),
##      researcher-urls.visibility (lgl), keywords.keyword (list),
##      keywords.visibility (lgl), external-identifiers.external-identifier
##      (list), external-identifiers.visibility (lgl), contact-details.email
##      (list), contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl)
```

And you can use start and rows arguments to do pagination


```r
orcid("johnson+cardiology+houston", start = 2, rows = 3)
```

```
## <Orcid Search>
## Found: 14287
## Size: 3 X 20
## 
##   relevancy-score.value orcid type group-type client-type
## 1             0.4265880    NA   NA         NA          NA
## 2             0.3765330    NA   NA         NA          NA
## 3             0.3420485    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr), biography.value (chr),
##      biography.visibility (lgl), keywords.keyword (list),
##      keywords.visibility (lgl), researcher-urls.researcher-url (list),
##      researcher-urls.visibility (lgl)
```

Search specific fields. here, by text type


```r
orcid("text:English")
```

```
## <Orcid Search>
## Found: 7208
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              1.1058309    NA   NA         NA          NA
## 2              0.8620084    NA   NA         NA          NA
## 3              0.8533447    NA   NA         NA          NA
## 4              0.8242377    NA   NA         NA          NA
## 5              0.8242377    NA   NA         NA          NA
## 6              0.7980647    NA   NA         NA          NA
## 7              0.7980647    NA   NA         NA          NA
## 8              0.7980647    NA   NA         NA          NA
## 9              0.7980647    NA   NA         NA          NA
## 10             0.7980647    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      researcher-urls.researcher-url (list), researcher-urls.visibility
##      (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl)
```

## Search by Orcid ID


```r
out <- orcid_id(orcid = "0000-0002-9341-7985")
out$`0000-0002-9341-7985`$`orcid-identifier`
```

```
## $value
## NULL
## 
## $uri
## [1] "http://orcid.org/0000-0002-9341-7985"
## 
## $path
## [1] "0000-0002-9341-7985"
## 
## $host
## [1] "orcid.org"
```

Get specific thing, either bibliographic ("bio"), biographical ("works"), profile ("profile"), or record ("record")


```r
out <- orcid_id(orcid = "0000-0002-9341-7985", profile="works")
out$`0000-0002-9341-7985`$`orcid-history`
```

```
## $`creation-method`
## [1] "WEBSITE"
## 
## $`completion-date`
## $`completion-date`$value
## [1] 1.350393e+12
## 
## 
## $`submission-date`
## $`submission-date`$value
## [1] 1.350388e+12
## 
## 
## $`last-modified-date`
## $`last-modified-date`$value
## [1] 1.422034e+12
## 
## 
## $claimed
## $claimed$value
## [1] TRUE
## 
## 
## $source
## NULL
## 
## $visibility
## NULL
```

The function is vectorized, so you can pass in many Orcids


```r
ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
lapply(orcid_id(orcid = ids), "[[", "orcid-identifier")
```

```
## $`0000-0003-1620-1408`
## $`0000-0003-1620-1408`$value
## NULL
## 
## $`0000-0003-1620-1408`$uri
## [1] "http://orcid.org/0000-0003-1620-1408"
## 
## $`0000-0003-1620-1408`$path
## [1] "0000-0003-1620-1408"
## 
## $`0000-0003-1620-1408`$host
## [1] "orcid.org"
## 
## 
## $`0000-0002-9341-7985`
## $`0000-0002-9341-7985`$value
## NULL
## 
## $`0000-0002-9341-7985`$uri
## [1] "http://orcid.org/0000-0002-9341-7985"
## 
## $`0000-0002-9341-7985`$path
## [1] "0000-0002-9341-7985"
## 
## $`0000-0002-9341-7985`$host
## [1] "orcid.org"
```

## Search by DOIs

Basic search


```r
orcid_doi(dois="10.1087/20120404")
```

```
## [[1]]
## <Orcid DOI Search> 10.1087/20120404
## Found: 2612
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              1.6680659    NA   NA         NA          NA
## 2              0.8340329    NA   NA         NA          NA
## 3              0.5897504    NA   NA         NA          NA
## 4              0.3785656    NA   NA         NA          NA
## 5              0.3685940    NA   NA         NA          NA
## 6              0.2839242    NA   NA         NA          NA
## 7              0.2839242    NA   NA         NA          NA
## 8              0.2839242    NA   NA         NA          NA
## 9              0.2839242    NA   NA         NA          NA
## 10             0.2839242    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl), contact-details.email
##      (list), contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl),
##      external-identifiers.external-identifier (list),
##      external-identifiers.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl), researcher-urls.researcher-url (list),
##      researcher-urls.visibility (lgl)
```

This DOI is not a real one, but a partial DOI, then we can fuzzy search


```r
orcid_doi(dois="10.1087/2", fuzzy=TRUE, rows=5)
```

```
## [[1]]
## <Orcid DOI Search> 10.1087/2
## Found: 141722
## Size: 5 X 23
## 
##   relevancy-score.value orcid type group-type client-type
## 1             0.8774559    NA   NA         NA          NA
## 2             0.7677739    NA   NA         NA          NA
## 3             0.7320425    NA   NA         NA          NA
## 4             0.7001424    NA   NA         NA          NA
## 5             0.6809732    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl)
```

Function is vectorized, search for many DOIs


```r
dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712",
       "10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
orcid_doi(dois=dois)
```

```
## [[1]]
## <Orcid DOI Search> 10.1371/journal.pone.0025995
## Found: 20163
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.5070944    NA   NA         NA          NA
## 2              0.4904418    NA   NA         NA          NA
## 3              0.3433093    NA   NA         NA          NA
## 4              0.3433093    NA   NA         NA          NA
## 5              0.2799933    NA   NA         NA          NA
## 6              0.2799933    NA   NA         NA          NA
## 7              0.2580368    NA   NA         NA          NA
## 8              0.2496179    NA   NA         NA          NA
## 9              0.2452209    NA   NA         NA          NA
## 10             0.2452209    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl),
##      external-identifiers.external-identifier (list),
##      external-identifiers.visibility (lgl), researcher-urls.researcher-url
##      (list), researcher-urls.visibility (lgl), contact-details.email
##      (list), contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), biography.value
##      (chr), biography.visibility (lgl)
## 
## [[2]]
## <Orcid DOI Search> 10.1371/journal.pone.0053712
## Found: 20163
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4808797    NA   NA         NA          NA
## 2              0.3366158    NA   NA         NA          NA
## 3              0.3366158    NA   NA         NA          NA
## 4              0.2745343    NA   NA         NA          NA
## 5              0.2745343    NA   NA         NA          NA
## 6              0.2530058    NA   NA         NA          NA
## 7              0.2447511    NA   NA         NA          NA
## 8              0.2404399    NA   NA         NA          NA
## 9              0.2404399    NA   NA         NA          NA
## 10             0.2404399    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl),
##      researcher-urls.researcher-url (list), researcher-urls.visibility
##      (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl),
##      external-identifiers.external-identifier (list),
##      external-identifiers.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl)
## 
## [[3]]
## <Orcid DOI Search> 10.1371/journal.pone.0054608
## Found: 20163
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4808797    NA   NA         NA          NA
## 2              0.3366158    NA   NA         NA          NA
## 3              0.3366158    NA   NA         NA          NA
## 4              0.2745343    NA   NA         NA          NA
## 5              0.2745343    NA   NA         NA          NA
## 6              0.2530058    NA   NA         NA          NA
## 7              0.2447511    NA   NA         NA          NA
## 8              0.2404399    NA   NA         NA          NA
## 9              0.2404399    NA   NA         NA          NA
## 10             0.2404399    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl),
##      researcher-urls.researcher-url (list), researcher-urls.visibility
##      (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl),
##      external-identifiers.external-identifier (list),
##      external-identifiers.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl)
## 
## [[4]]
## <Orcid DOI Search> 10.1371/journal.pone.0055937
## Found: 20163
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4808797    NA   NA         NA          NA
## 2              0.3366158    NA   NA         NA          NA
## 3              0.3366158    NA   NA         NA          NA
## 4              0.2745343    NA   NA         NA          NA
## 5              0.2745343    NA   NA         NA          NA
## 6              0.2530058    NA   NA         NA          NA
## 7              0.2447511    NA   NA         NA          NA
## 8              0.2404399    NA   NA         NA          NA
## 9              0.2404399    NA   NA         NA          NA
## 10             0.2404399    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl),
##      researcher-urls.researcher-url (list), researcher-urls.visibility
##      (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl),
##      external-identifiers.external-identifier (list),
##      external-identifiers.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl)
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rorcid/issues)
* License: MIT
* Get citation information for `rorcid` in R doing `citation(package = 'rorcid')`

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
