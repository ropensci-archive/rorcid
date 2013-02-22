
#' Get taxonomic hierarchy for a given taxon ID.
#' 
#' @import XML RCurl plyr
#' @param orcid 
#' @param profile 
#' @return orcid info
#' @export
orc <- function(orcid, profile){
	UseMethod("orc")
}

#' @S3method orc default
orc.default <- function(orcid=NULL, profile=NULL, method="short"){
	if(method=="short"){
		out <- rorcid:::orc.short(orcid)
	} else
	{
		out <- rorcid:::orc.full(orcid)		
	}
	return(out)
}

#' @method orc short
#' @export
#' @rdname orc
orc.short <- function(orcid=NULL, profile=NULL)
{
	out <- orcid_id(orcid=orcid, profile=profile)
	out <- out[, c("orcid", "given.names", "family.name")]
	return(out)
}

#' @method orc full
#' @export
#' @rdname orc
orc.full <- function(orcid=NULL, profile=NULL)
{
	out <- orcid_id(orcid=orcid, profile=profile)
	return(out)
}