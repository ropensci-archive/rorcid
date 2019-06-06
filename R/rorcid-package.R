#' @title A programmatic R interface the Orcid.org API
#' 
#' @description 
#' A R interface to the Orcid public API. \pkg{rorcid} is not a product 
#' developed or distributed by ORCID.
#' 
#' ORCID website: <https://orcid.org/>
#' 
#' Orcid API docs:
#' 
#' - http://members.orcid.org/api
#' - https://pub.orcid.org/v3.0/#/Development_Public_API_v3.0
#' 
#' \pkg{rorcid} has the following main user facing methods:
#' 
#' - [as.orcid()] - coerce various inputs to ORCID class 
#' - [browse()] - browse to a profile in your default browser
#' - [check_dois()] - check that strings are likely to be DOIs
#' - [identifiers()] - grab identifiers out of various objects
#' - [orcid()] - Search for ORCID id's
#' - [orcid_doi()] - Search by DOI
#' - [orcid_id()] - Search by ORCID id, and get either bio, 
#'  profile, or works
#' - [works()] - Parse out works from various objects
#' 
#' @section API routes not implemented:
#' 
#' Not quite sure what these do so haven't messed with them.
#' 
#' - `/{orcid}/notification-permission/{id}`
#' - `/client/{client_id}`
#' - `/group-id-record`
#' - `/group-id-record/{putCode}`
#' 
#' @section Rate Limits:
#' Definitions:
#' 
#' - Request a second - Number of request that can be made a second. 
#'  Value: 8 per second (24 with API v2rc+)
#' - Burst - Number of request we will allow to be queued before rejecting.
#'  The request in the queue are slowed down at the request a second rate.
#'  Value: 40 (same with API v2rc+)
#' 
#' If you exceed the burst, you'll get a 503 responses. Developers should do
#' their best to avoid approaching those limits.
#' 
#' @seealso [rorcid-auth] for Authentication information
#' 
#' @importFrom httr oauth_app oauth_endpoint oauth2.0_token add_headers
#' @importFrom crul HttpClient
#' @importFrom fauxpas http find_error_class
#' @importFrom jsonlite fromJSON
#' @name rorcid-package
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
NULL


#' Lookup table for search fields
#' 
#' @name fields
#' @docType data
#' @keywords data
NULL

#' Lookup vector for journal titles by ISSN
#' 
#' named vector of journal titles. the values are journal titles and 
#' the names are ISSN's.
#' 
#' length: 57,968
#' 
#' data collected on 2018-06-13 from Crossref
#' 
#' @name issn_title
#' @docType data
#' @keywords data
NULL


#' Defunct functions in rorcid
#'
#' - [summary.or_cid()]: Function is gone. Deemed not really 
#'  that useful, and hard to maintain given other changes in the package.
#'
#' @name rorcid-defunct
NULL
