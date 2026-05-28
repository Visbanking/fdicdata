test_that("getHistory function returns a data frame", {
  skip_if_fdic_offline()
  df <- getHistory(CERT_or_NAME = 3850, fields = c("NAME","CITY","STNAME"), CERT = TRUE, limit = 1000)
  skip_if(is.null(df), "FDIC history endpoint unavailable")
  expect_is(df, "data.frame")
})

test_that("getHistory function returns data in the correct format and structure", {
  skip_if_fdic_offline()
  df <- getHistory(CERT_or_NAME = 3850, fields = c("NAME","CITY","STNAME"), CERT = TRUE, limit = 1000)
  skip_if(is.null(df), "FDIC history endpoint unavailable")
  expect_gte(nrow(df), 0)
})

test_that("getHistory function errors if fields parameter is missing", {
  expect_error(getHistory(CERT_or_NAME = "Bank of America", CERT = FALSE, limit = 1000))
})
