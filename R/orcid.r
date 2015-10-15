#' Search for ORCID ID's.
#' 
#' @export
#' 
#' @param query Search terms. You can do quite complicated queries using the SOLR 
#' 		syntax. See examples below. For all possible fields to query, do data(fields).
#' @param start Result number to start on. Keep in mind that pages start at 0.
#' @param rows Numer of results to return.
#' @param recursive Keep drilling down until all records are retrieved for the 
#' 		given query, default FALSE (logical). If \code{recursive=TRUE}, rows and start
#' 		parameters are ignored. 
#' @param defType Query syntax. One of edismax or X. See Details for more.
#' @param q.alt If specified, this query will be used (and parsed by default using 
#' 		standard query parsing syntax) when the main query string is not specified 
#' 		or blank. This comes in handy when you need something like a match-all-docs 
#' 		query (don't forget &rows=0 for that one!) in order to get collection-wise 
#' 		faceting counts.
#' @param qf (Query Fields) List of fields and the "boosts" to associate with each 
#' 		of them when building DisjunctionMaxQueries from the user's query
#' @param mm (Minimum 'Should' Match) See the wiki here 
#'    \url{http://wiki.apache.org/solr/ExtendedDisMax#mm_.28Minimum_.27Should.27_Match.29}
#' @param qs (Query Phrase Slop) Amount of slop on phrase queries explicitly 
#' 		included in the user's query string (in qf fields; affects matching).
#' @param pf (Phrase Fields) Once the list of matching documents has been identified 
#' 		using the "fq" and "qf" params, the "pf" param can be used to "boost" the 
#' 		score of documents in cases where all of the terms in the "q" param appear 
#' 		in close proximity. Read more here 
#'   	\url{http://wiki.apache.org/solr/ExtendedDisMax#pf_.28Phrase_Fields.29}
#' @param ps (Phrase Slop) Default amount of slop on phrase queries built with "pf", 
#' 		"pf2" and/or "pf3" fields (affects boosting).
#' @param pf2 (Phrase bigram fields) As with 'pf' but chops the input into bi-grams, 
#' 		e.g. "the brown fox jumped" is queried as "the brown" "brown fox" "fox jumped"
#' @param ps2 (Phrase bigram slop) As with 'ps' but sets default slop factor for 
#' 		'pf2'. If not specified, 'ps' will be used.
#' @param pf3 (Phrase trigram fields) As with 'pf' but chops the input into tri-grams, 
#' 		e.g. "the brown fox jumped" is queried as "the brown fox" "brown fox jumped"
#' @param ps3 (Phrase trigram slop) As with 'ps' but sets default slop factor for 'pf3'. 
#' 		If not specified, 'ps' will be used.
#' @param tie (Tie breaker) Float value to use as tiebreaker in DisjunctionMaxQueries 
#' 		(should be something much less than 1). Read more here 
#'   	\url{http://wiki.apache.org/solr/ExtendedDisMax#tie_.28Tie_breaker.29}
#' @param bq (Boost Query) A raw query string (in the SolrQuerySyntax) that will 
#' 		be included with the user's query to influence the score. Read more here 
#' 		\url{http://wiki.apache.org/solr/ExtendedDisMax#bq_.28Boost_Query.29}
#' @param bf (Boost Function, additive) Functions (with optional boosts) that will 
#' 		be included in the user's query to influence the score. Any function supported 
#' 		natively by Solr can be used, along with a boost value, e.g.: recip(rord(myfield),1,2,3)^1.5
#' 		Read more here 
#'   	\url{http://wiki.apache.org/solr/ExtendedDisMax#bf_.28Boost_Function.2C_additive.29}
#' @param boost (Boost Function, multiplicative) As for 'bf' but multiplies the boost into the 
#'    score
#' @param uf (User Fields) Specifies which schema fields the end user shall be allowed 
#' 		to query for explicitly. This parameter supports wildcards. Read more here
#' 		\url{http://wiki.apache.org/solr/ExtendedDisMax#uf_.28User_Fields.29}
#' @param lowercaseOperators This param controls whether to try to interpret lowercase 
#' 		words as boolean operators such as "and", "not" and "or". Set &lowercaseOperators=true 
#' 		to allow this. Default is "false".
#' @param fuzzy Use fuzzy matching on input DOIs. Defaults to FALSE. If FALSE, 
#' 		we stick "digital-object-ids" before the DOI so that the search sent to 
#' 		ORCID is for that exact DOI. If TRUE, we use some regex to find the DOI.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#'
#' @details You can use any of the following within the query statement: given-names,
#' 		family-name, credit-name, other-names, email, grant-number, patent-number,
#' 		keyword, worktitle, digital-objectids, current-institution, affiliation-name,
#' 		current-primary-institution, text, or past-institution. 
#' 		
#' 		For more complicated queries the ORCID API supports using ExtendedDisMax.
#' 		See the documentation on the web here: \url{http://wiki.apache.org/solr/ExtendedDisMax}.
#' 		
#' 		Note that when constructing queries, you don't need to use syntax like \code{+}, 
#' 		etc., \code{httr}, the curl client we use internally, will do that for you. For example,
#' 		instead of writing \code{johnson+cardiology}, just write \code{johnson cardiology}, and 
#' 		instead of writing \code{johnson+AND+cardiology}, write \code{johnson AND cardiology}. 
#' 		Though, you still need to use \code{AND}, \code{OR}, etc. to join term/queries together.
#' @seealso \code{\link{orcid_doi}} \code{\link{orcid_id}}
#' @examples \dontrun{
#' # Get a list of names and Orcid IDs matching a name query
#' orcid(query="carl+boettiger")
#' orcid(query="given-names:carl AND family-name:boettiger")
#' 
#' # You can string together many search terms
#' orcid(query="johnson cardiology houston")
#' 
#' # And use boolean operators
#' orcid("johnson AND(caltech OR 'California Institute of Technology')")
#' 
#' # And you can use start and rows arguments to do pagination
#' orcid("johnson cardiology houston", start = 2, rows = 3)
#' 
#' # Use search terms, here family name
#' orcid("family-name:Sanchez", start = 4, rows = 6)
#' 
#' # Use search terms, here...
#' orcid(query="Raymond", start=0, rows=10, defType="edismax")
#' 
#' # Search using keywords
#' orcid(query="keyword:ecology")
#' 
#' # Search by DOI
#' orcid(query="10.1087/20120404")
#' 
#' # Note the difference between the first wrt the second and third
#' ## See also orcid_doi() function for searching by DOIs
#' orcid("10.1087/20120404")
#' orcid('"10.1087/20120404"')
#' orcid('digital-object-ids:"10.1087/20120404"')
#'  
#' # Search by text type
#' orcid("text:English")
#' 
#' ## Using more complicated SOLR queries
#' 
#' # Use the qf parameter to "boost" query fields so they are ranked higher
#' # 	See how it is different than the second query without using "qf"
#' orcid(defType = "edismax", query = "Raymond", qf = "given-names^1.0 family-name^2.0", 
#'    start = 0, rows = 10)
#' orcid(query = "Raymond", start = 0, rows = 10)
#' 
#' # Use other SOLR parameters as well, here mm. Using the "mm" param, 1 and 2 word 
#' # 	queries require that all of the optional clauses match, but for queries with 
#' # 	three or more clauses one missing clause is allowed...See for more: http://bit.ly/1uyMLDQ
#' orcid(defType = "edismax", query="keyword:ecology OR evolution OR conservation", 
#'    mm = 2, rows = 20)
#' }

