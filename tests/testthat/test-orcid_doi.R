context("orcid_doi")

test_that("orcid_doi basic functionality works", {
  skip_on_cran()
  
  aa <- orcid_doi("10.1087/20120404")
  
  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_is(aa[[1]], "orcid_doi")
  expect_named(aa[[1]], c('found', 'data'))
})

test_that("orcid_doi accepts many doi's", {
  skip_on_cran()
  
  dois <- c("10.1371/journal.pone.0025995","10.1371/journal.pone.0053712")
  bb <- orcid_doi(dois)
  
  expect_is(bb, "list")
  expect_equal(length(bb), 2)
  expect_is(bb[[1]], "orcid_doi")
  expect_is(bb[[2]], "orcid_doi")
})

test_that("orcid_doi paging parameters works as expected", {
  skip_on_cran()
  
  pg1 <- orcid_doi("10.1087/20120404", rows = 3)
  pg2 <- orcid_doi("10.1087/20120404", rows = 3, start = 4)
  
  expect_false(identical(pg1[[1]], pg2[[1]]))
  expect_is(pg1[[1]]$found, "integer")
  expect_is(pg2[[1]]$found, "integer")
  expect_equal(NROW(pg1[[1]]$data), 3)
  expect_equal(NROW(pg2[[1]]$data), 3)
})

test_that("orcid_doi fails well", {
  skip_on_cran()
  
  expect_error(orcid_doi(5), "The following are not DOIs")
  expect_error(orcid_doi(list(a = 6)), "The following are not DOIs")
})
