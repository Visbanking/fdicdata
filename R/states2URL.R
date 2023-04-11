#' Converts a vector of state names to a URL compatible format
#'
#' This function takes a vector of state names and converts it to a format that is compatible with URLs. The resulting string can be used as a filter for APIs or other web requests.
#'
#' @param vec A vector of state names to be converted to URL-compatible format
#'
#' @return A string containing the state names in URL-compatible format

states2URL <- function(vec) {
  stopifnot(!missing(vec))
  url_vec <- sprintf("%%22%s%%22", gsub(" ", "%20", vec))
  url_vec <- paste0(url_vec, collapse = "%2C%20")
  url_vec <- paste0("%20%28", url_vec, "%29%20")
  return(url_vec)
}
