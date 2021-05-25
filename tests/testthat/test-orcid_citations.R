test_that("orcid_citations_basic_test", {
  skip_on_cran()

  ##this tests a specific ORCID record with a bibtex record to extract
  vcr::use_cassette("orcid_citations_with_bibtex", {
    aa <- orcid_citations(orcid = "0000-0002-0734-2199", put_code = "77226586")
  })

  ##check output
  ##(1) general structure
  expect_is(aa, "tbl_df")
  
  ##(2) validate BibTeX
  aa_citations <- strsplit(aa$citation[[1]], split = ",\\n")[[1]]
  expect_length(aa_citations, n = 16)
  expect_equal(aa_citations[16], expected = "}")

})
