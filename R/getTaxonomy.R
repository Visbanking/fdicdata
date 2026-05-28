#' Get taxonomy file from FDIC website
#'
#' This function takes the name of the YAML file containing data taxonomy as
#' an input and downloads it from the FDIC website, saving it to the local
#' directory for later use. Returns the local file path on success, or
#' \code{NULL} if the resource is unreachable or returns an error.
#'
#' @param taxonomy The name of the taxonomy file to download (one of
#'   "institution_properties.yaml", "location_properties.yaml",
#'   "history_properties.yaml", "summary_properties.yaml",
#'   "failure_properties.yaml", or "risview_properties.yaml")
#' @return The local file path of the downloaded taxonomy file, or
#'   \code{NULL} on failure.
#' @import httr
#' @keywords internal

getTaxonomy <- function(taxonomy){
  url <- paste0("https://api.fdic.gov/banks/docs/", taxonomy)
  raw <- .fetch_raw(url)
  if (is.null(raw)) return(NULL)
  filename <- file.path(tempdir(), taxonomy)
  tryCatch({
    writeBin(raw, filename)
    filename
  }, error = function(e) {
    message("Could not write taxonomy file: ", conditionMessage(e))
    NULL
  })
}
