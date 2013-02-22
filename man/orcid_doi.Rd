\name{orcid_doi}
\alias{orcid_doi}
\title{Search for ORCID ID's using just DOIs.}
\usage{
  orcid_doi(dois = NULL, start = NULL, rows = NULL,
    fuzzy = FALSE)
}
\arguments{
  \item{dois}{Digital object identifier (DOI), a vector fo
  DOIs.}

  \item{start}{Result number to start on. Keep in mind that
  pages start at 0.}

  \item{rows}{Numer of results to return.}

  \item{fuzzy}{Use fuzzy matching on input DOIs. Defaults
  to FALSE. If FALSE, we stick "digital-object-ids" before
  the DOI so that the search sent to ORCID is for that
  exact DOI. If TRUE, we use some regex to find the DOI.}
}
\description{
  Search for ORCID ID's using just DOIs.
}
\details{
  XXXX
}
\examples{
\dontrun{
orcid_doi(dois="10.1087/20120404", fuzzy=TRUE)
orcid_doi(dois="10.1087/20120404", fuzzy=FALSE) # fuzzy is FALSE by default

# This DOI is not a real one, but a partial DOI, then we can fuzzy search
orcid_doi(dois="10.1087/2", fuzzy=TRUE, rows=20) # get more than the defualt 10 records (or rows)

# If you don't input proper DOIs, the function will get mad
dois=c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712","10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
dois=c("10.1016/j.medpal.2008.12.005","10.1080/00933104.2000.10505926","10.1037/a0024480","10.1002/anie.196603172","2344","asdf","232","asdf","23dd")
orcid_doi(dois=dois)

orcid_doi(dois="10.1087/20120404", fuzzy=FALSE) # works
orcid_doi(dois="10.1371/journal.pone.0025995", fuzzy=FALSE) # doesn't work
}
}

