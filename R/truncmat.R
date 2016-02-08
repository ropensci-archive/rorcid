# from dplyr:
# - https://github.com/hadley/dplyr/blob/master/R/utils-format.r
# - https://github.com/hadley/dplyr/blob/master/R/type-sum.r
trunc_mat_ <- function(x, n = NULL, width = NULL, n_extra = 100) {
  rows <- nrow(x)

  if (is.null(n)) {
    if (is.na(rows) || rows > 100) {
      n <- 10
    } else {
      n <- rows
    }
  }

  df <- as.data.frame(head(x, n))
  var_types <- vapply(df, type_summ, character(1))
  var_names <- names(df)

  if (ncol(df) == 0 || nrow(df) == 0) {
    extra <- setNames(var_types, var_names)

    return(structure(list(table = NULL, extra = extra), class = "trunc_mat"))
  }

  rownames(df) <- NULL

  width <- width %||% getOption("width")
  # Minimum width of each column is 5 "(int)", so we can make a quick first
  # pass
  max_cols <- floor(width / 5)
  extra_wide <- seq_along(var_names) > max_cols
  if (any(extra_wide)) {
    df <- df[!extra_wide]
  }

  # List columns need special treatment because format can't be trusted
  classes <- paste0("(", vapply(df, type_summ, character(1)), ")")
  is_list <- vapply(df, is.list, logical(1))
  df[is_list] <- lapply(df[is_list], function(x) vapply(x, obj_type, character(1)))

  mat <- format(df, justify = "left")
  values <- c(format(rownames(mat))[[1]], unlist(mat[1, ]))

  names <- c("", colnames(mat))

  # Column needs to be as wide as widest of name, values, and class
  w <- pmax(
    pmax(
      nchar(encodeString(values)),
      nchar(encodeString(names))
    ),
    nchar(encodeString(c("", classes)))
  )
  cumw <- cumsum(w + 1)

  too_wide <- cumw[-1] > width
  # Always display at least one column
  if (all(too_wide)) {
    too_wide[1] <- FALSE
    df[[1]] <- substr(df[[1]], 1, width)
  }
  shrunk <- format(df[, !too_wide, drop = FALSE])
  shrunk <- rbind(" " = classes, shrunk)
  colnames(shrunk) <- colnames(df)[!too_wide]

  needs_dots <- is.na(rows) || rows > n
  if (needs_dots) {
    dot_width <- pmin(w[-1][!too_wide], 3)
    dots <- vapply(dot_width, function(i) paste(rep(".", i), collapse = ""),
                   FUN.VALUE = character(1))
    shrunk <- rbind(shrunk, ".." = dots)
  }

  if (any(extra_wide)) {
    extra_wide[seq_along(too_wide)] <- too_wide
    extra <- setNames(var_types[extra_wide], var_names[extra_wide])
  } else {
    extra <- setNames(var_types[too_wide], var_names[too_wide])
  }

  if (length(extra) > n_extra) {
    more <- paste0("and ", length(extra) - n_extra, " more")
    extra <- c(extra[1:n_extra], setNames("...", more))
  }

  res <- structure(list(table = shrunk, extra = extra), class = "trunc_mat")

  if (!is.null(res$table)) {
    print(res$table)
  }

  if (length(res$extra) > 0) {
    var_types <- paste0(names(res$extra), " (", res$extra, ")", collapse = ", ")
    cat(rorcid_wrap("Variables not shown: ", var_types), ".\n", sep = "")
  }
  invisible()
}

rorcid_wrap <- function(..., indent = 0) {
  x <- paste0(..., collapse = "")
  wrapped <- strwrap(x, indent = indent, exdent = indent + 2,
                     width = getOption("width"))

  paste0(wrapped, collapse = "\n")
}

obj_type <- function(x) UseMethod("obj_type")
#' @export
obj_type.NULL <- function(x) "<NULL>"
#' @export
obj_type.default <- function(x) {
  if (!is.object(x)) {
    paste0("<", type_summ(x), if (!is.array(x)) paste0("[", length(x), "]"), ">")
  } else if (!isS4(x)) {
    paste0("<S3:", paste0(class(x), collapse = ", "), ">")
  } else {
    paste0("<S4:", paste0(methods::is(x), collapse = ", "), ">")
  }
}

#' @export
obj_type.data.frame <- function(x) {
  paste0("<", class(x)[1], " [", paste0(dim(x), collapse = ","), "]", ">")
}
#' @export
obj_type.data_frame <- function(x) {
  paste0("<data_frame [", paste0(dim(x), collapse = ","), "]", ">")
}

#' type_summ
#' @keywords internal
#' @export
type_summ <- function(x) UseMethod("type_summ")

#' @export
type_summ.data.frame <- function(x) {
  if (length(x) == 0) return(character(0))

  vapply(x, type_summ, character(1))
}

#' @export
type_summ.numeric <- function(x) "dbl"
#' @export
type_summ.integer <- function(x) "int"
#' @export
type_summ.logical <- function(x) "lgl"
#' @export
type_summ.character <- function(x) "chr"

#' @export
type_summ.factor <- function(x) "fctr"
#' @export
type_summ.POSIXt <- function(x) "time"
#' @export
type_summ.Date <- function(x) "date"

#' @export
type_summ.matrix <- function(x) {
  paste0(NextMethod(), "[", paste0(dim(x), collapse = ","), "]")
}
#' @export
type_summ.array <- type_summ.matrix

#' @export
type_summ.default <- function(x) unname(abbreviate(class(x)[1], 4))

`%||%` <- function(x, y) if (is.null(x)) y else x
