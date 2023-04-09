#' Get history of a bank by FDIC certificate number or name
#'
#' This function retrieves the history of a bank by either its FDIC certificate number or name. The user can specify which fields to include in the output.
#'
#' @param CERT_or_NAME Either the FDIC certificate number or the name of the bank for which to retrieve history information.
#' @param fields A character vector specifying the fields to include in the output.
#' @param CERT A logical value indicating whether the value in CERT_or_NAME is a FDIC certificate number (default is TRUE).
#' @param limit An integer indicating the maximum number of records to retrieve (default and max is 10000).
#'
#' @return A data frame containing the requested history information for the specified bank.
#' @export
#'
#' @examples
#' getHistory(CERT_or_NAME = 3850, c("INSTNAME","CERT","PCITY","PSTALP","PZIP5"))
#' getHistory("Iland",fields=c("INSTNAME","CERT","PCITY","PSTALP","PZIP5"),CERT=FALSE)
#' getHistory(CERT_or_NAME = "JP Morgan", fields =c("INSTNAME","CERT","PCITY","PSTALP","PZIP5"), CERT = FALSE)
getHistory <- function(CERT_or_NAME = NULL, fields, CERT=TRUE, limit=10000){
  stopifnot(!missing(fields))
  url <- paste0(
    "https://banks.data.fdic.gov/api/history?",
    ifelse(CERT,
           paste0("filters=CERT%3A%20",CERT_or_NAME),
           paste0("search=NAME%3A%20%27",gsub(" ","%20",CERT_or_NAME),"%27")
           ),
    "&fields=CERT%2C",
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
        ID = NULL
      )
    return(df)
  }, error = function(e) {
    message("ERROR: ", conditionMessage(e))
    return(NULL)
  })
}
