test_that("orcid_search", {
  skip_on_cran()
  
  vcr::use_cassette("orcid_search", {
    aa <- orcid_search(given_name = "carl")
  })
  
  expect_is(aa, "data.frame")
  expect_named(aa, c("first", "last", "orcid"))
})

test_that("orcid_search fails well", {
  skip_on_cran()
  
  expect_error(orcid_search(), "must pass at least one param")

  vcr::use_cassette("orcid_search_fail", {
    expect_error(orcid_search(given_name = "carl", rows = 'apple'),
      "The rows parameter must be an integer between 0 and 200",
      "error"
    )
  })
})

test_that("orcid_search no results gives empty data.frame", {
  skip_on_cran()
  
  vcr::use_cassette("orcid_search_no_results", {
    aa <- orcid_search(family_name = 'iakovakis', past_inst = 'Houston')
  })
  
  expect_equal(NROW(aa), 0)
})
