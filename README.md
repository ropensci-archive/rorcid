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

## The Orcid class

There's a function `as.orcid()` in this package to help coerce an Orcid ID to an object that holds details for that Orcid ID, prints a nice summary, and you can browse easily to that profile. E.g.


```r
as.orcid(x="0000-0002-1642-628X")
```

```
## <ORCID> 0000-0002-1642-628X
##   Name: Boettiger, Carl
##   URL (first): http://www.carlboettiger.info
##   Country: US
##   Keywords: Ecology, Evolution, Regime Shifts, Stochastic Dynamics
##   Submission date: 2012-11-01 17:57:23
```

You by default get the print method above, but you can use `summary()` as well to get more detailed information. 


```r
summary( as.orcid(x="0000-0002-1642-628X") )
```

```
## <ORCID Summary> 0000-0002-1642-628X
##   Name: Boettiger, Carl
##   URLs:
##      carlboettiger.info: http://www.carlboettiger.info
##   Country: US
##   Keywords: Ecology, Evolution, Regime Shifts, Stochastic Dynamics
```

Or you can pass in many IDs


```r
lapply(c("0000-0003-1620-1408", "0000-0002-9341-7985"), as.orcid)
```

```
## [[1]]
## <ORCID> 0000-0003-1620-1408
##   Name: Johnson, Thomas
##   URL (first): 
##   Country: 
##   Keywords: 
##   Submission date: 2012-10-27 10:33:31
## 
## [[2]]
## <ORCID> 0000-0002-9341-7985
##   Name: Binfield, Peter
##   URL (first): 
##   Country: 
##   Keywords: 
##   Submission date: 2012-10-16 04:39:18
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
```

```
## <WORKS> 0000-0002-0233-1757
## - Dugaw, C & Ram, K, 2011, 'Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite', <i>Oecologia</i>, vol. 27, no. 2, pp. 154-325.
## - Ram, K, Preisser, E, Gruner, D & Strong, D, 2008, 'METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE', <i>Ecology</i>, vol. 38, no. 12, pp. 119-3297.
## - Gruner, D, Ram, K & Strong, D, 2007, 'Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host', <i>Journal of Invertebrate Pathology</i>, vol. 108, no. 6, pp. 167-19.
```

And you can easily get to the entire data.frame of works details


```r
head(out$data)
```

