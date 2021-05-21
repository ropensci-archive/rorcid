test_that("orcid_citations_basic_test", {
  skip_on_cran()

  ##this tests a specific ORCID record with a bibtex record to extract
  vcr::use_cassette("orcid_citations_with_bibtex", {
    aa <- orcid_citations(orcid = "0000-0002-0734-2199", put_code = "77226586")
  })

  expect_is(aa, "data.frame")
})
