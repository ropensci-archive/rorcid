\name{orcid_id}
\alias{orcid_id}
\title{Get data for particular known ORCID ID's.}
\usage{
  orcid_id(orcid = NULL, profile = NULL,
    url = "http://pub.orcid.org/")
}
\arguments{
  \item{orcid}{Orcid identifier(s), of the form
  XXXX-XXXX-XXXX-XXXX.}

  \item{profile}{Bibliographic ("bio"), biographical
  ("works"), or both ("both", the default).}

  \item{url}{Base url for the Orcid API.}
}
\description{
  Get data for particular known ORCID ID's.
}
\examples{
\dontrun{
orcid_id(orcid = "0000-0002-9341-7985")
orcid_id(orcid = "0000-0003-1620-1408")
orcid_id(orcid = "0000-0002-9341-7985", profile="works")
ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
orcid_id(orcid = ids)
}
}

