<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{Introduction to the rorcid package}
%\VignetteEncoding{UTF-8}
-->



`rorcid` is an R programmatic interface to the Orcid public API. `rorcid` is not a product developed or distributed by ORCID®.

Orcid API docs:

* Public API docs: http://members.orcid.org/api
* Swagger docs: https://api.orcid.org/v2.1/

The package now works with the `v2.1` ORCID API now. It's too complicated to allow users to work with different versions of the API, so it's hard-coded to `v2.1`.

## Package API

 - `orcid_search`
 - `orcid_external_identifiers`
 - `orcid_auth`
 - `orcid`
 - `identifiers`
 - `orcid_activities`
 - `orcid_employments`
 - `orcid_bio`
 - `works`
 - `orcid_fundings`
 - `orcid_doi`
 - `orcid_researcher_urls`
 - `orcid_id`
 - `orcid_email`
 - `orcid_keywords`
 - `orcid_peer_reviews`
 - `orcid_ping`
 - `browse`
 - `orcid_person`
 - `as.orcid`
 - `check_dois`
 - `orcid_address`
 - `orcid_educations`
 - `orcid_other_names`
 - `orcid_works`


## Installation

Install from CRAN


```r
install.packages("rorcid")
```

Or install the development version from GitHub


```r
devtools::install_github("ropensci/rorcid")
```

Load rorcid


```r
library("rorcid")
```

## as.orcid

There's a function `as.orcid()` in this package to help coerce an Orcid ID to an object that holds details for that Orcid ID, prints a nice summary, and you can browse easily to that profile. E.g.


```r
as.orcid(x = "0000-0002-1642-628X")
#> <ORCID> 0000-0002-1642-628X
#>   Name: Boettiger, Carl
#>   URL (first): http://www.carlboettiger.info
#>   Country: US
#>   Keywords: Ecology, Evolution, Regime Shifts, Stochastic Dynamics
```

Or you can pass in many IDs


