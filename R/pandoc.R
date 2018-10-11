# from rmarkdown::find_pandoc 
# https://github.com/rstudio/rmarkdown/blob/master/R/pandoc.R

pandoc_citeproc_convert <- function(file, type = c("list", "json", "yaml"), format = NULL) {

  # ensure we've scanned for pandoc
  find_pandoc()

  # resolve type
  type <- match.arg(type)

  # build the conversion command
  conversion <- switch(type,
    list = "--bib2json",
    json = "--bib2json",
    yaml = "--bib2yaml"
  )
  
  # format
  form <- if (is.null(format)) {
    "" 
  } else {
    format <- switch(format, 
      json = ".json"
    )
    paste0("-f ", format)
  }

  # all args
  args <- c(conversion, form, file)

  # put together all commands
  command <- paste(quoted(pandoc_citeproc()), paste(quoted(args), collapse = " "))

  # run the conversion
  with_pandoc_safe_environment({
    result <- system(command, intern = TRUE)
  })
  status <- attr(result, "status")
  if (!is.null(status)) {
    cat(result, sep = "\n")
    stop("Error ", status, " occurred building shared library.")
  }

  # convert the output if requested
  if (type == "list") {
    jsonlite::fromJSON(result, simplifyVector = FALSE)
  } else {
    result
  }
}

quoted <- function(args) {
  # some characters are legal in filenames but without quoting are likely to be
  # interpreted by the shell (e.g. redirection, wildcard expansion, etc.) --
  # wrap arguments containing these characters in quotes.
  shell_chars <- grepl(.shell_chars_regex, args)
  args[shell_chars] <- shQuote(args[shell_chars])
  args
}

# get the path to the pandoc-citeproc binary
pandoc_citeproc <- function() {
  find_pandoc()
  citeproc_path = file.path(.pandoc$dir, "pandoc-citeproc")
  if (file.exists(citeproc_path)) citeproc_path else "pandoc-citeproc"
}

.shell_chars_regex <- "[ <>()|\\:&;#?*']"

dir_exists <- function(x) {
  utils::file_test("-d", x)
}

find_pandoc <- function() {
  if (is.null(.pandoc$dir)) {
    sys_pandoc <- find_program("pandoc")
    sources <- c(Sys.getenv("RSTUDIO_PANDOC"), ifelse(nzchar(sys_pandoc),
      dirname(sys_pandoc), ""))
    if (!is_windows()) sources <- c(sources, path.expand("~/opt/pandoc"))
    versions <- lapply(sources, function(src) {
      if (dir_exists(src)) get_pandoc_version(src) else numeric_version("0")
    })
    found_src <- NULL
    found_ver <- numeric_version("0")
    for (i in 1:length(sources)) {
      ver <- versions[[i]]
      if (ver > found_ver) {
        found_ver <- ver
        found_src <- sources[[i]]
      }
    }
    if (!is.null(found_src)) {
      .pandoc$dir <- found_src
      .pandoc$version <- found_ver
    }
  }
}

find_program <- function (program) {
  if (is_osx()) {
    res <- suppressWarnings({
      sanitized_path <- gsub("\\", "\\\\", Sys.getenv("PATH"),
          fixed = TRUE)
      sanitized_path <- gsub("\"", "\\\"", sanitized_path,
          fixed = TRUE)
      system(paste0("PATH=\"", sanitized_path, "\" /usr/bin/which ",
          program), intern = TRUE)
    })
    if (length(res) == 0) "" else res
  } else {
    Sys.which(program)
  }
}

get_pandoc_version <- function(pandoc_dir) {
  pandoc_path <- file.path(pandoc_dir, "pandoc")
  if (is_windows()) pandoc_path <- paste0(pandoc_path, ".exe")
  if (!utils::file_test("-x", pandoc_path)) return(numeric_version("0"))
  with_pandoc_safe_environment({
    version_info <- system(paste(shQuote(pandoc_path), "--version"),
                           intern = TRUE)
  })
  version <- strsplit(version_info, "\n")[[1]][1]
  version <- strsplit(version, " ")[[1]][2]
  numeric_version(version)
}


# wrap a system call to pandoc so that LC_ALL is not set
# see: https://github.com/rstudio/rmarkdown/issues/31
# see: https://ghc.haskell.org/trac/ghc/ticket/7344
with_pandoc_safe_environment <- function(code) {
  lc_all <- Sys.getenv("LC_ALL", unset = NA)

  if (!is.na(lc_all)) {
    Sys.unsetenv("LC_ALL")
    on.exit(Sys.setenv(LC_ALL = lc_all), add = TRUE)
  }

  lc_ctype <- Sys.getenv("LC_CTYPE", unset = NA)

  if (!is.na(lc_ctype)) {
    Sys.unsetenv("LC_CTYPE")
    on.exit(Sys.setenv(LC_CTYPE = lc_ctype), add = TRUE)
  }

  if (Sys.info()['sysname'] == "Linux" &&
        is.na(Sys.getenv("HOME", unset = NA))) {
    stop("The 'HOME' environment variable must be set before running Pandoc.")
  }

  if (Sys.info()['sysname'] == "Linux" &&
        is.na(Sys.getenv("LANG", unset = NA))) {
    # fill in a the LANG environment variable if it doesn't exist
    Sys.setenv(LANG = detect_generic_lang())
    on.exit(Sys.unsetenv("LANG"), add = TRUE)
  }

  if (Sys.info()['sysname'] == "Linux" &&
    identical(Sys.getenv("LANG"), "en_US")) {
    Sys.setenv(LANG = "en_US.UTF-8")
    on.exit(Sys.setenv(LANG = "en_US"), add = TRUE)
  }

  force(code)
}

is_osx <- function() {
  Sys.info()["sysname"] == "Darwin"
}

is_windows <- function() {
  identical(.Platform$OS.type, "windows")
}

.pandoc <- new.env()
.pandoc$dir <- NULL
.pandoc$version <- NULL
