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
orcid(query="carl boettiger")
```

```
## <Orcid Search>
## Found: 1855
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.9234848    NA   NA         NA          NA
## 2              0.6679252    NA   NA         NA          NA
## 3              0.5304063    NA   NA         NA          NA
## 4              0.3357780    NA   NA         NA          NA
## 5              0.3357780    NA   NA         NA          NA
## 6              0.3357780    NA   NA         NA          NA
## 7              0.3357780    NA   NA         NA          NA
## 8              0.3178382    NA   NA         NA          NA
## 9              0.3048648    NA   NA         NA          NA
## 10             0.3005663    NA   NA         NA          NA
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
orcid(query="johnson cardiology houston")
```

```
## <Orcid Search>
## Found: 14378
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4486007    NA   NA         NA          NA
## 2              0.4262581    NA   NA         NA          NA
## 3              0.4262581    NA   NA         NA          NA
## 4              0.3760210    NA   NA         NA          NA
## 5              0.3418958    NA   NA         NA          NA
## 6              0.3223037    NA   NA         NA          NA
## 7              0.3160153    NA   NA         NA          NA
## 8              0.3154018    NA   NA         NA          NA
## 9              0.2874330    NA   NA         NA          NA
## 10             0.2843205    NA   NA         NA          NA
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
orcid("johnson AND(caltech OR 'California Institute of Technology')")
```

```
## <Orcid Search>
## Found: 8109
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4280611    NA   NA         NA          NA
## 2              0.3920543    NA   NA         NA          NA
## 3              0.3887491    NA   NA         NA          NA
## 4              0.3756414    NA   NA         NA          NA
## 5              0.3756414    NA   NA         NA          NA
## 6              0.3501675    NA   NA         NA          NA
## 7              0.3487746    NA   NA         NA          NA
## 8              0.3303856    NA   NA         NA          NA
## 9              0.3234574    NA   NA         NA          NA
## 10             0.3204387    NA   NA         NA          NA
## Variables not shown: orcid-identifier.value (lgl), orcid-identifier.uri
##      (chr), orcid-identifier.path (chr), orcid-identifier.host (chr),
##      delegation (lgl), applications (lgl), scope (lgl),
##      personal-details.given-names.value (chr),
##      personal-details.family-name.value (chr),
##      personal-details.other-names.other-name (list),
##      personal-details.other-names.visibility (lgl),
##      personal-details.credit-name.value (chr),
##      personal-details.credit-name.visibility (lgl), keywords.keyword
##      (list), keywords.visibility (lgl),
##      external-identifiers.external-identifier (list),
##      external-identifiers.visibility (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl), biography.value
##      (chr), biography.visibility (lgl), researcher-urls.researcher-url
##      (list), researcher-urls.visibility (lgl)
```

And you can use start and rows arguments to do pagination


```r
orcid("johnson cardiology houston", start = 2, rows = 3)
```

```
## <Orcid Search>
## Found: 14378
## Size: 3 X 20
## 
##   relevancy-score.value orcid type group-type client-type
## 1             0.4262581    NA   NA         NA          NA
## 2             0.3760210    NA   NA         NA          NA
## 3             0.3418958    NA   NA         NA          NA
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
## Found: 7277
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              1.1044426    NA   NA         NA          NA
## 2              0.8609262    NA   NA         NA          NA
## 3              0.8522734    NA   NA         NA          NA
## 4              0.8232029    NA   NA         NA          NA
## 5              0.8232029    NA   NA         NA          NA
## 6              0.7970628    NA   NA         NA          NA
## 7              0.7970628    NA   NA         NA          NA
## 8              0.7970628    NA   NA         NA          NA
## 9              0.7970628    NA   NA         NA          NA
## 10             0.7970628    NA   NA         NA          NA
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
## Found: 7
## Size: 7 X 29
## 
##   relevancy-score.value orcid type group-type client-type
## 1             15.564414    NA   NA         NA          NA
## 2              7.782207    NA   NA         NA          NA
## 3              5.502852    NA   NA         NA          NA
## 4              3.439282    NA   NA         NA          NA
## 5              2.407497    NA   NA         NA          NA
## 6              2.063569    NA   NA         NA          NA
## 7              1.203749    NA   NA         NA          NA
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
## Found: 142542
## Size: 5 X 23
## 
##   relevancy-score.value orcid type group-type client-type
## 1             0.8759063    NA   NA         NA          NA
## 2             0.7664180    NA   NA         NA          NA
## 3             0.7307531    NA   NA         NA          NA
## 4             0.6989205    NA   NA         NA          NA
## 5             0.6797787    NA   NA         NA          NA
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
orcid_doi(dois=dois, fuzzy = TRUE)
```

```
## [[1]]
## <Orcid DOI Search> 10.1371/journal.pone.0025995
## Found: 20331
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2388277    NA   NA         NA          NA
## 2              0.2124870    NA   NA         NA          NA
## 3              0.1840191    NA   NA         NA          NA
## 4              0.1840191    NA   NA         NA          NA
## 5              0.1840191    NA   NA         NA          NA
## 6              0.1840191    NA   NA         NA          NA
## 7              0.1840191    NA   NA         NA          NA
## 8              0.1840191    NA   NA         NA          NA
## 9              0.1734949    NA   NA         NA          NA
## 10             0.1593652    NA   NA         NA          NA
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
##      external-identifiers.visibility (lgl), biography.value (chr),
##      biography.visibility (lgl), researcher-urls.researcher-url (list),
##      researcher-urls.visibility (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl)
## 
## [[2]]
## <Orcid DOI Search> 10.1371/journal.pone.0053712
## Found: 20331
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2044838    NA   NA         NA          NA
## 2              0.1770882    NA   NA         NA          NA
## 3              0.1770882    NA   NA         NA          NA
## 4              0.1770882    NA   NA         NA          NA
## 5              0.1770882    NA   NA         NA          NA
## 6              0.1770882    NA   NA         NA          NA
## 7              0.1770882    NA   NA         NA          NA
## 8              0.1669603    NA   NA         NA          NA
## 9              0.1533629    NA   NA         NA          NA
## 10             0.1533629    NA   NA         NA          NA
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
##      keywords.visibility (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl)
## 
## [[3]]
## <Orcid DOI Search> 10.1371/journal.pone.0054608
## Found: 20331
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2044838    NA   NA         NA          NA
## 2              0.1770882    NA   NA         NA          NA
## 3              0.1770882    NA   NA         NA          NA
## 4              0.1770882    NA   NA         NA          NA
## 5              0.1770882    NA   NA         NA          NA
## 6              0.1770882    NA   NA         NA          NA
## 7              0.1770882    NA   NA         NA          NA
## 8              0.1669603    NA   NA         NA          NA
## 9              0.1533629    NA   NA         NA          NA
## 10             0.1533629    NA   NA         NA          NA
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
##      keywords.visibility (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl)
## 
## [[4]]
## <Orcid DOI Search> 10.1371/journal.pone.0055937
## Found: 20331
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2044838    NA   NA         NA          NA
## 2              0.1770882    NA   NA         NA          NA
## 3              0.1770882    NA   NA         NA          NA
## 4              0.1770882    NA   NA         NA          NA
## 5              0.1770882    NA   NA         NA          NA
## 6              0.1770882    NA   NA         NA          NA
## 7              0.1770882    NA   NA         NA          NA
## 8              0.1669603    NA   NA         NA          NA
## 9              0.1533629    NA   NA         NA          NA
## 10             0.1533629    NA   NA         NA          NA
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
##      keywords.visibility (lgl), contact-details.email (list),
##      contact-details.address.country.value (chr),
##      contact-details.address.country.visibility (lgl)
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rorcid/issues)
* License: MIT
* Get citation information for `rorcid` in R doing `citation(package = 'rorcid')`

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