```r
as.orcid(c("0000-0003-1620-1408", "0000-0002-9341-7985"))
#> [[1]]
#> <ORCID> 0000-0003-1620-1408
#>   Name: Johnson, Thomas
#>   URL (first): 
#>   Country: US
#>   Keywords: 
#> 
#> [[2]]
#> <ORCID> 0000-0002-9341-7985
#>   Name: Binfield, Peter
#>   URL (first): 
#>   Country: US
#>   Keywords:
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
#> # A tibble: 6 x 27
#>   `put-code` type    visibility path      `display-index` `created-date.v…
#> *      <int> <chr>   <chr>      <chr>     <chr>                      <dbl>
#> 1    5296064 JOURNA… PUBLIC     /0000-00… 0                  1362713629019
#> 2    5296065 JOURNA… PUBLIC     /0000-00… 0                  1362713629025
#> 3    5296066 JOURNA… PUBLIC     /0000-00… 0                  1362713629032
#> 4    9012984 JOURNA… PUBLIC     /0000-00… 0                  1369326854424
#> 5    9012985 JOURNA… PUBLIC     /0000-00… 0                  1369326854429
#> 6    9012986 JOURNA… PUBLIC     /0000-00… 0                  1369326854433
#> # ... with 21 more variables: `last-modified-date.value` <dbl>,
#> #   `source.source-client-id` <lgl>, `source.source-orcid.uri` <chr>,
#> #   `source.source-orcid.path` <chr>, `source.source-orcid.host` <chr>,
#> #   `source.source-name.value` <chr>, title.subtitle <lgl>,
#> #   `title.translated-title` <lgl>, title.title.value <chr>,
#> #   `external-ids.external-id` <list>,
#> #   `publication-date.media-type` <lgl>,
#> #   `publication-date.year.value` <chr>,
#> #   `publication-date.month.value` <chr>,
#> #   `publication-date.day.value` <chr>, `publication-date.day` <lgl>,
#> #   `external-ids` <lgl>, `publication-date` <lgl>,
#> #   `source.source-orcid` <lgl>, `source.source-client-id.uri` <chr>,
#> #   `source.source-client-id.path` <chr>,
#> #   `source.source-client-id.host` <chr>
```

## Search Orcid

Get a list of names and Orcid IDs matching a name query


```r
orcid(query = "carl boettiger")
#> # A tibble: 100 x 3
#>    `orcid-identifier.uri`                `orcid-identifi… `orcid-identifi…
#>  * <chr>                                 <chr>            <chr>           
#>  1 https://orcid.org/0000-0002-1642-628X 0000-0002-1642-… orcid.org       
#>  2 https://orcid.org/0000-0002-3554-5196 0000-0002-3554-… orcid.org       
#>  3 https://orcid.org/0000-0002-5951-4503 0000-0002-5951-… orcid.org       
#>  4 https://orcid.org/0000-0002-7462-1956 0000-0002-7462-… orcid.org       
#>  5 https://orcid.org/0000-0003-1021-5374 0000-0003-1021-… orcid.org       
#>  6 https://orcid.org/0000-0002-8885-5438 0000-0002-8885-… orcid.org       
#>  7 https://orcid.org/0000-0002-4791-6222 0000-0002-4791-… orcid.org       
#>  8 https://orcid.org/0000-0003-2119-4097 0000-0003-2119-… orcid.org       
#>  9 https://orcid.org/0000-0002-3141-3057 0000-0002-3141-… orcid.org       
#> 10 https://orcid.org/0000-0002-2171-9124 0000-0002-2171-… orcid.org       
#> # ... with 90 more rows
```

You can string together many search terms


```r
orcid(query = "johnson cardiology houston")
#> # A tibble: 100 x 3
#>    `orcid-identifier.uri`                `orcid-identifi… `orcid-identifi…
#>  * <chr>                                 <chr>            <chr>           
#>  1 https://orcid.org/0000-0002-0897-2301 0000-0002-0897-… orcid.org       
#>  2 https://orcid.org/0000-0002-5281-4466 0000-0002-5281-… orcid.org       
#>  3 https://orcid.org/0000-0001-8188-0078 0000-0001-8188-… orcid.org       
#>  4 https://orcid.org/0000-0002-4968-6272 0000-0002-4968-… orcid.org       
#>  5 https://orcid.org/0000-0002-1918-5792 0000-0002-1918-… orcid.org       
#>  6 https://orcid.org/0000-0001-9667-1615 0000-0001-9667-… orcid.org       
#>  7 https://orcid.org/0000-0003-0945-6138 0000-0003-0945-… orcid.org       
#>  8 https://orcid.org/0000-0002-9503-6836 0000-0002-9503-… orcid.org       
#>  9 https://orcid.org/0000-0001-5156-0356 0000-0001-5156-… orcid.org       
#> 10 https://orcid.org/0000-0003-2447-553X 0000-0003-2447-… orcid.org       
#> # ... with 90 more rows
```

And you can use start and rows arguments to do pagination


```r
orcid("johnson cardiology houston", start = 2, rows = 3)
#> # A tibble: 3 x 3
#>   `orcid-identifier.uri`                `orcid-identifie… `orcid-identifi…
#> * <chr>                                 <chr>             <chr>           
#> 1 https://orcid.org/0000-0001-8188-0078 0000-0001-8188-0… orcid.org       
#> 2 https://orcid.org/0000-0002-4968-6272 0000-0002-4968-6… orcid.org       
#> 3 https://orcid.org/0000-0002-1918-5792 0000-0002-1918-5… orcid.org
```

## Search by Orcid ID


```r
out <- orcid_id(orcid = "0000-0002-9341-7985")
out$`0000-0002-9341-7985`$addresses
#> $`last-modified-date`
#> $`last-modified-date`$value
#> [1] 1.465227e+12
#> 
#> 
#> $address
#>   visibility                               path put-code display-index
#> 1     PUBLIC /0000-0002-9341-7985/address/89515    89515             0
#>   created-date.value last-modified-date.value source.source-client-id
#> 1       1.453659e+12             1.465227e+12                      NA
#>                 source.source-orcid.uri source.source-orcid.path
#> 1 https://orcid.org/0000-0002-9341-7985      0000-0002-9341-7985
#>   source.source-orcid.host source.source-name.value country.value
#> 1                orcid.org           Peter Binfield            US
#> 
#> $path
#> [1] "/0000-0002-9341-7985/address"
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
#> # A tibble: 6 x 3
#>   `orcid-identifier.uri`                `orcid-identifie… `orcid-identifi…
#> * <chr>                                 <chr>             <chr>           
#> 1 https://orcid.org/0000-0003-1603-8743 0000-0003-1603-8… orcid.org       
#> 2 https://orcid.org/0000-0002-2123-6317 0000-0002-2123-6… orcid.org       
#> 3 https://orcid.org/0000-0002-5993-8592 0000-0002-5993-8… orcid.org       
#> 4 https://orcid.org/0000-0003-3188-6273 0000-0003-3188-6… orcid.org       
#> 5 https://orcid.org/0000-0001-5109-3700 0000-0001-5109-3… orcid.org       
#> 6 https://orcid.org/0000-0003-1419-2405 0000-0003-1419-2… orcid.org       
#> 
#> attr(,"class")
#> [1] "orcid_doi"
```

This DOI is not a real one, but a partial DOI, then we can fuzzy search


```r
orcid_doi(dois = "10.1087/2", fuzzy = TRUE, rows = 5)
#> [[1]]
#> # A tibble: 5 x 3
#>   `orcid-identifier.uri`                `orcid-identifie… `orcid-identifi…
#> * <chr>                                 <chr>             <chr>           
#> 1 https://orcid.org/0000-0001-6081-0708 0000-0001-6081-0… orcid.org       
#> 2 https://orcid.org/0000-0001-6971-1351 0000-0001-6971-1… orcid.org       
#> 3 https://orcid.org/0000-0002-6298-6771 0000-0002-6298-6… orcid.org       
#> 4 https://orcid.org/0000-0002-5360-2529 0000-0002-5360-2… orcid.org       
#> 5 https://orcid.org/0000-0002-5528-4704 0000-0002-5528-4… orcid.org       
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
#> # A tibble: 100 x 3
#>    `orcid-identifier.uri`                `orcid-identifi… `orcid-identifi…
#>  * <chr>                                 <chr>            <chr>           
#>  1 https://orcid.org/0000-0002-0051-973X 0000-0002-0051-… orcid.org       
#>  2 https://orcid.org/0000-0002-5634-6145 0000-0002-5634-… orcid.org       
#>  3 https://orcid.org/0000-0001-8887-5095 0000-0001-8887-… orcid.org       
#>  4 https://orcid.org/0000-0002-3583-1248 0000-0002-3583-… orcid.org       
#>  5 https://orcid.org/0000-0002-6840-2167 0000-0002-6840-… orcid.org       
#>  6 https://orcid.org/0000-0003-4683-9648 0000-0003-4683-… orcid.org       
#>  7 https://orcid.org/0000-0003-1655-9549 0000-0003-1655-… orcid.org       
#>  8 https://orcid.org/0000-0002-3654-8137 0000-0002-3654-… orcid.org       
#>  9 https://orcid.org/0000-0002-3584-9915 0000-0002-3584-… orcid.org       
#> 10 https://orcid.org/0000-0001-9404-7069 0000-0001-9404-… orcid.org       
#> # ... with 90 more rows
```

## Get formatted citations for an ORCID ID

One workflow is to get publications associated with an ORCID profile. The following will extract all the works with a DOI, then use the `rcrossref` package to get nicely formatted references for each, and then export them to a bibtex file


```r
my_dois <- rorcid::identifiers(rorcid::works("0000-0002-0337-5997"))
pubs <- rcrossref::cr_cn(dois = my_dois, format = "bibtex")
invisible(lapply(pubs, write, "pubs.bib", append=TRUE))
```


