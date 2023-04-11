#' Get taxonomy file from FDIC website
#'
#' This function takes the name of the YAML file containing data taxonomy as an input
#' and downloads it from the FDIC website, saving it to the local directory for later use.
#'
#' @param taxonomy The name of the taxonomy file to download (one of "institution_properties.yaml", "location_properties.yaml", "history_properties.yaml", "summary_properties.yaml", "failure_properties.yaml", or "risview_properties.yaml")
#' @import httr

getTaxonomy <- function(taxonomy){
  url <- paste0("https://banks.data.fdic.gov/docs/",taxonomy)
  filename <- paste0(tempdir(),taxonomy)
  response <- GET(url)
  writeBin(content(response, "raw"), filename)
}
