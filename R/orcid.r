#' Search for ORCID id's.
#' 
#' @import RCurl XML plyr
#' @param query Search terms
#' @param start Result number to start on.
#' @param rows Numer of results to return.
#' @param qf ??
#' @param defType Query syntax. See Details for more.
#' @details You can use any of the following within the query statement: given-names,
#' 		family-name, credit-name, other-names, email, grant-number, patent-number,
#' 		keyword, worktitle, digital-objectids, current-institution, affiliation-name,
#' 		current-primary-institution, text, or past-institution. 
#' 		
#' 		More details on defType from Orcid: "All query syntaxes available in 
#' 		SOLR 3.6 are supported, including Lucene (with Solr extensions) which is 
#' 		the default, DisMax and Extended Dismax. For most users the default syntax 
#' 		will work fine and no need worry about the difference between those three. 
#' 		A range of sophisticated search engine features are available for those 
#' 		who need them; several examples are shown below."
#' @examples \dontrun{
#' # You can string together many search terms
#' orcid(query="johnson+cardiology+houston")
#' 
#' # And use boolean operators
#' orcid("johnson+AND(caltech+OR+'California+Institute+of+Technology')")
#' 
#' # And you can use start and rows arguments to do pagination
#' orcid("johnson+cardiology+houston", start = 2, rows = 3)
#' 
#' # Use search terms, here family name
#' orcid("family-name:Sanchez", start = 4, rows = 6)
#' 
#' # Use search terms, here...
#' orcid(query="Raymond", start=0, rows=10, defType="edismax")
#' 
#' # Search by DOI
#' orcid("10.1087/20120404")
#' 
#' # Search by text type
#' orcid("text:English")
#' }
#' @export
orcid <- function(query = NULL, qf = NULL, start = NULL, rows = NULL, defType = NULL,
	url = "http://pub.orcid.org/search/orcid-bio")
{
	args <- compact(list(httpAccept = 'application/orcid+xml',
											 q = query, qf = qf, start = start, rows = rows, 
											 defType = defType))
  out <- getForm(url, .params = args)
  tt <- xmlParse(out)
	toget <- c("orcid", "creation-method", "completion-date", "submission-date",
						 "claimed", "email-verified", "given-names", "family-name", "external-id-orcid",
						 "external-id-common-name", "external-id-reference", "external-id-url")
	all <- xmlToList(tt)[[1]]
	out <- llply(all, function(x) unlist(x, recursive=T))
	namefields <- function(x){
		temp <- sapply(strsplit(names(x), "\\."), function(y) y[length(y)])
		ttt <- data.frame(t(x))
		names(ttt) <- temp
		ttt
	}
	out2 <- llply(out, namefields)
	df <- do.call(rbind.fill, out2)
	df[order(df$`relevancy-score`, decreasing=F),]
}