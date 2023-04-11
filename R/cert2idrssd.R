#' Convert bank identifier from CERT to IDRSSD
#'
#' This function takes a bank's CERT number as input and returns the corresponding IDRSSD number.
#'
#' @param CERT An integer specifying the CERT number of the bank.
#'
#' @return An integer specifying the IDRSSD number of the bank. Returns NULL if there is an error.
#'
#' @examples
#' cert2idrssd(3850)
#' @export

cert2idrssd <- function(CERT){
  tryCatch({
    df <- getFinancials(CERT,"FED_RSSD",IDRSSD = FALSE)
    idrssd <- df$IDRSSD
    return(idrssd)
  }, error = function(e) {
    message("ERROR: ", conditionMessage(e))
    return(NULL)
  })
}

#' Convert bank identifier from IDRSSD to CERT
#'
#' This function takes a bank's IDRSSD number as input and returns the corresponding CERT number.
#'
#' @param IDRSSD An integer specifying the IDRSSD number of the bank.
#'
#' @return An integer specifying the CERT number of the bank. Returns NULL if there is an error.
#'
#' @examples
#' idrssd2cert(37)
#' @export

idrssd2cert <- function(IDRSSD){
  tryCatch({
    df <- getFinancials(IDRSSD,"CERT")
    cert <- df$CERT
    return(cert)
  }, error = function(e) {
    message("ERROR: ", conditionMessage(e))
    return(NULL)
  })
}
