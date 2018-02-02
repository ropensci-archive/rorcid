ocom <- function(l) Filter(Negate(is.null), l)

orcid_base <- function() "https://pub.orcid.org/v2.1"

ojson <- "application/vnd.orcid+json; qs=4"

orc_GET <- function(url, args = list(), ctype = ojson, ...) {
  cli <- crul::HttpClient$new(
    url = url,
    # opts = list(...),
    headers = list(
      Accept = ctype,
      `User-Agent` = orcid_ua(),
      'X-USER-AGENT' = orcid_ua(),
      Authorization = orcid_auth()
    )
  )
  res <- cli$get(query = args)
  errs(res)
  res$parse("UTF-8") 
}

check_key <- function() {
  x <- Sys.getenv("ORCID_TOKEN", "")
  if (x == "") {
    x <- getOption("orcid_token", "")
  }
  if (x == "") NULL else x
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
    if ("error-code" %in% names(xx)) {
      # match by status code
      fun <- match_err(x$status_code)$new()
      fun$mssg <- xx$`developer-message`
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
  df <- tibble::as_data_frame(out$result)
  # names(df) <- gsub("orcid-profile\\.|orcid-profile\\.orcid-bio\\.", "", names(df))
  attr(df, "found") <- out$`num-found`
  return(df)
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

orcid_prof_helper <- function(x, path, ctype = ojson, ...) {
  url2 <- file.path(orcid_base(), x, path)
  out <- orc_GET(url2, ctype = ctype, ...)
  switch_parser(ctype, out)
}

switch_parser <- function(ctype, x) {
  switch(
    ctype,
    `application/vnd.orcid+xml; qs=5` = px(x), 
    `application/orcid+xml; qs=3` = px(x), 
    `application/xml` = px(x), 
    `application/vnd.orcid+json; qs=4` = pj(x), 
    `application/orcid+json; qs=2` = pj(x), 
    `application/json` = pj(x), 
    `application/vnd.citationstyles.csl+json` = pj(x),
    stop("no parser found for ", ctype)
  )
}

pj <- function(z) jsonlite::fromJSON(z, flatten = TRUE)
px <- function(z) xml2::read_xml(z)

orcid_putcode_helper <- function(path, orcid, put_code, format, ...) {
  if (!is.null(put_code)) {
    if (length(orcid) > 1) {
      stop("if 'put_code' is given, 'orcid' must be length 1")
    }
  }
  pth <- if (is.null(put_code)) path else file.path(path, put_code)
  if (length(pth) > 1) {
    stats::setNames(
      Map(function(z) orcid_prof_helper(orcid, z, ctype = format), pth), 
      put_code)
  } else {
    nmd <- if (!is.null(put_code)) put_code else orcid
    stats::setNames(
      lapply(orcid, orcid_prof_helper, path = pth, ctype = format, ...), nmd)
  }
}

