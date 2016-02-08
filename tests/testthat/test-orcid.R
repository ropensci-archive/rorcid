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

test_that("orcid paging works", {
  skip_on_cran()
  
  cc <- orcid(query = "keyword:ecology", rows = 3)
  dd <- orcid(query = "keyword:ecology", rows = 3, start = 3)
  
  # gives the right classes
  expect_is(cc, "orcid")
  expect_is(dd, "orcid")
  expect_equal(NROW(cc$data), 3)
  expect_false(identical(cc$data$`personal-details.given-names.value`, 
               dd$data$`personal-details.given-names.value`))
})

test_that("orcid qf param works", {
  skip_on_cran()
  
  ee <- orcid(query = "Raymond", rows = 3, defType = "edismax")
  ee_boost_fam <- orcid(query = "Raymond", qf = "family-name^2.0", 
                   rows = 3, defType = "edismax")
  ee_boost_given <- orcid(query = "Raymond", qf = "given-names^3.0", 
                   rows = 3, defType = "edismax")
  
  # gives the right classes
  expect_is(ee, "orcid")
  expect_is(ee_boost_fam, "orcid")
  expect_is(ee_boost_given, "orcid")
  
  expect_more_than(ee$found, ee_boost_fam$found)
  expect_more_than(ee$found, ee_boost_given$found)
  expect_more_than(ee_boost_given$found, ee_boost_fam$found)
})

test_that("orcid fails well", {
  skip_on_cran()
  
  expect_error(orcid(start = "adsf"), "500 - For input string: \"adsf\"")
  expect_error(orcid(rows = "er"), "400 - The rows parameter must be an integer")
})
