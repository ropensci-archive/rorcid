test_that("orcid", {
  skip_on_cran()

  vcr::use_cassette("orcid", {
    # no results
    aa <- orcid()
    # normal simple query
    bb <- orcid(query = "keyword:ecology")
  })

  # gives the right classes
  expect_is(aa, "orcid")
  expect_is(aa, "tbl_df")
  expect_is(attr(aa, "found"), "integer")

  expect_is(bb, "orcid")
  expect_is(bb, "tbl_df")
  expect_is(attr(bb, 'found'), "integer")

  # gives the right values
  expect_equal(attr(aa, "found"), 0)
})

test_that("orcid paging works", {
  skip_on_cran()

  vcr::use_cassette("orcid_pagination", {
    cc <- orcid(query = "keyword:ecology", rows = 3)
    dd <- orcid(query = "keyword:ecology", rows = 3, start = 3)
  })

  # gives the right classes
  expect_is(cc, "orcid")
  expect_is(dd, "orcid")
  expect_equal(NROW(cc), 3)
})

test_that("orcid qf param works", {
  skip_on_cran()

  vcr::use_cassette("orcid_qf_param", {
    ee <- orcid(query = "Raymond", rows = 3, defType = "edismax")
    ee_boost_fam <- orcid(query = "Raymond", qf = "family-name^2.0",
                     rows = 3, defType = "edismax")
    ee_boost_given <- orcid(query = "Raymond", qf = "given-names^3.0",
                     rows = 3, defType = "edismax")
  })

  # gives the right classes
  expect_is(ee, "orcid")
  expect_is(ee_boost_fam, "orcid")
  expect_is(ee_boost_given, "orcid")

  expect_gt(attr(ee, "found"), attr(ee_boost_fam, 'found'))
  expect_gt(attr(ee, "found"), attr(ee_boost_given, 'found'))
  expect_gt(attr(ee_boost_given, 'found'), attr(ee_boost_fam, 'found'))
})

test_that("orcid fails well", {
  expect_error(orcid(query="xxxxx", recursive = TRUE), "removed")

  skip_on_cran()
  vcr::use_cassette("orcid_error", {
    expect_error(orcid(start = "adsf"), class = "error")
    expect_error(orcid(rows = "er"), class = "error")
  })
})
