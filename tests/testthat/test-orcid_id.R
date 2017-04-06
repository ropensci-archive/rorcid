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
                 'orcid-preferences', 'orcid-history', 'orcid-bio', 'orcid-activities',
                 'orcid-internal', 'type', 'group-type', 'client-type', 'works'))
  expect_true("works" %in% names(bb1[[1]]))
  expect_true("works" %in% names(bb2[[1]]))
  expect_true("works" %in% names(bb3[[1]]))
})

test_that("orcid_id fails well", {
  skip_on_cran()
  
  expect_error(orcid_id(5), "Not found : No entity found for query")
  expect_error(orcid_id(list(a = 6)), "Not found : No entity found for query")
  expect_error(orcid_id("0000-0002-9341-7985", "things"), 
               "'arg' should be one of")
  
  # ok input class, but but ORCID
  expect_error(orcid_id("adfafadf"),  "Not found : No entity found for query")
})

test_that("orcid_id - curl options work", {
  skip_on_cran()
  
  expect_error(orcid_id("0000-0002-9341-7985", timeout_ms = 1), 
               "Timeout was reached")
})

test_that("orcid_id - can get employment and education data [affilitation data]", {
  skip_on_cran()
  
  aa <- orcid_id('0000-0003-1444-9135')
    
  expect_is(aa, "list")
  expect_is(aa[[1]], "orcid_id")
  expect_is(aa[[1]]$`orcid-activities`$affiliations$affiliation, "data.frame")
  expect_equal(
    unique(aa[[1]]$`orcid-activities`$affiliations$affiliation$type), 
    c("EMPLOYMENT", "EDUCATION")
  )
})

test_that("orcid_id - can get funding data", {
  skip_on_cran()
  
  aa <- orcid_id('0000-0002-1642-628X')
  
  expect_is(aa, "list")
  expect_is(aa[[1]], "orcid_id")
  expect_is(aa[[1]]$`orcid-activities`$`funding-list`, "list")
  expect_named(aa[[1]]$`orcid-activities`$`funding-list`, c('funding', 'scope'))
  expect_is(aa[[1]]$`orcid-activities`$`funding-list`$funding, "data.frame")
  expect_equal(
    unique(aa[[1]]$`orcid-activities`$`funding-list`$funding$`source.source-name.value`), 
    "Carl Boettiger"
  )
})