orcid <- function(query = NULL, start = NULL, rows = NULL, recursive = FALSE,
	defType = NULL, q.alt = NULL, qf = NULL, mm = NULL, qs = NULL, pf = NULL,
	ps = NULL, pf2 = NULL, ps2 = NULL, pf3 = NULL, ps3 = NULL, tie = NULL, 
	bq = NULL, bf = NULL, boost = NULL, uf = NULL, lowercaseOperators = NULL, 
	fuzzy = FALSE, ...) {
  
  args <- ocom(list(q = query, start = start, rows = rows, defType = defType, q.alt = q.alt,
                    qf = qf, mm = mm, qs = qs, pf = pf, ps = ps, pf2 = pf2,
                    ps2 = ps2, pf3 = pf3, ps3 = ps3, tie = tie, bq = bq, bf = bf,
                    boost = boost, uf = uf, lowercaseOperators = lowercaseOperators))
  res <- orc_GET_err(paste0(orcid_base(), "/search/orcid-bio"), args, ...)
  structure(orc_parse(res), class = "orcid")
}

#' @export
print.orcid <- function(x, ..., n = 10){
  cat("<Orcid Search>", sep = "\n")
  cat(sprintf("Found: %s", x$found), sep = "\n")
  if (length(x$data) == 0) {
    NULL
  } else {
    cat(sprintf("Size: %s X %s\n", NROW(x$data), NCOL(x$data)), sep = "\n")
    trunc_mat_(x$data, n = n)
  }
}
