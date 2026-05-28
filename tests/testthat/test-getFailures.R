test_that("getFailures function returns a data frame", {
  skip_if_fdic_offline()
  df <- getFailures(c("CERT","NAME","FAILDATE"), range = c("2015","2021"), limit = 1000)
  skip_if(is.null(df), "FDIC failures endpoint unavailable")
  expect_is(df, "data.frame")
  expect_equal(ncol(df), 3)
})

test_that("getFailures function errors if range is not in the correct format", {
  expect_error(getFailures(c("CERT","NAME","FAILDATE"), range = c("2015","2021","2022"), limit = 1000))
})
