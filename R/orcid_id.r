#' Get data for particular ORCID ID's.
#' 
#' @import RCurl XML plyr
#' @param orcid Orcid identifier(s), of the form XXXX-XXXX-XXXX-XXXX.
#' @param profile Bibliographic ("bio"), biographical ("works"), or 
#' 		both ("both", the default).
#' @return A data.frame of results.
#' @examples \dontrun{
#' orcid_id(orcid = "0000-0002-9341-7985")
#' orcid_id(orcid = "0000-0002-9341-7985")
#' orcid_id(orcid = "0000-0003-1620-1408")
#' orcid_id(orcid = "0000-0002-9341-7985", profile="works")
#' ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
#' orcid_id(orcid = ids)
#' }
#' @export
orcid_id <- function(orcid = NULL, profile = NULL)
{
	url = "http://pub.orcid.org/"
	
	toget <- c("path", "relevancy-score", "creation-method", "completion-date", "submission-date",
		"claimed", "email-verified", "given-names", "family-name", "external-id-orcid",
		"external-id-common-name", "external-id-reference", "external-id-url")
	
	doit <- function(x) {
		if(!is.null(profile)){
			temp <- match.arg(profile, choices=c("bio", "works", "profile", "record"))
			url2 <- paste(url, x, "/orcid-", temp, sep="")	
		} else
			{ url2 <- paste(url, x, "/orcid-profile", sep="") }
		out <- getURL(url2)
		tt <- xmlParse(out)
		
		# data
		list_ <- compact(lapply(toget, function(y) xpathSApply(tt, paste("//x:",y,sep=""), namespaces="x", fun=xmlValue)))
		removenull <- function(x){ ifelse(identical(x, list()), NA, x) }
		list_2 <- lapply(list_, removenull)
		list_3 <- list_2[!is.na(list_2)]
		
		# data names
		names_ <- compact(lapply(toget, function(y) xpathSApply(tt, paste("//x:",y,sep=""), namespaces="x", fun=xmlName)))
		names_2 <- lapply(names_, removenull)
		names_3 <- names_2[!is.na(names_2)]
		names(list_3) <- names_3
		
		data.frame(list_3)
	}
	out <- ldply(orcid, doit)
	return( out )
}