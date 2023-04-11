#' Taxonomy Data
#'
#' Extracts the taxonomy information for a given name
#'
#' @param name the name of the taxonomy file to extract. Available taxonomy names: "institution","location","history","summary","failure","financial".
#' @import yaml
#' @return a data frame containing the extracted taxonomy information
#' @export

dataTaxonomy <- function(name){

  if(name == "institution"){
    yaml_name <- "institution_properties.yaml"
  }
  else if(name == "location"){
    yaml_name <- "location_properties.yaml"
  }
  else if(name == "history"){
    yaml_name <- "history_properties.yaml"
  }
  else if(name == "summary"){
    yaml_name <- "summary_properties.yaml"
  }
  else if(name == "failure"){
    yaml_name <- "failure_properties.yaml"
  }
  else if(name == "financial"){
    yaml_name <- "risview_properties.yaml"
  }
  else{
    stop("name argument must be one of these: institution, location, history, summary,failure,financial")
  }
  tryCatch({
    getTaxonomy(yaml_name)
    yaml_path <- paste0(tempdir(),yaml_name)
    suppressWarnings(  yaml_data <- yaml::yaml.load_file(yaml_path))
    institution_properties <- data.frame()
    for (prop_name in names(yaml_data$properties$data$properties)) {
      prop_data <- yaml_data$properties$data$properties[[prop_name]]
      type_val <- ifelse(is.null(prop_data$type), "", prop_data$type)
      title_val <- ifelse(is.null(prop_data$title), "", prop_data$title)
      desc_val <- ifelse(is.null(prop_data$description), "", prop_data$description)
      binded <- data.frame(Name = prop_name ,Title = title_val,Description = desc_val,Type = type_val)
      institution_properties <- rbind(binded,institution_properties)
    }
    return(institution_properties)
  }, error = function(e) {
    message("ERROR: ", conditionMessage(e))
    return(NULL)
  })

}

