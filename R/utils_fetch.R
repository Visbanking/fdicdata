#' Fetch a URL and return parsed CSV, or NULL on any failure
#'
#' Internal helper used by all FDIC API wrappers so the package fails
#' gracefully when the resource is unavailable (per CRAN policy).
#'
#' @param url Character. URL to fetch.
#' @param timeout Numeric. Seconds before the request is aborted.
#' @return A data.frame on success, or NULL with an informative message on failure.
#' @keywords internal
#' @importFrom httr GET timeout http_error status_code content
#' @importFrom utils read.csv
#' @noRd
.fetch_csv <- function(url, timeout = 60) {
  resp <- tryCatch(
    suppressWarnings(httr::GET(url, httr::timeout(timeout))),
    error = function(e) e
  )
  if (inherits(resp, "error")) {
    message("FDIC API request failed: ", conditionMessage(resp))
    return(NULL)
  }
  if (httr::http_error(resp)) {
    message("FDIC API returned HTTP ", httr::status_code(resp), " for ", url)
    return(NULL)
  }
  txt <- tryCatch(
    httr::content(resp, as = "text", encoding = "UTF-8"),
    error = function(e) e
  )
  if (inherits(txt, "error") || is.null(txt) || !nzchar(txt)) {
    message("FDIC API returned an empty or unreadable response.")
    return(NULL)
  }
  df <- tryCatch(
    suppressWarnings(utils::read.csv(text = txt, header = TRUE)),
    error = function(e) e,
    warning = function(w) w
  )
  if (inherits(df, c("error", "warning")) || !is.data.frame(df)) {
    message("FDIC API response could not be parsed as CSV.")
    return(NULL)
  }
  df
}

#' Fetch raw bytes from a URL, or NULL on any failure
#'
#' @param url Character. URL to fetch.
#' @param timeout Numeric. Seconds before the request is aborted.
#' @return A raw vector on success, or NULL with an informative message on failure.
#' @keywords internal
#' @importFrom httr GET timeout http_error status_code content
#' @noRd
.fetch_raw <- function(url, timeout = 60) {
  resp <- tryCatch(
    suppressWarnings(httr::GET(url, httr::timeout(timeout))),
    error = function(e) e
  )
  if (inherits(resp, "error")) {
    message("FDIC resource request failed: ", conditionMessage(resp))
    return(NULL)
  }
  if (httr::http_error(resp)) {
    message("FDIC resource returned HTTP ", httr::status_code(resp), " for ", url)
    return(NULL)
  }
  httr::content(resp, as = "raw")
}
