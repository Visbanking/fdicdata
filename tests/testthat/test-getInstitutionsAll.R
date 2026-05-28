test_that("getInstitutionsAll returns a data frame with expected columns", {
  skip_if_fdic_offline()
  dataInstitutions <- getInstitutionsAll()
  skip_if(is.null(dataInstitutions), "FDIC institutions endpoint unavailable")
  expect_is(dataInstitutions, "data.frame")
  expect_true(all(c("CERT", "NAME", "CITY", "STALP", "ZIP") %in% colnames(dataInstitutions)))
})

test_that("getInstitutionsAll returns a data frame with expected class types", {
  skip_if_fdic_offline()
  dataInstitutions <- getInstitutionsAll()
  skip_if(is.null(dataInstitutions), "FDIC institutions endpoint unavailable")
  expect_is(dataInstitutions$CERT, "integer")
  expect_is(dataInstitutions$NAME, "character")
  expect_is(dataInstitutions$CITY, "character")
  expect_is(dataInstitutions$STALP, "character")
  expect_is(dataInstitutions$ZIP, "integer")
})
