test_that("getSummary function returns a data frame", {
  df <- getSummary(states = "California", range = c("2020","2021"), fields = c("CB_SI","DEP_SI"), limit = 1000)
  expect_is(df, "data.frame")
})

test_that("getSummary function returns data in the correct format and structure", {
  df <- getSummary(states = "California", range = c("2020","2021"), fields = c("CB_SI","DEP_SI"), limit = 1000)
  expect_gte(nrow(df), 0)
  if(nrow(df) > 0){
    expect_type(df$STNAME, "character")
    expect_type(df$YEAR, "integer")
  }
})

test_that("getSummary function returns URL if any parameter is missing", {
  expect_error(getSummary(states = "California", fields = c("CB_SI","DEP_SI"), limit = 1000))
})
