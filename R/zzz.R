ocom <- function(l) Filter(Negate(is.null), l)

orcid_base <- function() "http://pub.orcid.org/v1.2"

orc_GET <- function(url, args=list(), ...) {
  tt <- GET(url, query = args, accept('application/orcid+json'), ...)
  stop_for_status(tt)
  content(tt, "text", encoding = "UTF-8")
}

orc_GET_err <- function(url, args=list(), ...) {
  tt <- GET(url, query = args, accept('application/orcid+json'), ...)
  handle_error(tt)
  content(tt, "text", encoding = "UTF-8")
}

handle_error <- function(x) {
  if (x$status_code > 201) {
    msg <- jsonlite::fromJSON(content(x, "text", encoding = "UTF-8"))
    stop(x$status_code, " - ", msg$`error-desc`$value, call. = FALSE)
  }
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
  obj <- list(found = out$`orcid-search-results`$`num-found`, 
              data = out$`orcid-search-results`$`orcid-search-result`)
  obj$data <- setNames(obj$data, gsub("orcid-profile\\.|orcid-profile\\.orcid-bio\\.", "", names(obj$data)))
  obj
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
