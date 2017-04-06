context("as.orcid")

test_that("as.orcid basic functionality works", {
  skip_on_cran()
  
  aa <- as.orcid("0000-0002-1642-628X")
  
  expect_is(aa, "list")
  expect_is(aa[[1]], "or_cid")
  expect_named(aa, "0000-0002-1642-628X")
  expect_equal(attr(aa$`0000-0002-1642-628X`, "profile"), "profile")
})

test_that("as.orcid accepts itself, or_cid class", {
  skip_on_cran()
  
  tmp <- as.orcid("0000-0002-1642-628X")
  bb <- as.orcid(tmp)
  
  expect_is(bb, "list")
  expect_is(bb[[1]], "or_cid")
  expect_identical(bb, tmp)
  expect_identical(bb[[1]], tmp[[1]])
})

test_that("as.orcid fails well", {
  skip_on_cran()
  
  expect_error(as.orcid(5), "no 'as.orcid' method")
  expect_error(as.orcid(list(a = 6)), "no 'as.orcid' method for numeric")
  
  # ok input class, but but ORCID
  expect_error(as.orcid("adfafadf"), "Not found : No entity found for query")
})
