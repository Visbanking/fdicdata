skip_if_fdic_offline <- function() {
  testthat::skip_on_cran()
  testthat::skip_if_offline("banks.data.fdic.gov")
}
