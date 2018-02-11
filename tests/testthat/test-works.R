context("works")

test_that("basic works operations returns the correct...", {
  skip_on_cran()
  
  aa <- works( orcid_id("0000-0003-1620-1408") )
  bb <- works( orcid_id("0000-0003-1444-9135") )
  
  # gives the right classes
  expect_is(aa, "works")
  expect_named(aa, character(0))
  expect_equal(NROW(aa), 0)
  
  expect_is(bb, "works")
  expect_is(bb, "data.frame")
  expect_is(bb$`source.source-orcid.path`, "character")
  expect_true(any(grepl("taxize", bb$`title.title.value`)))
})

test_that("works fails well", {
  skip_on_cran()
  
  expect_error(works(5), "no 'as.orcid' method")
  expect_error(works(mtcars), "no 'as.orcid' method")
  expect_error(works("Asfaf"), "404 Not Found")
})
