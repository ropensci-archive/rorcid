rorcid
======



<!-- badges: start -->
[![R build status](https://github.com/ropensci/rorcid/workflows/R-CMD-check/badge.svg)](https://github.com/ropensci/rorcid/actions?workflow=R-CMD-check)
[![cran checks](https://cranchecks.info/badges/worst/rorcid)](https://cranchecks.info/pkgs/rorcid)
[![codecov.io](https://codecov.io/github/ropensci/rorcid/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rorcid?branch=master)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/rorcid?color=2ED968)](https://github.com/metacran/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/rorcid)](https://cran.r-project.org/package=rorcid)
<!-- badges: end -->

`rorcid` is an R programmatic interface to the Orcid public API. `rorcid` is not a product developed or distributed by ORCID®.

Orcid API docs:

* Public API docs: https://members.orcid.org/api
* Swagger docs: https://pub.orcid.org/v3.0/#/Development_Public_API_v3.0

The package now works with the `v3.0` ORCID API. It's too complicated to allow users to work with different versions of the API, so it's hard-coded to `v3.0`.

## Authentication

There are two ways to authenticate with `rorcid`:

- Use a token as a result of a OAuth authentication process. The token
is a alphanumeric UUID, e.g. `dc0a6b6b-b4d4-4276-bc89-78c1e9ede56e`. You
can get this token by running `orcid_auth()`, then storing that key
(the uuid alone, not the "Bearer " part) either as en environment
variable called `ORCID_TOKEN` in your `.Renviron` file in your home directory,
or as an R option in your `.Rprofile` file (called `orcid_token`).
See `?Startup` for more information.
Either an environment variable or R option work. If we don't find
either we do the next option.
- Interactively login with OAuth. We use a client id and client secret 
key to ping ORCID.org; at which point you log in with your username/password; 
then we get back a token (same as the above option). We don't know your 
username or password, only the token that we get back. We cache that 
token locally in a hidden file in whatever working directory you're in. 
If you delete that file, or run the code from a new working directory, 
then we re-authorize.

We recommend the former option. That is, get a token and store it as an
environment variable.

If both options above fail, we proceed without using authentication.
ORCID does not require authentication at this point, but may in the future -
this prepares you for when that happens :)

See https://members.orcid.org/api/oauth/orcid-scopes for more about ORCID 
OAuth Scopes.

## Computing environments without browsers

One pitfall is when you are using `rorcid` on a server, and you're ssh'ed
in, so that there's no way to open a browser to do the OAuth browser
flow. Similarly for any other situation in which a browser can not be
opened. In this case, run `orcid_auth()` on another machine in which you do
have the ability to open a browser, then collect the info that's ouptput
from `orcid_auth()` and store it as an environment variable (see above).

## Installation

Stable version


```r
install.packages("rorcid")
```

Development version


```r
remotes::install_github("ropensci/rorcid")
```


```r
library('rorcid')
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

The `works()` function helps get works data from an orcid data object. The output of `works()` is a data.frame


```r
(out <- works(orcid_id("0000-0002-0233-1757")))
#> # A tibble: 6 x 32
#>   `put-code` url   type  `journal-title` visibility path  `display-index`
#> *      <int> <lgl> <chr> <lgl>           <chr>      <chr> <chr>          
#> 1    5296064 NA    jour… NA              public     /000… 0              
#> 2    5296065 NA    jour… NA              public     /000… 0              
#> 3    5296066 NA    jour… NA              public     /000… 0              
#> 4    9012984 NA    jour… NA              public     /000… 0              
#> 5    9012985 NA    jour… NA              public     /000… 0              
#> 6    9012986 NA    jour… NA              public     /000… 0              
#> # … with 25 more variables: `created-date.value` <dbl>,
#> #   `last-modified-date.value` <dbl>, `source.source-client-id` <lgl>,
#> #   `source.assertion-origin-orcid` <lgl>,
#> #   `source.assertion-origin-client-id` <lgl>,
#> #   `source.assertion-origin-name` <lgl>, `source.source-orcid.uri` <chr>,
#> #   `source.source-orcid.path` <chr>, `source.source-orcid.host` <chr>,
#> #   `source.source-name.value` <chr>, title.subtitle <lgl>,
#> #   `title.translated-title` <lgl>, title.title.value <chr>,
#> #   `external-ids.external-id` <list>, `publication-date.year.value` <chr>,
#> #   `publication-date.month.value` <chr>, `publication-date.day.value` <chr>,
#> #   `publication-date.day` <lgl>, `external-ids` <lgl>,
#> #   `publication-date` <lgl>, `source.source-orcid` <lgl>,
#> #   `source.source-client-id.uri` <chr>, `source.source-client-id.path` <chr>,
#> #   `source.source-client-id.host` <chr>, url.value <chr>
```

## Search Orcid

Get a list of names and Orcid IDs matching a name query


```r
orcid(query = "carl boettiger")
#> # A tibble: 100 x 3
#>    `orcid-identifier.uri`            `orcid-identifier.pa… `orcid-identifier.ho…
#>  * <chr>                             <chr>                 <chr>                
#>  1 https://orcid.org/0000-0002-1642… 0000-0002-1642-628X   orcid.org            
#>  2 https://orcid.org/0000-0002-3554… 0000-0002-3554-5196   orcid.org            
#>  3 https://orcid.org/0000-0002-5951… 0000-0002-5951-4503   orcid.org            
#>  4 https://orcid.org/0000-0003-1853… 0000-0003-1853-1574   orcid.org            
#>  5 https://orcid.org/0000-0002-7462… 0000-0002-7462-1956   orcid.org            
#>  6 https://orcid.org/0000-0002-7790… 0000-0002-7790-5102   orcid.org            
#>  7 https://orcid.org/0000-0003-1021… 0000-0003-1021-5374   orcid.org            
#>  8 https://orcid.org/0000-0001-8899… 0000-0001-8899-7850   orcid.org            
#>  9 https://orcid.org/0000-0001-7084… 0000-0001-7084-5402   orcid.org            
#> 10 https://orcid.org/0000-0001-9705… 0000-0001-9705-4766   orcid.org            
#> # … with 90 more rows
```

You can string together many search terms


```r
orcid(query = "johnson cardiology houston")
#> # A tibble: 100 x 3
#>    `orcid-identifier.uri`            `orcid-identifier.pa… `orcid-identifier.ho…
#>  * <chr>                             <chr>                 <chr>                
#>  1 https://orcid.org/0000-0002-0897… 0000-0002-0897-2301   orcid.org            
#>  2 https://orcid.org/0000-0002-5281… 0000-0002-5281-4466   orcid.org            
#>  3 https://orcid.org/0000-0001-8188… 0000-0001-8188-0078   orcid.org            
#>  4 https://orcid.org/0000-0002-2862… 0000-0002-2862-4160   orcid.org            
#>  5 https://orcid.org/0000-0002-0682… 0000-0002-0682-9982   orcid.org            
#>  6 https://orcid.org/0000-0002-4334… 0000-0002-4334-4001   orcid.org            
#>  7 https://orcid.org/0000-0001-6172… 0000-0001-6172-5804   orcid.org            
#>  8 https://orcid.org/0000-0001-9667… 0000-0001-9667-1615   orcid.org            
#>  9 https://orcid.org/0000-0002-4968… 0000-0002-4968-6272   orcid.org            
#> 10 https://orcid.org/0000-0003-0945… 0000-0003-0945-6138   orcid.org            
#> # … with 90 more rows
```

And use boolean operators


```r
orcid("johnson AND(caltech OR 'California Institute of Technology')")
#> # A tibble: 100 x 3
#>    `orcid-identifier.uri`            `orcid-identifier.pa… `orcid-identifier.ho…
#>  * <chr>                             <chr>                 <chr>                
#>  1 https://orcid.org/0000-0002-0026… 0000-0002-0026-2516   orcid.org            
#>  2 https://orcid.org/0000-0002-3710… 0000-0002-3710-1070   orcid.org            
#>  3 https://orcid.org/0000-0002-3909… 0000-0002-3909-2294   orcid.org            
#>  4 https://orcid.org/0000-0002-7705… 0000-0002-7705-5670   orcid.org            
#>  5 https://orcid.org/0000-0001-6495… 0000-0001-6495-9892   orcid.org            
#>  6 https://orcid.org/0000-0003-4199… 0000-0003-4199-0314   orcid.org            
#>  7 https://orcid.org/0000-0003-0758… 0000-0003-0758-2296   orcid.org            
#>  8 https://orcid.org/0000-0002-2589… 0000-0002-2589-7593   orcid.org            
#>  9 https://orcid.org/0000-0002-7042… 0000-0002-7042-5739   orcid.org            
#> 10 https://orcid.org/0000-0001-9216… 0000-0001-9216-558X   orcid.org            
#> # … with 90 more rows
```

And you can use start and rows arguments to do pagination


```r
orcid("johnson cardiology houston", start = 2, rows = 3)
#> # A tibble: 3 x 3
#>   `orcid-identifier.uri`            `orcid-identifier.pat… `orcid-identifier.ho…
#> * <chr>                             <chr>                  <chr>                
#> 1 https://orcid.org/0000-0001-8188… 0000-0001-8188-0078    orcid.org            
#> 2 https://orcid.org/0000-0002-2862… 0000-0002-2862-4160    orcid.org            
#> 3 https://orcid.org/0000-0002-0682… 0000-0002-0682-9982    orcid.org
```


## Search by Orcid ID


```r
out <- orcid_id(orcid = "0000-0002-9341-7985")
out$`0000-0002-9341-7985`$name
#> $`created-date`
#> $`created-date`$value
#> [1] 1.460762e+12
#> 
#> 
#> $`last-modified-date`
#> $`last-modified-date`$value
#> [1] 1.460762e+12
#> 
#> 
#> $`given-names`
#> $`given-names`$value
#> [1] "Peter"
#> 
#> 
#> $`family-name`
#> $`family-name`$value
#> [1] "Binfield"
#> 
#> 
#> $`credit-name`
#> NULL
#> 
#> $source
#> NULL
#> 
#> $visibility
#> [1] "public"
#> 
#> $path
#> [1] "0000-0002-9341-7985"
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
#> # A tibble: 14 x 3
#>    `orcid-identifier.uri`            `orcid-identifier.pa… `orcid-identifier.ho…
#>  * <chr>                             <chr>                 <chr>                
#>  1 https://orcid.org/0000-0002-3181… 0000-0002-3181-3456   orcid.org            
#>  2 https://orcid.org/0000-0002-1290… 0000-0002-1290-9735   orcid.org            
#>  3 https://orcid.org/0000-0002-6914… 0000-0002-6914-8682   orcid.org            
#>  4 https://orcid.org/0000-0001-5727… 0000-0001-5727-2427   orcid.org            
#>  5 https://orcid.org/0000-0001-7343… 0000-0001-7343-9784   orcid.org            
#>  6 https://orcid.org/0000-0003-3738… 0000-0003-3738-1487   orcid.org            
#>  7 https://orcid.org/0000-0003-0187… 0000-0003-0187-9064   orcid.org            
#>  8 https://orcid.org/0000-0002-2123… 0000-0002-2123-6317   orcid.org            
#>  9 https://orcid.org/0000-0003-1603… 0000-0003-1603-8743   orcid.org            
#> 10 https://orcid.org/0000-0003-3188… 0000-0003-3188-6273   orcid.org            
#> 11 https://orcid.org/0000-0003-0493… 0000-0003-0493-0128   orcid.org            
#> 12 https://orcid.org/0000-0002-5993… 0000-0002-5993-8592   orcid.org            
#> 13 https://orcid.org/0000-0003-1419… 0000-0003-1419-2405   orcid.org            
#> 14 https://orcid.org/0000-0001-5109… 0000-0001-5109-3700   orcid.org            
#> 
#> attr(,"class")
#> [1] "orcid_doi"
```

This DOI is not a real one, but a partial DOI, then we can fuzzy search


```r
orcid_doi(dois = "10.1087/2", fuzzy = TRUE, rows = 5)
#> [[1]]
#> # A tibble: 5 x 3
#>   `orcid-identifier.uri`            `orcid-identifier.pat… `orcid-identifier.ho…
#> * <chr>                             <chr>                  <chr>                
#> 1 https://orcid.org/0000-0001-8701… 0000-0001-8701-615X    orcid.org            
#> 2 https://orcid.org/0000-0001-6081… 0000-0001-6081-0708    orcid.org            
#> 3 https://orcid.org/0000-0001-5919… 0000-0001-5919-8670    orcid.org            
#> 4 https://orcid.org/0000-0002-0634… 0000-0002-0634-3376    orcid.org            
#> 5 https://orcid.org/0000-0001-8959… 0000-0001-8959-3380    orcid.org            
#> 
#> attr(,"class")
#> [1] "orcid_doi"
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rorcid/issues)
* License: MIT
* Get citation information for `rorcid` in R doing `citation(package = 'rorcid')`
* Please note that this project is released with a [Contributor Code of Conduct](https://github.com/ropensci/rorcid/blob/master/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
