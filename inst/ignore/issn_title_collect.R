library(rcrossref)
library(dplyr)

z <- cr_journals(limit = 0)
max <- z$meta$total_results

offsets <- c(0, seq(1000, max, by = 1000))

out <- list()
for (i in seq_along(offsets)) {
  cat(i, "\n")
  out[[i]] <- cr_journals(limit = 1000, offset = offsets[i])
}

df <- dplyr::bind_rows(lapply(out, function(w) w$data))
dat <- stats::setNames(df$title, df$issn)
dat <- dat[!is.na(names(dat))]
# length(dat)
# dat[1:10]

# save to data/issn_title.rda
issn_title <- dat
save(issn_title, file = "data/issn_title.rda", compress = "xz")


# Cleanup non-ASCII characters

# issn_title_badascii = lapply(unname(issn_title), tools::showNonASCII)
# non_asciis <- which(vapply(issn_title_badascii, function(z) length(z) == 1, logical(1)))
# issn_title[[non_asciis[1]]]

# for (i in seq_along(issn_title)) {
#   if (i %in% non_asciis) {
#     issn_title[[i]] <- stringi::stri_escape_unicode(issn_title[[i]])
#   }
# }
# issn_title2 <- issn_title
# save(issn_title, file = "data/issn_title.rda", compress = "xz")
