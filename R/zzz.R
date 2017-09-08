ocom <- function(l) Filter(Negate(is.null), l)

orcid_base <- function() "https://pub.orcid.org/v2.0"

orc_GET <- function(url, args = list(), ...) {
  cli <- crul::HttpClient$new(
    url = url,
    opts = list(...),
    headers = list(
      Accept = "application/json",
      `User-Agent` = orcid_ua(),
      'X-USER-AGENT' = orcid_ua()
    )
  )
  res <- cli$get(query = args)
  errs(res)
  res$parse("UTF-8") 
}

orcid_ua <- function() {
  versions <- c(
    paste0("r-curl/", utils::packageVersion("curl")),
    paste0("crul/", utils::packageVersion("crul")),
    sprintf("rOpenSci(rorcid/%s)", utils::packageVersion("rorcid"))
  )
  paste0(versions, collapse = " ")
}

errs <- function(x) {
  if (x$status_code > 201) {
    xx <- jsonlite::fromJSON(x$parse("UTF-8"))
    if ("error-desc" %in% names(xx)) {
      # match by status code
      fun <- match_err(x$status_code)$new()
      fun$mssg <- gsub("\\\"", "", xx$`error-desc`$value)
      fun$do_verbose(x)
    } else {
      # if no error message in response, just general stop
      fauxpas::http(x)
    }
  }
}

match_err <- function(code) {
  tmp <- paste0("fauxpas::",
                grep("HTTP*", getNamespaceExports("fauxpas"), value = TRUE))
  fxns <- lapply(tmp, function(x) eval(parse(text = x)))
  codes <- vapply(fxns, function(z) z$public_fields$status_code, 1)
  fxns[[which(code == codes)]]
}

fuzzydoi <- function(x, fuzzy = FALSE) {
  if (fuzzy) {
    x
  } else {
    sprintf("digital-object-ids:\"%s\"", x)
  }
}

orc_parse <- function(x){
  out <- jsonlite::fromJSON(x, TRUE, flatten = TRUE)
  df <- tibble::as_data_frame(out$`orcid-search-results`$`orcid-search-result`)
  names(df) <- gsub("orcid-profile\\.|orcid-profile\\.orcid-bio\\.", "", names(df))
  attr(df, "found") <- out$`orcid-search-results`$`num-found`
  df
}

# From the plyr package
failwith <- function(default = NULL, f, quiet = FALSE) {
  f <- match.fun(f)
  function(...) try_default(f(...), default, quiet = quiet)
}

# From the plyr package
try_default <- function(expr, default, quiet = FALSE) {
  result <- default
  if (quiet) {
    tryCatch(result <- expr, error = function(e) {
    })
  }
  else {
    try(result <- expr)
  }
  result
}

pluck <- function(x, name, type) {
  if (missing(type)) {
    lapply(x, "[[", name)
  } else {
    vapply(x, "[[", name, FUN.VALUE = type)
  }
}

pop <- function(x, name) x[ !names(x) %in% name ]
