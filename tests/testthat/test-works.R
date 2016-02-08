context("works")

test_that("basic works operations returns the correct...", {
  skip_on_cran()
  
  aa <- works( orcid_id("0000-0003-1620-1408") )
  bb <- works( orcid_id("0000-0003-1444-9135") )
  
  # gives the right classes
  expect_is(aa, "works")
  expect_named(aa, "data")
  expect_equal(aa$data, "None")
  
  expect_is(bb, "works")
  expect_named(bb, "data")
  expect_is(bb$data, "data.frame")
  expect_is(bb$data$`source.source-orcid.path`, "character")
  expect_true(any(grepl("taxize", bb$data$`work-title.title.value`)))
})

test_that("works fails well", {
  skip_on_cran()
  
  expect_error(works(5), "no applicable method")
  expect_error(works(mtcars), "no applicable method")
  expect_error(works("Asfaf"), "404 - Not found")
})
