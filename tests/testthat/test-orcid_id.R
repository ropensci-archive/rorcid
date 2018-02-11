context("orcid_id")

test_that("orcid_id basic functionality works", {
  skip_on_cran()
  
  aa <- orcid_id("0000-0002-9341-7985")
  
  expect_is(aa, "orcid_id")
  expect_is(aa$`0000-0002-9341-7985`, "list")
  expect_named(aa, "0000-0002-9341-7985")
})

test_that("orcid_id fails well", {
  skip_on_cran()
  
  expect_error(orcid_id(5), "is.character\\(orcid\\) is not TRUE")
  expect_error(orcid_id(list(a = 6)), "is.character\\(orcid\\) is not TRUE")
  
  # ok input class, but but ORCID
  expect_error(orcid_id("asdfadf"), "404 Not Found")

  # accepts only 1 ID
  ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
  expect_error(orcid_id(ids), "1 is not TRUE")
})

test_that("orcid_id - curl options work", {
  skip_on_cran()
  
  expect_error(orcid_id("0000-0002-9341-7985", timeout_ms = 1), 
               "Timeout was reached")
})

test_that("orcid_id - can get addresss data", {
  skip_on_cran()
  
  aa <- orcid_id('0000-0003-1444-9135')
    
  expect_is(aa, "orcid_id")
  expect_is(aa[[1]], "list")
  expect_is(aa[[1]]$addresses, "list")
  expect_is(aa[[1]]$addresses$address, "data.frame")
  expect_equal(aa[[1]]$addresses$address$country.value, "US")
})

test_that("orcid_id - can get keywords data", {
  skip_on_cran()
  
  aa <- orcid_id('0000-0002-1642-628X')
  
  expect_is(aa, "orcid_id")
  expect_is(aa[[1]], "list")
  expect_is(aa[[1]]$keywords, "list")
  expect_is(aa[[1]]$keywords$keyword, 'data.frame')
  expect_is(aa[[1]]$keywords$keyword$content, "character")
  expect_match(aa[[1]]$keywords$keyword$content, "Ecology")
})
