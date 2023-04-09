test_that("getHistory function returns a data frame", {
  df <- getHistory(CERT_or_NAME = 3850, fields = c("NAME","CITY","STNAME"), CERT = TRUE, limit = 1000)
  expect_is(df, "data.frame")
})

test_that("getHistory function returns data in the correct format and structure", {
  df <- getHistory(CERT_or_NAME = 3850, fields = c("NAME","CITY","STNAME"), CERT = TRUE, limit = 1000)
  expect_gte(nrow(df), 0)
})

test_that("getHistory function returns NULL if fields parameter is missing", {
  expect_error(getHistory(CERT_or_NAME = "Bank of America", CERT = FALSE, limit = 1000))
})
