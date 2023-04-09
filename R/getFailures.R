#' Get information on bank failures from FDIC data
#'
#' This function retrieves information on bank failures from the FDIC data
#' API, using the specified fields and (optional) date range. If a date range is
#' specified, only failures within that range will be included.
#'
#' @param fields a character vector specifying the fields to include in the
#'   output.
#' \describe{
#'   \item{NAME}{The name of the failed bank}
#'   \item{CERT}{The FDIC certificate number of the failed bank}
#'   \item{FIN}{The failed bank's unique financial institution identifier}
#'   \item{CITYST}{The city and state where the failed bank was located}
#'   \item{FAILDATE}{The date of the bank failure}
#'   \item{FAILYR}{The year of the bank failure}
#'   \item{SAVR}{Whether the failed bank was a savings and loan association}
#'   \item{RESTYPE}{The type of failed institution}
#'   \item{RESTYPE1}{A more specific classification of the failed institution}
#'   \item{CHCLASS1}{The bank's charter class}
#'   \item{QBFDEP}{The amount of deposits held by the bank at the time of failure}
#'   \item{QBFASSET}{The total assets held by the bank at the time of failure}
#'   \item{COST}{The estimated cost to the FDIC of the bank's failure}
#'   \item{PSTALP}{The FDIC's estimated percentage of insured deposits paid to depositors}
#' }
#' @param range a numeric vector of length 2 specifying the start and end dates
#'   (in YYYY format) for the date range to include. If not specified, all
#'   failures will be included.
#' @param limit an integer specifying the maximum number of results to return.
#'   Defaults to 10,000.
#'
#' @return a data frame containing the requested fields for each bank failure
#'   within the specified date range (if applicable).
#' @import dplyr
#' @importFrom utils read.csv
#' @export
#'
#' @examples
#' df <- getFailures(c("CERT", "NAME", "FAILDATE", "CITY", "STATE"), range = c(2010, 2015))
#' head(df)
#'
getFailures <- function(fields, range = NULL, limit = 10000){
  stopifnot(!missing(fields))
  if(!is.null(range)){
    stopifnot(length(range) == 2)
    stopifnot(nchar(range[1]) == 4, nchar(range[2]) == 4)
    stopifnot(range[1] <= range[2])
    }

  url <- paste0(
    "https://banks.data.fdic.gov/api/failures?",
    ifelse(is.null(range),"",paste0("filters=FAILYR%3A%5B%22",range[1],"%22%20TO%20%22",range[2],"%22%5D" )),

    "&fields=CERT%2CNAME%2CFAILDATE%2C",
    paste(fields, collapse = '%2C'),
    paste0("&limit=",limit),
    "&format=csv&download=false&filename=data_file"
  )
  tryCatch({
    suppressWarnings(
      df <- read.csv(url,header=TRUE)
    )
    df <- df %>%
      mutate(
        ID = NULL,
        FAILDATE =  as.Date(as.character(get('FAILDATE')), "%m/%d/%Y")
      )
    return(df)
  }, error = function(e) {
    message("ERROR: ", conditionMessage(e))
    return(NULL)
  })
}
