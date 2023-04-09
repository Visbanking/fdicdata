#This code is testing the getInstitutionsAll() function to ensure that it returns a data frame with expected columns.
test_that("getInstitutionsAll returns a data frame with expected columns", {
  df <- getInstitutionsAll()
  expect_true(is.data.frame(df))
  expect_true("CERT" %in% colnames(df))
  expect_true("NAME" %in% colnames(df))
  expect_true("CITY" %in% colnames(df))
  expect_true("STALP" %in% colnames(df))
  expect_true("ZIP" %in% colnames(df))
})

test_that("getInstitution function returns a data frame", {
  df <- getInstitution(name = "Bank of America", fields = c("NAME","CITY","STATE"), limit = 1000)
  expect_is(df, "data.frame")
})

test_that("getInstitution function returns NULL if both name and IDRSSD_or_CERT parameters are provided", {
  expect_error(getInstitution(name = "Bank of America", IDRSSD_or_CERT = 123456, fields = c("NAME","CITY","STATE"), limit = 1000))

})
