
test_that("getFailures function returns a data frame", {
  df <- getFailures(c("CERT","NAME","FAILDATE"), range = c("2015","2021"), limit = 1000)
  expect_is(df, "data.frame")
  expect_equal(ncol(df), 3)
})

test_that("getFailures function returns NULL if range is not in the correct format", {
  expect_error(getFailures(c("CERT","NAME","FAILDATE"), range = c("2015","2021","2022"), limit = 1000))
})

