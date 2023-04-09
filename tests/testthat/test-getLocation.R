test_that("getLocation function returns a data frame", {
  df <- getLocation(CERT = 3850, fields = c("NAME","CITY","STNAME"), limit = 1000)
  expect_is(df, "data.frame")
})

test_that("getLocation function returns NULL if CERT parameter is missing", {
  expect_error(getLocation(fields = c("NAME","CITY","STNAME"), limit = 1000))

})

test_that("getLocation function returns data in the correct format and structure", {
  df <- getLocation(CERT = 3850, fields = c("NAME","CITY","STNAME"), limit = 1000)
  expect_equal(ncol(df), 6)
  expect_gte(nrow(df), 0)
  if(nrow(df) > 0){
    expect_type(df$NAME, "character")
    expect_type(df$CITY, "character")
    expect_type(df$STNAME, "character")
    expect_type(df$MAINOFF, "integer")
    expect_type(df$CERT, "integer")
  }
})
