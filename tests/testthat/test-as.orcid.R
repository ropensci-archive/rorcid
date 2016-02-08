context("as.orcid")

test_that("as.orcid basic functionality works", {
  skip_on_cran()
  
  aa <- as.orcid("0000-0002-1642-628X")
  
  expect_is(aa, "or_cid")
  expect_named(aa, "0000-0002-1642-628X")
  expect_equal(attr(aa$`0000-0002-1642-628X`, "profile"), "profile")
})

test_that("as.orcid accepts itself, or_cid class", {
  skip_on_cran()
  
  tmp <- as.orcid("0000-0002-1642-628X")
  bb <- as.orcid(tmp)
  
  expect_is(bb, "or_cid")
  expect_equal(bb, tmp)
})

test_that("as.orcid fails well", {
  skip_on_cran()
  
  expect_error(as.orcid(5), "no applicable method")
  expect_warning(as.orcid(list(a = 6)), "input not coercable to an or_cid class")
  
  # ok input class, but but ORCID
  expect_error(as.orcid("adfafadf"), "404 - Not found")
})

test_that("summary.or_cid works", {
  skip_on_cran()
  
  aa <- capture.output(summary(as.orcid("0000-0002-1642-628X")))
  
  expect_is(aa, "character")
  expect_true(any(grepl("ORCID", aa)))
  
  out <- orcid("text:English", rows = 20)
  res <- capture.output(lapply(out$data$`orcid-identifier.path`, function(x) summary(as.orcid(x))))
  
  expect_is(res, "character")
  expect_identical(length(res[grepl("Name:", res)]), length(out$data$`orcid-identifier.path`))
})
