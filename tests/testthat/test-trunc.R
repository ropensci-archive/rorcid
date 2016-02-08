context("truncmat")

test_that("truncmat_ works", {
  skip_on_cran()
  
  ff <- tempfile()
  capture.output(trunc_mat_(cars[1:2,]), file = ff)
  aa <- readLines(ff)
  
  expect_is(aa, "character")
  expect_true(any(vapply(aa, function(x) grepl("dbl", x), logical(1))))
})
