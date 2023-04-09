#' Get financial data for a given institution
#'
#' This function retrieves financial data for a given institution from the FDIC API.
#'
#' @param IDRSSD_or_CERT Numeric value indicating the IDRSSD or CERT number of the institution to retrieve data for.
#' @param metrics Vector of metric names to retrieve financial data for.
#' @param limit Number of records to retrieve.
#' @param IDRSSD Boolean value indicating whether IDRSSD (True) or CERT number (False) is used.
#' @param range Character vector contains start and end date for range. Open ended ranges can be expressed using a "*"
#' @import dplyr
#' @return A dataframe containing the requested financial data.
#' @export
#' @references
#' For more information on the FDIC API, visit https://banks.data.fdic.gov/.
#' @examples
#' getFinancials(37, metrics = c("ASSET", "DEP"),limit = 10, range = c("2015-01-01","*"))
#' getFinancials(37, metrics = c("ASSET", "DEP"),limit = 10, range = c("2015-01-01","2016-01-01"))
getFinancials <- function(IDRSSD_or_CERT, metrics, limit = 1, IDRSSD = TRUE, range = NULL) {
  stopifnot(!missing(IDRSSD_or_CERT), !missing(metrics))
  stopifnot(is.numeric(IDRSSD_or_CERT))
  if(!is.null(range)){ stopifnot(length(range) == 2) }

    url <- paste0(
      "https://banks.data.fdic.gov/api/financials?filters=",ifelse(IDRSSD == TRUE,"RSSDID","CERT") ,"%3A%20",
      IDRSSD_or_CERT,ifelse(is.null(range),"",paste0("%20AND%20REPDTE%3A%5B",range[1],"%20TO%20",range[2],"%5D")),
      "&fields=RSSDID%2CREPDTE%2C",
      paste(metrics, collapse = '%2C'),
      "&sort_by=REPDTE&sort_order=DESC&limit=",
      limit,
      "&offset=0&agg_term_fields=REPDTE&format=csv&download=false&filename=data_file"
    )

  tryCatch({
    suppressWarnings(
      df <- read.csv(url,header=TRUE)
      )
    df <- df %>%
      mutate(
        ID = NULL,
        DATE =  as.Date(as.character(get('REPDTE')), "%Y%m%d")
      ) %>%
      select(-'REPDTE') %>%
      rename("IDRSSD" = "RSSDID")

    return(df)
  }, error = function(e) {
    message("ERROR: ", conditionMessage(e))
    return(NULL)
  })
}
