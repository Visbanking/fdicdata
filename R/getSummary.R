#' Get Summary Data from FDIC API
#'
#' This function retrieves summary data from the FDIC API based on given state names,
#' a range of years, and specified fields. The returned data frame includes columns
#' for state name, year, CB_SI, and the specified fields.
#'
#' @param states a character vector of state names to filter by
#' @param range a numeric vector of length two representing the beginning and ending
#' years to filter by. If NULL, no year filtering will occur.
#' @param fields a character vector of field names to include in the output data frame
#' @param limit an integer specifying the maximum number of rows to retrieve from the API
#' @import dplyr
#' @return a data frame with summary data for the given states, years, and fields
#' @export
#'
#' @examples
#' df <- getSummary(c("West Virginia", "Delaware", "Alabama"), c(2015, 2016), c("ASSET", "INTINC"))

getSummary <- function(states, range, fields, limit = 10000){
  stopifnot(!missing(states), !missing(range),!missing(fields))
  if(!is.null(range)){ stopifnot(length(range) == 2) }
  url <- paste0(
    "https://banks.data.fdic.gov/api/summary?",
    ifelse(length(states)>1,
           paste0("filters=STNAME%3A%20%28%22",
                  states2URL(states),
                  "%22%29%20AND%20YEAR%3A%5B%22",
                  range[1],"%22%20TO%20%22",range[2],
                  "%22%5D"),
           paste0("filters=STNAME%3A%20%20%20%28%22",
                  gsub(" ", "%20", states),"%22%29%20AND%20YEAR%3A%5B%22",
                  range[1],"%22%20TO%20%22",range[2],"%22%5D")
    ),
    "&fields=STNAME%2CYEAR%2CCB_SI%2C",
    paste(fields, collapse = '%2C'),
    "&sort_by=STNAME%2CYEAR&sort_order=DESC",
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
