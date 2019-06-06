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
