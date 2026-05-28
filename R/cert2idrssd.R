#' Convert bank identifier from CERT to IDRSSD
#'
#' This function takes a bank's CERT number as input and returns the corresponding IDRSSD number.
#'
#' @param CERT An integer specifying the CERT number of the bank.
#'
#' @return An integer specifying the IDRSSD number of the bank. Returns
#'   \code{NULL} if there is an error or the FDIC API is unreachable.
#'
#' @examples
#' \donttest{
#' cert2idrssd(3850)
#' }
#' @export

cert2idrssd <- function(CERT){
  df <- getFinancials(CERT, "FED_RSSD", IDRSSD = FALSE)
  if (is.null(df)) return(NULL)
  df$IDRSSD
}

#' Convert bank identifier from IDRSSD to CERT
#'
#' This function takes a bank's IDRSSD number as input and returns the corresponding CERT number.
#'
#' @param IDRSSD An integer specifying the IDRSSD number of the bank.
#'
#' @return An integer specifying the CERT number of the bank. Returns
#'   \code{NULL} if there is an error or the FDIC API is unreachable.
#'
#' @examples
#' \donttest{
#' idrssd2cert(37)
#' }
#' @export

idrssd2cert <- function(IDRSSD){
  df <- getFinancials(IDRSSD, "CERT")
  if (is.null(df)) return(NULL)
  df$CERT
}
