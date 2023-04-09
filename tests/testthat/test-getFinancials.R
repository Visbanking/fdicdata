test_that("errors", {
  testthat::expect_error(getFinancials("a"))
})


# Define test cases for getFinancials function
test_that("getFinancials function returns expected results", {
  # Test case 1: Check function with valid input arguments and default range
  df1 <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10)
  expect_s3_class(df1,"data.frame")
  expect_equal(nrow(df1), 10)
  expect_equal(ncol(df1), 4)

  # Test case 2: Check function with valid input arguments and specific range
  df2 <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10, range = c("2015-01-01","2016-01-01"))
  expect_s3_class(df2,"data.frame")
  expect_true(all(df2$DATE >= as.Date("2015-01-01") & df2$DATE <= as.Date("2016-01-01")))


  # Test case 3: Check function with invalid IDRSSD_or_CERT argument
  expect_error(getFinancials("invalid", metrics = c("ASSET", "DEP"), limit = 10), "is.numeric")

  # Test case 4: Check function with missing metrics argument
  expect_error(getFinancials(37, limit = 10), "!missing")

  # Test case 5: Check function with invalid range argument
  expect_error(getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10, range = "invalid"), "length")
})

# Test case 6: Check if the function returns a data frame
test_that("The function returns a data frame", {
  df <- getFinancials(37, metrics = c("ASSET", "DEP"),limit = 10, range = c("2015-01-01","*"))
  expect_is(df, "data.frame")
})

# Test case 7: Check if the function returns the expected number of rows
test_that("The function returns the expected number of rows", {
  df <- getFinancials(37, metrics = c("ASSET", "DEP"),limit = 10, range = c("2015-01-01","*"))
  expect_equal(nrow(df), 10)
})

# Test case 8: Check if the function handles open-ended ranges correctly
test_that("The function handles open-ended ranges correctly", {
  df <- getFinancials(37, metrics = c("ASSET", "DEP"),limit = 10, range = c("2015-01-01","*"))
  expect_true(all(df$DATE >= as.Date("2015-01-01")))
})
#Test case 9: Check if the function handles missing range parameter
test_that("The function handles missing range parameter", {
  df <- getFinancials(37, metrics = c("ASSET", "DEP"), limit = 10)
  expect_equal(nrow(df), 10)
})

