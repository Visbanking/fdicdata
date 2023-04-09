#The first test checks that the getInstitutionsAll() function returns a data frame and that this data frame has specific columns.
test_that("getInstitutionsAll returns a data frame with expected columns", {
  dataInstitutions <- getInstitutionsAll()
  expect_is(dataInstitutions, "data.frame")
  expect_true(all(c("CERT", "NAME", "CITY", "STALP", "ZIP") %in% colnames(dataInstitutions)))
})
#The third test checks that the specific columns of the data frame returned by the getInstitutionsAll() function have the expected data types.
test_that("getInstitutionsAll returns a data frame with expected class types", {
  dataInstitutions <- getInstitutionsAll()
  expect_is(dataInstitutions$CERT, "integer")
  expect_is(dataInstitutions$NAME, "character")
  expect_is(dataInstitutions$CITY, "character")
  expect_is(dataInstitutions$STALP, "character")
  expect_is(dataInstitutions$ZIP, "integer")
})
