context("orcid_id")

test_that("orcid_id basic functionality works", {
  skip_on_cran()
  
  aa <- orcid_id("0000-0002-9341-7985")
  
  expect_is(aa, "list")
  expect_is(aa$`0000-0002-9341-7985`, "orcid_id")
  expect_named(aa, "0000-0002-9341-7985")
})

test_that("orcid_id accepts many orcid's", {
  skip_on_cran()
  
  ids <- c("0000-0003-1620-1408", "0000-0002-9341-7985")
  bb <- orcid_id(ids)
  
  expect_is(bb, "list")
  expect_is(bb[[1]], "orcid_id")
  expect_is(bb[[2]], "orcid_id")
})

test_that("orcid_id profile parameter works as expected", {
  skip_on_cran()
  
  bb1 <- orcid_id("0000-0002-9341-7985", "profile")
  bb2 <- orcid_id("0000-0002-9341-7985", "works")
  bb3 <- orcid_id("0000-0002-9341-7985", "bio")
  
  expect_false(identical(bb1[[1]], bb2[[1]]))
  expect_named(bb1[[1]], 
               c('orcid', 'orcid-id', 'orcid-identifier', 'orcid-deprecated', 
                 'orcid-preferences', 'orcid-history', 'orcid-bio', 'orcid-internal', 
                 'type', 'group-type', 'client-type', 'works'))
  expect_true("works" %in% names(bb1[[1]]))
  expect_true("works" %in% names(bb2[[1]]))
  expect_false("works" %in% names(bb3[[1]]))
})

test_that("orcid_id fails well", {
  skip_on_cran()
  
  expect_error(orcid_id(5), "404 - Not found")
  expect_error(orcid_id(list(a = 6)), "404 - Not found")
  expect_error(orcid_id("0000-0002-9341-7985", "things"), 
               "'arg' should be one of")
  
  # ok input class, but but ORCID
  expect_error(orcid_id("adfafadf"), "404 - Not found")
})

test_that("orcid_id - curl options work", {
  skip_on_cran()
  
  library("httr")
  expect_error(orcid_id("0000-0002-9341-7985", config=timeout(0.1)), 
               "Timeout was reached")
})
