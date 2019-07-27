test_that("extract_bibtex - basic functionality test", {
  skip_on_cran()

  vcr::use_cassette("extract_bibtex", {
    aa <- cite_put(orcid = "0000-0002-0734-2199", pc = "40038622", ctype = "application/vnd.orcid+json; qs=4")

  })

  ## in order to test everything, we have to modify the string a little bit
  ## (1) - the record is no BibTeX record
  aa_noBibTeX <- jsonlite::fromJSON(aa)
  aa_noBibTeX$citation$`citation-type` <- "unknown"
  aa_noBibTeX <- jsonlite::toJSON(aa_noBibTeX)

  ## (2) - the citekey is not ok
  aa_wrong_citekey <- jsonlite::fromJSON(aa)
  aa_wrong_citekey$citation$`citation-value` <-
    sub(
      pattern = "@article{Kreutzer:2012ty",
      replacement = "@article{Kreutzer,2012ty",
      x = aa_wrong_citekey$citation$`citation-value`,
      fixed = TRUE
    )
  aa_wrong_citekey <- jsonlite::toJSON(aa_wrong_citekey)

  ## (3) - the citekey does not exist
  aa_missing_citekey <- jsonlite::fromJSON(aa)
  aa_missin_citekey$citation$`citation-value` <-
    sub(
      pattern = "@article{Kreutzer:2012ty",
      replacement = "@article{",
      x = aa_missin_citekey$citation$`citation-value`,
      fixed = TRUE
    )
  aa_missing_citekey <- jsonlite::toJSON(aa_missing_citekey)

  ## test all cases
  ## (0) - standard (nothing should go wrong)
  expect_is(extract_bibtex(aa), "character")

  ## (1) - no BibTeX record
  expect_warning(extract_bibtex(aa_noBibTeX), regexp = "No BibTeX record found for record with put-code")

  ## (2) - odd citekey (currently it just corrects, so smooth passage)
  expect_is(extract_bibtex(aa_wrong_citekey), "character")

  ## (3) - missing citekey, if it works it passes
  expect_is(extract_bibtex(aa_missing_citekey), "character")

})
