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
  expect_is(bb, "character")
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

  expect_is(aa, "character")
  expect_is(aa[1], "character")
  expect_identical(identifiers(x, "doi"), identifiers(x))
  expect_is(bb, "character")
})

test_that("identifiers works with output from orcid() call", {
  skip_on_cran()
  
  x <- orcid(query = "carl+boettiger")
  aa <- identifiers(x)
  
  expect_is(aa, "character")
  expect_is(aa[1], "character")
  expect_identical(identifiers(x, "doi"), identifiers(x))
})

test_that("identifiers works with output from orcid_doi() call", {
  skip_on_cran()
  
  x <- orcid_doi(dois = "10.1087/20120404", fuzzy = TRUE)
  aa <- identifiers(x)
  
  expect_is(aa, "character")
  expect_is(aa[1], "character")
  expect_identical(identifiers(x), identifiers(x))
})

test_that("identifiers fails well on disallowed inputs", {
  skip_on_cran()
  
  expect_error(identifiers("adfadf"), "no 'identifiers' method for character")
  expect_error(identifiers(mtcars), "no 'identifiers' method for data.frame")
  expect_error(identifiers(matrix()), "no 'identifiers' method for matrix")
})
