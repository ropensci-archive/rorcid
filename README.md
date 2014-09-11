[![Build Status](https://api.travis-ci.org/ropensci/rorcid.png)](https://travis-ci.org/ropensci/rorcid)
[![Build status](https://ci.appveyor.com/api/projects/status/vphls55n8h01o8fj/branch/master)](https://ci.appveyor.com/project/sckott/floras/branch/master)

[![image](https://raw.github.com/ropensci/rorcid/master/orcid_64x64.png)](http://orcid.org)

# `rorcid`

`rorcid` is an R programmatic interface to the Orcid public API. `rorcid` is not a product developed or distributed by ORCID®.

Install using `install_github` from [Hadley Wickham's devtools package](http://github.com/hadley/devtools).

```R
install.packages("devtools")
require(devtools)
install_github("rorcid", "rOpenSci")
require(rorcid)
```

+ [Orcid API docs](http://support.orcid.org/knowledgebase/articles/116874-orcid-api-guide)

+ `rorcid` is part of the rOpenSci project, [click to find out more](http://ropensci.org/)

+ Hopefully various web services will start integrating Orcid ID's into their API services so that e.g., you could disambiguate authors with similar names from the [Mendeley API](URL). We will keep a list of them here:
	+ [ScienceCard](http://sciencecard.org)
		+ An example call: [http://sciencecard.org/api/v3/users/0000-0002-1642-628X?info=summary](http://sciencecard.org/api/v3/users/0000-0002-1642-628X?info=summary)
