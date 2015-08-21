context("orcid")

test_that("basic orcid operations returns the correct...", {
  skip_on_cran()
  
  # no results
  aa <- orcid()
  # normal simple query
  bb <- orcid(query = "keyword:ecology")
  
  # gives the right classes
  expect_is(aa, "orcid")
  expect_is(aa$found, "integer")
  expect_is(aa$data, "list")
  
  expect_is(bb, "orcid")
  expect_is(bb$found, "integer")
  expect_is(bb$data, "data.frame")
  
  # gives the right values
  expect_equal(aa$found, 0)
})

test_that("orcid fails well", {
  skip_on_cran()
  
  expect_error(orcid(start = "adsf"), "500 - For input string: \"adsf\"")
  expect_error(orcid(rows = "er"), "500 - For input string: \"er\"")
})
