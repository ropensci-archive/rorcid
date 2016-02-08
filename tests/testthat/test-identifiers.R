context("identifiers")

test_that("identifiers basic functionality works", {
  skip_on_cran()

  x <- works(orcid_id("0000-0001-8607-8025"))
  # doi by default
  aa <- identifiers(x)
  # orcids
  bb <- identifiers(x, "orcid")
  # pmid
  cc <- identifiers(x, "pmid")
  # pmc
  dd <- identifiers(x, "pmc")
  # other_id
  ee <- identifiers(x, "other_id")

  expect_is(aa, "character")
  expect_null(bb)
  expect_is(cc, "character")
  expect_is(dd, "character")
  expect_is(ee, "character")
  
  expect_equal(length(aa), length(check_dois(aa)$good))
  expect_true(all(grepl("PMC", dd)))
})

test_that("identifiers works with output from or_cid() call", {
  skip_on_cran()

  x <- orcid_id(orcid = "0000-0002-9341-7985")
  aa <- identifiers(x, "doi")
  bb <- identifiers(x, "eid")

  expect_is(aa, "list")
  expect_is(aa[[1]], "character")
  expect_identical(identifiers(x, "doi"), identifiers(x))
  expect_is(bb, "list")
})

test_that("identifiers works with output from orcid() call", {
  skip_on_cran()
  
  x <- orcid(query="carl+boettiger")
  aa <- identifiers(x, "scopus")
  bb <- identifiers(x, "researcherid")
  
  expect_is(aa, "character")
  expect_is(aa[[1]], "character")
  expect_identical(identifiers(x, "doi"), identifiers(x))
  expect_true(grepl("G", bb))
})

test_that("identifiers works with output from orcid_doi() call", {
  skip_on_cran()
  
  x <- orcid_doi(dois="10.1087/20120404", fuzzy=TRUE)
  aa <- identifiers(x, "scopus")
  
  expect_is(aa, "list")
  expect_is(aa[[1]], "character")
  expect_identical(identifiers(x, "doi"), identifiers(x))
})
