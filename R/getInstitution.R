#' Retrieve institution data from FDIC API
#'
#' This function retrieves institution data from the FDIC API based on the specified parameters.
#'
#' @param name (optional) A character string to search for in the institution name.
#' @param fields A character vector of field names to retrieve from the API.
#' @param limit An integer specifying the maximum number of records to retrieve. Default is 10000.
#' @param IDRSSD_or_CERT IDRSSD or CERT of bank
#' @param IDRSSD Default:TRUE functions uses IDRSSD, to using CERT change it FALSE
#'
#' @return A data frame containing the institution data.
#' @export
#'
#' @examples
#' df <- getInstitution(name = "Bank of America", fields = c("NAME", "CITY", "STATE"))
#'
#' @references
#' For more information on the FDIC API, visit https://banks.data.fdic.gov/.
#'
#' @import dplyr

getInstitution <- function(name = NULL, IDRSSD_or_CERT = NULL, fields, IDRSSD = TRUE, limit=10000){
  if(!is.null(name) && !is.null(IDRSSD_or_CERT)){
    stop("Please use only 'name' or 'IDRRSD_or_CERT' parameter.")
  }
  url <- paste0(
    "https://banks.data.fdic.gov/api/institutions?",
    ifelse(!is.null(name),  paste0("search=NAME%3A%20%27",gsub(" ","%20",name),"%27"),""),
    ifelse(!is.null(IDRSSD_or_CERT),
           ifelse(IDRSSD==TRUE,paste0("filters=FED_RSSD%3A%20",IDRSSD_or_CERT)
                              ,paste0("filters=CERT%3A%20",IDRSSD_or_CERT))
           ,""),
    "&fields=FED_RSSD%2CREPDTE%2C",
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
        REPDTE =  as.Date(as.character(get('REPDTE')), "%m/%d/%Y"),
        IDRSSD = get('FED_RSSD')
      )%>%
      select(-'FED_RSSD')

    return(df)
  }, error = function(e) {
    message("ERROR: ", conditionMessage(e))
    return(NULL)
  })
}
