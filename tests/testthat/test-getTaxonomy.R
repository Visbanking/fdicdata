#' Test getTaxonomy function for downloading taxonomy files from FDIC website
#'
#' @import httr
#' @export
test_that("getTaxonomy downloads the correct taxonomy file", {

  taxonomy <- "institution_properties.yaml"

  getTaxonomy(taxonomy)

  expect_true(file.exists(paste0(tempdir(), taxonomy)))

  expect_true(file.size(paste0(tempdir(), taxonomy)) > 0)

  expect_equal(tools::file_ext(paste0(tempdir(), taxonomy)), "yaml")
})
