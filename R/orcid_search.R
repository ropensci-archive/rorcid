#' Orcid search - more user friendly than [orcid()]
#' 
#' @export
#' @param given_name (character) given name
#' @param family_name (character) family name
#' @param past_inst (character) past institution
#' @param current_prim_inst (character) current primary institution
#' @param current_inst (character) current institution
#' @param credit_name (character) credit name
#' @param other_name (character) other name
#' @param email (character) email
#' @param digital_object_ids (character) digital object ids
#' @param work_title (character) work title
#' @param grant_number (character) grant number
#' @param patent_number (character) patent number
#' @param keywords (character) keywords to search
#' @param text (character) text to search
#' @param rows (integer) number of records to return
#' @param start (integer) record number to start at
#' @param ... curl options passed on to [crul::HttpClient]
#' @seealso [orcid()]
#' @return a `data.frame` with three columns: 
#' 
#' - first: given name
#' - last: family name
#' - orcid: ORCID identifier
#' 
#' @details The goal of this function is to make a human friendly
#' way to search ORCID. 
#' 
#' Thus, internally we map the parameters given to this function 
#' to the actual parameters that ORCID wants that are not 
#' so human friendly.
#' 
#' @section How parameters are combined:
#' We combine multiple parameters with `AND`, such that 
#' e.g., `given_name="Jane"` and `family_name="Doe"` gets passed 
#' to ORCID as `given-names:Jane AND family-name:Doe`
#' 
#' @examples \dontrun{
#' orcid_search(given_name = "carl", family_name = "boettiger")
#' orcid_search(given_name = "carl")
#' 
#' orcid_search(given_name = "carl", rows = 2)
#' 
#' orcid_search(given_name = "carl", verbose = TRUE)
#' }
orcid_search <- function(given_name = NULL, family_name = NULL, 
    past_inst = NULL, current_prim_inst = NULL, current_inst = NULL, 
    credit_name = NULL, other_name = NULL, email = NULL, 
    digital_object_ids = NULL, work_title = NULL, grant_number = NULL, 
    patent_number = NULL, keywords = NULL, text = NULL, rows = 10, 
    start = NULL, ...) {

  query <- ocom(list(given_name = given_name, family_name = family_name, 
    past_inst = past_inst, current_prim_inst = current_prim_inst, 
    current_inst = current_inst,
    credit_name = credit_name, other_name = other_name, email = email, 
    digital_object_ids = digital_object_ids, work_title = work_title, 
    grant_number = grant_number, patent_number = patent_number, 
    keywords = keywords, text = text))
  if (length(query) == 0) stop("must pass at least one param")
  names(query) <- vapply(names(query), function(z) field_match_list[[z]], "")

  # by default, combine with 'AND'
  query <- paste(names(query), unname(query), sep = ":", collapse = " AND ")

  tt <- orcid(query = query, rows = rows, start = start, ...)
  as_dt(lapply(tt$`orcid-identifier.path`, function(w) {
    rr <- orcid_id(w)
    data.frame(
      first = rr[[1]]$name$`given-names`$value %||% NA_character_,
      last = rr[[1]]$name$`family-name`$value %||% NA_character_,
      orcid = w,
      stringsAsFactors = FALSE
    )
  }))
}

field_match_list <- list(
  orcid = 'orcid',
  given_name = 'given-names',
  family_name = 'family-name',
  past_inst = 'past-institution-affiliation-name',
  current_prim_inst = 'current-primary-institution-affiliation-name',
  current_inst = 'current-institution-affiliation-name',
  credit_name = 'credit-name',
  other_name = 'other-names',
  email = 'email',
  digital_object_ids = 'digital-object-ids',
  work_title = 'work-titles',
  grant_number = 'grant-numbers',
  patent_number = 'patent-numbers',
  keywords = 'keywords',
  text = 'text'
)
