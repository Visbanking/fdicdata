# # Test for dataTaxonomy function
# context("dataTaxonomy function")
#
# test_that("returns a data frame", {
#   output <- dataTaxonomy("institution")
#   expect_is(output, "data.frame")
# })
#
# test_that("returns correct column names", {
#   output <- dataTaxonomy("history")
#   expect_identical(colnames(output), c("Name", "Title", "Description", "Type"))
# })
#
# test_that("returns correct column names for location", {
#   output <- dataTaxonomy("location")
#   expect_identical(colnames(output), c("Name", "Title", "Description", "Type"))
# })
#
# test_that("returns correct column names for history", {
#   output <- dataTaxonomy("history")
#   expect_identical(colnames(output), c("Name", "Title", "Description", "Type"))
# })
#
# test_that("returns correct column names for summary", {
#   output <- dataTaxonomy("summary")
#   expect_identical(colnames(output), c("Name", "Title", "Description", "Type"))
# })
#
# test_that("returns correct column names for failure", {
#   output <- dataTaxonomy("failure")
#   expect_identical(colnames(output), c("Name", "Title", "Description", "Type"))
# })
#
# test_that("returns correct column names for financial", {
#   output <- dataTaxonomy("financial")
#   expect_identical(colnames(output), c("Name", "Title", "Description", "Type"))
# })
#
# test_that("throws an error for invalid taxonomy name", {
#   expect_error(dataTaxonomy("invalid_name"), "name argument must be one of these: institution, location, history, summary,failure,financial")
# })
#
#
