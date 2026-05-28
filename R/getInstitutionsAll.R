#' Read FDIC Institution data set
#'
#' This function reads the FDIC Institution data set from a URL (FDIC listing
#' of all institutions) and returns it as a data frame.
#'
#' @return A data frame containing the FDIC Institution data set, or
#'   \code{NULL} if the resource is unreachable or returns an error.
#' @export
#' @examples
#' \donttest{
#' dataInstitutions <- getInstitutionsAll()
#' }

getInstitutionsAll <- function(){
  message("It can take a few minutes")
  url <- "https://s3-us-gov-west-1.amazonaws.com/cg-2e5c99a6-e282-42bf-9844-35f5430338a5/downloads/institutions.csv"
  .fetch_csv(url, timeout = 300)
}
