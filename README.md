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
## Found: 1852
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.9232098    NA   NA         NA          NA
## 2              0.6675839    NA   NA         NA          NA
## 3              0.5302841    NA   NA         NA          NA
## 4              0.3359427    NA   NA         NA          NA
## 5              0.3359427    NA   NA         NA          NA
## 6              0.3359427    NA   NA         NA          NA
## 7              0.3359427    NA   NA         NA          NA
## 8              0.3179941    NA   NA         NA          NA
## 9              0.3047090    NA   NA         NA          NA
## 10             0.3004127    NA   NA         NA          NA
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
## Found: 14336
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4488344    NA   NA         NA          NA
## 2              0.4264817    NA   NA         NA          NA
## 3              0.4264817    NA   NA         NA          NA
## 4              0.3762426    NA   NA         NA          NA
## 5              0.3420991    NA   NA         NA          NA
## 6              0.3224936    NA   NA         NA          NA
## 7              0.3162280    NA   NA         NA          NA
## 8              0.3155793    NA   NA         NA          NA
## 9              0.2876258    NA   NA         NA          NA
## 10             0.2845103    NA   NA         NA          NA
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
## Found: 8083
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4283037    NA   NA         NA          NA
## 2              0.3922417    NA   NA         NA          NA
## 3              0.3889824    NA   NA         NA          NA
## 4              0.3758213    NA   NA         NA          NA
## 5              0.3758213    NA   NA         NA          NA
## 6              0.3503630    NA   NA         NA          NA
## 7              0.3489999    NA   NA         NA          NA
## 8              0.3305446    NA   NA         NA          NA
## 9              0.3236298    NA   NA         NA          NA
## 10             0.3205927    NA   NA         NA          NA
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
## Found: 14336
## Size: 3 X 20
## 
##   relevancy-score.value orcid type group-type client-type
## 1             0.4264817    NA   NA         NA          NA
## 2             0.3762426    NA   NA         NA          NA
## 3             0.3420991    NA   NA         NA          NA
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
## Found: 7251
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              1.1052549    NA   NA         NA          NA
## 2              0.8615595    NA   NA         NA          NA
## 3              0.8529003    NA   NA         NA          NA
## 4              0.8238084    NA   NA         NA          NA
## 5              0.8238084    NA   NA         NA          NA
## 6              0.7976490    NA   NA         NA          NA
## 7              0.7976490    NA   NA         NA          NA
## 8              0.7976490    NA   NA         NA          NA
## 9              0.7976490    NA   NA         NA          NA
## 10             0.7976490    NA   NA         NA          NA
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
## 1             15.598203    NA   NA         NA          NA
## 2              7.799101    NA   NA         NA          NA
## 3              5.514798    NA   NA         NA          NA
## 4              3.446748    NA   NA         NA          NA
## 5              2.412724    NA   NA         NA          NA
## 6              2.068049    NA   NA         NA          NA
## 7              1.206362    NA   NA         NA          NA
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
## Found: 142186
## Size: 5 X 23
## 
##   relevancy-score.value orcid type group-type client-type
## 1             0.8769926    NA   NA         NA          NA
## 2             0.7673686    NA   NA         NA          NA
## 3             0.7316575    NA   NA         NA          NA
## 4             0.6997792    NA   NA         NA          NA
## 5             0.6806173    NA   NA         NA          NA
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
## Found: 20250
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2388659    NA   NA         NA          NA
## 2              0.2130148    NA   NA         NA          NA
## 3              0.1844762    NA   NA         NA          NA
## 4              0.1844762    NA   NA         NA          NA
## 5              0.1844762    NA   NA         NA          NA
## 6              0.1844762    NA   NA         NA          NA
## 7              0.1844762    NA   NA         NA          NA
## 8              0.1844762    NA   NA         NA          NA
## 9              0.1739258    NA   NA         NA          NA
## 10             0.1597611    NA   NA         NA          NA
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
## Found: 20250
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2049937    NA   NA         NA          NA
## 2              0.1775297    NA   NA         NA          NA
## 3              0.1775297    NA   NA         NA          NA
## 4              0.1775297    NA   NA         NA          NA
## 5              0.1775297    NA   NA         NA          NA
## 6              0.1775297    NA   NA         NA          NA
## 7              0.1775297    NA   NA         NA          NA
## 8              0.1673766    NA   NA         NA          NA
## 9              0.1537453    NA   NA         NA          NA
## 10             0.1537453    NA   NA         NA          NA
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
## Found: 20250
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2049937    NA   NA         NA          NA
## 2              0.1775297    NA   NA         NA          NA
## 3              0.1775297    NA   NA         NA          NA
## 4              0.1775297    NA   NA         NA          NA
## 5              0.1775297    NA   NA         NA          NA
## 6              0.1775297    NA   NA         NA          NA
## 7              0.1775297    NA   NA         NA          NA
## 8              0.1673766    NA   NA         NA          NA
## 9              0.1537453    NA   NA         NA          NA
## 10             0.1537453    NA   NA         NA          NA
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
## Found: 20250
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2049937    NA   NA         NA          NA
## 2              0.1775297    NA   NA         NA          NA
## 3              0.1775297    NA   NA         NA          NA
## 4              0.1775297    NA   NA         NA          NA
## 5              0.1775297    NA   NA         NA          NA
## 6              0.1775297    NA   NA         NA          NA
## 7              0.1775297    NA   NA         NA          NA
## 8              0.1673766    NA   NA         NA          NA
## 9              0.1537453    NA   NA         NA          NA
## 10             0.1537453    NA   NA         NA          NA
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
