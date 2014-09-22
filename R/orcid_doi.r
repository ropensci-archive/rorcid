#' Search for ORCID ID's using just DOIs.
#' 
#' @import RCurl XML plyr
#' @export
#' 
#' @param dois Digital object identifier (DOI), a vector fo DOIs.
#' @param start Result number to start on. Keep in mind that pages start at 0.
#' @param rows Numer of results to return.
#' @param fuzzy Use fuzzy matching on input DOIs. Defaults to FALSE. If FALSE, 
#' 		we stick "digital-object-ids" before the DOI so that the search sent to 
#' 		ORCID is for that exact DOI. If TRUE, we use some regex to find the DOI.
#' @details XXXX
#' @examples \dontrun{
#' orcid_doi(dois="10.1087/20120404", fuzzy=TRUE)
#' orcid_doi(dois="10.1087/20120404", fuzzy=FALSE) # fuzzy is FALSE by default
#' 
#' # This DOI is not a real one, but a partial DOI, then we can fuzzy search
#' orcid_doi(dois="10.1087/2", fuzzy=TRUE, rows=20) # get more than the defualt 10 records (or rows)
#' 
#' # If you don't input proper DOIs, the function will get mad
#' dois=c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712","10.1371/journal.pone.0054608","10.1371/journal.pone.0055937")
#' dois=c("10.1016/j.medpal.2008.12.005","10.1080/00933104.2000.10505926","10.1037/a0024480","10.1002/anie.196603172","2344","asdf","232","asdf","23dd")
#' orcid_doi(dois=dois)
#' 
#' orcid_doi(dois="10.1087/20120404", fuzzy=FALSE) # works
#' orcid_doi(dois="10.1371/journal.pone.0025995", fuzzy=FALSE) # doesn't work
#' }

orcid_doi <- function(dois = NULL, start = NULL, rows = NULL, fuzzy = FALSE)
{
	# verify doi's are given
	doi_pattern <- "\\b(10[.][0-9]{4,}(?:[.][0-9]+)*/(?:(?![\"&\'<>])\\S)+)\\b"
	check <- sapply(dois, function(x) grepl(doi_pattern, x, perl=TRUE) )
	if(!all(check)){
		stop(paste("The following are not DOIs:\n", paste(dois[!check],collapse="\n ")))
	} else {NULL}
	
	url = "http://pub.orcid.org/search/orcid-bio"
	
	getdata <- function(x){
		if(fuzzy){x <- x} else {x <- paste("digital-object-ids:%22", x, "%22", sep="")}
		url2 <- paste0(url, "/?q=", x)
		args <- compact(list(httpAccept='application/orcid+xml',start=start,rows=rows))
		out <- getForm(url2, .params = args)
		tt <- xmlParse(out)
		toget <- c("relevancy-score","orcid", "creation-method", "completion-date", "submission-date",
							 "claimed", "email-verified", "given-names", "family-name", "external-id-orcid",
							 "external-id-common-name", "external-id-reference", "external-id-url")
		all <- xmlToList(tt)
		out <- llply(all[[2]], function(x) unlist(x, recursive=TRUE))
		namefields <- function(x){
			temp <- sapply(strsplit(names(x), "\\."), function(y) y[length(y)])
			ttt <- data.frame(t(x))
			names(ttt) <- temp
			ttt
		}
		out2 <- llply(out, namefields)
		df <- do.call(rbind.fill, out2)
    df <- df[order(df$`relevancy-score`, decreasing=FALSE),c("relevancy-score","path","given-names","family-name")]
		df[complete.cases(df),]
	}
	
	getdata_safe <- plyr::failwith(NULL,getdata)
	llply(dois, getdata_safe)
}