```
##   put-code       work-type url visibility work-title.subtitle
## 1  5296064 JOURNAL_ARTICLE  NA         NA                  NA
## 2  5296065 JOURNAL_ARTICLE  NA         NA                  NA
## 3  5296066 JOURNAL_ARTICLE  NA         NA                  NA
##                                                                             work-title.title.value
## 1 Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite
## 2                  METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE
## 3       Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host
##   work-citation.work-citation-type
## 1            FORMATTED_UNSPECIFIED
## 2            FORMATTED_UNSPECIFIED
## 3            FORMATTED_UNSPECIFIED
##                                                                                                                                                                                      work-citation.citation
## 1                               Dugaw, C & Ram, K, 2011, 'Individual heterogeneity in mortality mediates long-term persistence of a seasonal microparasite', <i>Oecologia</i>, vol. 27, no. 2, pp. 154-325.
## 2                       Ram, K, Preisser, E, Gruner, D & Strong, D, 2008, 'METAPOPULATION DYNAMICS OVERRIDE LOCAL LIMITS ON LONG-TERM PARASITE PERSISTENCE', <i>Ecology</i>, vol. 38, no. 12, pp. 119-3297.
## 3 Gruner, D, Ram, K & Strong, D, 2007, 'Soil mediates the interaction of coexisting entomopathogenic nematodes with an insect host', <i>Journal of Invertebrate Pathology</i>, vol. 108, no. 6, pp. 167-19.
##   publication-date.media-type publication-date.year.value
## 1                          NA                        2011
## 2                          NA                        2008
## 3                          NA                        2007
##   publication-date.month.value publication-date.day.value
## 1                           06                         27
## 2                           12                       <NA>
## 3                           01                       <NA>
##   work-external-identifiers.work-external-identifier
## 1                     DOI, 10.1007/s00442-010-1844-5
## 2                             DOI, 10.1890/08-0228.1
## 3                     DOI, 10.1016/j.jip.2006.08.009
##   work-external-identifiers.scope work-contributors.contributor
## 1                              NA                 FIRST, AUTHOR
## 2                              NA                 FIRST, AUTHOR
## 3                              NA                 FIRST, AUTHOR
##   work-source.value                      work-source.uri
## 1                NA http://orcid.org/0000-0002-0233-1757
## 2                NA http://orcid.org/0000-0002-0233-1757
## 3                NA http://orcid.org/0000-0002-0233-1757
##      work-source.path work-source.host
## 1 0000-0002-0233-1757        orcid.org
## 2 0000-0002-0233-1757        orcid.org
## 3 0000-0002-0233-1757        orcid.org
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
## 1              0.9236004    NA   NA         NA          NA
## 2              0.6680898    NA   NA         NA          NA
## 3              0.5304524    NA   NA         NA          NA
## 4              0.3356696    NA   NA         NA          NA
## 5              0.3356696    NA   NA         NA          NA
## 6              0.3356696    NA   NA         NA          NA
## 7              0.3356696    NA   NA         NA          NA
## 8              0.3177357    NA   NA         NA          NA
## 9              0.3049399    NA   NA         NA          NA
## 10             0.3006404    NA   NA         NA          NA
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
## Found: 14395
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4486277    NA   NA         NA          NA
## 2              0.4262844    NA   NA         NA          NA
## 3              0.4262844    NA   NA         NA          NA
## 4              0.3760541    NA   NA         NA          NA
## 5              0.3418695    NA   NA         NA          NA
## 6              0.3223321    NA   NA         NA          NA
## 7              0.3160213    NA   NA         NA          NA
## 8              0.3154262    NA   NA         NA          NA
## 9              0.2874475    NA   NA         NA          NA
## 10             0.2843460    NA   NA         NA          NA
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
## Found: 8116
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.4279784    NA   NA         NA          NA
## 2              0.3919850    NA   NA         NA          NA
## 3              0.3886528    NA   NA         NA          NA
## 4              0.3755746    NA   NA         NA          NA
## 5              0.3755746    NA   NA         NA          NA
## 6              0.3500442    NA   NA         NA          NA
## 7              0.3486962    NA   NA         NA          NA
## 8              0.3303258    NA   NA         NA          NA
## 9              0.3233610    NA   NA         NA          NA
## 10             0.3203812    NA   NA         NA          NA
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
## Found: 14395
## Size: 3 X 20
## 
##   relevancy-score.value orcid type group-type client-type
## 1             0.4262844    NA   NA         NA          NA
## 2             0.3760541    NA   NA         NA          NA
## 3             0.3418695    NA   NA         NA          NA
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
## Found: 7298
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              1.1042740    NA   NA         NA          NA
## 2              0.8607948    NA   NA         NA          NA
## 3              0.8521434    NA   NA         NA          NA
## 4              0.8230773    NA   NA         NA          NA
## 5              0.8230773    NA   NA         NA          NA
## 6              0.7969412    NA   NA         NA          NA
## 7              0.7969412    NA   NA         NA          NA
## 8              0.7969412    NA   NA         NA          NA
## 9              0.7969412    NA   NA         NA          NA
## 10             0.7969412    NA   NA         NA          NA
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
## 1             15.510747    NA   NA         NA          NA
## 2              7.755374    NA   NA         NA          NA
## 3              5.483877    NA   NA         NA          NA
## 4              3.427423    NA   NA         NA          NA
## 5              2.399196    NA   NA         NA          NA
## 6              2.056454    NA   NA         NA          NA
## 7              1.199598    NA   NA         NA          NA
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
## Found: 142731
## Size: 5 X 23
## 
##   relevancy-score.value orcid type group-type client-type
## 1             0.8755938    NA   NA         NA          NA
## 2             0.7661445    NA   NA         NA          NA
## 3             0.7304925    NA   NA         NA          NA
## 4             0.6986719    NA   NA         NA          NA
## 5             0.6795367    NA   NA         NA          NA
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
## Found: 20373
## Size: 10 X 29
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2388237    NA   NA         NA          NA
## 2              0.2123207    NA   NA         NA          NA
## 3              0.1838751    NA   NA         NA          NA
## 4              0.1838751    NA   NA         NA          NA
## 5              0.1838751    NA   NA         NA          NA
## 6              0.1838751    NA   NA         NA          NA
## 7              0.1838751    NA   NA         NA          NA
## 8              0.1838751    NA   NA         NA          NA
## 9              0.1733592    NA   NA         NA          NA
## 10             0.1592405    NA   NA         NA          NA
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
## Found: 20373
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2043234    NA   NA         NA          NA
## 2              0.1769493    NA   NA         NA          NA
## 3              0.1769493    NA   NA         NA          NA
## 4              0.1769493    NA   NA         NA          NA
## 5              0.1769493    NA   NA         NA          NA
## 6              0.1769493    NA   NA         NA          NA
## 7              0.1769493    NA   NA         NA          NA
## 8              0.1668294    NA   NA         NA          NA
## 9              0.1532426    NA   NA         NA          NA
## 10             0.1532426    NA   NA         NA          NA
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
## Found: 20373
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2043234    NA   NA         NA          NA
## 2              0.1769493    NA   NA         NA          NA
## 3              0.1769493    NA   NA         NA          NA
## 4              0.1769493    NA   NA         NA          NA
## 5              0.1769493    NA   NA         NA          NA
## 6              0.1769493    NA   NA         NA          NA
## 7              0.1769493    NA   NA         NA          NA
## 8              0.1668294    NA   NA         NA          NA
## 9              0.1532426    NA   NA         NA          NA
## 10             0.1532426    NA   NA         NA          NA
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
## Found: 20373
## Size: 10 X 27
## 
##    relevancy-score.value orcid type group-type client-type
## 1              0.2043234    NA   NA         NA          NA
## 2              0.1769493    NA   NA         NA          NA
## 3              0.1769493    NA   NA         NA          NA
## 4              0.1769493    NA   NA         NA          NA
## 5              0.1769493    NA   NA         NA          NA
## 6              0.1769493    NA   NA         NA          NA
## 7              0.1769493    NA   NA         NA          NA
## 8              0.1668294    NA   NA         NA          NA
## 9              0.1532426    NA   NA         NA          NA
## 10             0.1532426    NA   NA         NA          NA
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
