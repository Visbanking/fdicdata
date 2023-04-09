#' Read FDIC Institution data set
#'
#' This function reads the FDIC Institution data set from a URL (FDIC listing of all institutions) and returns it as a data frame.
#'
#' @return A data frame containing the FDIC Institution data set
#' @export
#' @examples
#' dataInstitutions <- getInstitutionsAll()
#'
#' @export
getInstitutionsAll <- function(){
  message("It can takes few min")
  tryCatch({
    df <- read.csv("https://s3-us-gov-west-1.amazonaws.com/cg-2e5c99a6-e282-42bf-9844-35f5430338a5/downloads/institutions.csv")
    return(df)
  }, error = function(e) {
    message("ERROR: URL Changed please contact with package owner.")
    return(NULL)
  })
  return(df)
}
