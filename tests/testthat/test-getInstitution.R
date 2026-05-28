test_that("getInstitutionsAll returns a data frame with expected columns", {
  skip_if_fdic_offline()
  df <- getInstitutionsAll()
  skip_if(is.null(df), "FDIC institutions endpoint unavailable")
  expect_true(is.data.frame(df))
  expect_true("CERT" %in% colnames(df))
  expect_true("NAME" %in% colnames(df))
  expect_true("CITY" %in% colnames(df))
  expect_true("STALP" %in% colnames(df))
  expect_true("ZIP" %in% colnames(df))
})

test_that("getInstitution function returns a data frame", {
  skip_if_fdic_offline()
  df <- getInstitution(name = "Bank of America", fields = c("NAME","CITY","STATE"), limit = 1000)
  skip_if(is.null(df), "FDIC institutions endpoint unavailable")
  expect_is(df, "data.frame")
})

test_that("getInstitution function errors if both name and IDRSSD_or_CERT are provided", {
  expect_error(getInstitution(name = "Bank of America", IDRSSD_or_CERT = 123456, fields = c("NAME","CITY","STATE"), limit = 1000))
})
