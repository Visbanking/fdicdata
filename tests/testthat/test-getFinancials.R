test_that("errors", {
  testthat::expect_error(getFinancials("a"))
})

test_that("getFinancials function returns expected results", {
  skip_if_fdic_offline()

  df1 <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10)
  skip_if(is.null(df1), "FDIC financials endpoint unavailable")
  expect_s3_class(df1, "data.frame")
  expect_equal(nrow(df1), 10)
  expect_equal(ncol(df1), 4)

  df2 <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10, range = c("2015-01-01","2016-01-01"))
  skip_if(is.null(df2), "FDIC financials endpoint unavailable")
  expect_s3_class(df2, "data.frame")
  expect_true(all(df2$DATE >= as.Date("2015-01-01") & df2$DATE <= as.Date("2016-01-01")))

  expect_error(getFinancials("invalid", metrics = c("ASSET", "DEP"), limit = 10), "is.numeric")
  expect_error(getFinancials(37, limit = 10), "!missing")
  expect_error(getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10, range = "invalid"), "length")
})

test_that("The function returns a data frame", {
  skip_if_fdic_offline()
  df <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10, range = c("2015-01-01","*"))
  skip_if(is.null(df), "FDIC financials endpoint unavailable")
  expect_is(df, "data.frame")
})

test_that("The function returns the expected number of rows", {
  skip_if_fdic_offline()
  df <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10, range = c("2015-01-01","*"))
  skip_if(is.null(df), "FDIC financials endpoint unavailable")
  expect_equal(nrow(df), 10)
})

test_that("The function handles open-ended ranges correctly", {
  skip_if_fdic_offline()
  df <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10, range = c("2015-01-01","*"))
  skip_if(is.null(df), "FDIC financials endpoint unavailable")
  expect_true(all(df$DATE >= as.Date("2015-01-01")))
})

test_that("The function handles missing range parameter", {
  skip_if_fdic_offline()
  df <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10)
  skip_if(is.null(df), "FDIC financials endpoint unavailable")
  expect_equal(nrow(df), 10)
})
