<img align="right" width="220" height="240" src="https://drive.google.com/uc?export=download&id=1PtkcqH3YYrlMaqz79pbWJosSVNW4hnba">

# fdicdata
<!-- badges: start -->
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN status](https://www.r-pkg.org/badges/version/fdicdata)](https://cran.r-project.org/package=fdicdata)
[![](https://cranlogs.r-pkg.org/badges/fdicdata)](https://cran.rstudio.com/web/packages/fdicdata/index.html)
[![](http://cranlogs.r-pkg.org/badges/last-week/fdicdata?color=green)](https://cran.r-project.org/package=fdicdata)
<!-- badges: end -->

The fdicdata R package provides a set of functions for working with data from the Federal Deposit Insurance Corporation (FDIC), including retrieving financial data for FDIC-insured institutions and accessing the data taxonomy.


## Installation

### From CRAN

```r 
install.packages("fdicdata")
```

### From GitHub

``` r
remotes::install_github("Visbanking/fdicdata",ref="main")
```

## Examples

### Taxonomy

``` r
dataTaxonomy("financial")
```

### Institutions

``` r
# Getting all data
getInstitutionsAll()

# Get data for specific bank (name uses fuzzy match "Iland"~"Island") 
getInstitution(name = "Bank of America", fields = c("NAME", "CITY", "STATE"))
```

### Location

``` r
# Get location information for a bank with CERT number 3850
getLocation(3850)

# Get location information for a bank with CERT number 3850 and fields "NAME", "CITY", and "ZIP"
getLocation(3850, fields = c("NAME", "CITY", "ZIP"))
# Getting all location data for a bank.
getLocation(3850 ,fields = dataTaxonomy("location")$Name)
```

### History

``` r
getHistory(CERT_or_NAME = 3850, c("INSTNAME","CERT","PCITY","PSTALP","PZIP5"))
getHistory("Iland",fields=c("INSTNAME","CERT","PCITY","PSTALP","PZIP5"),CERT=FALSE)
# Get data for specific bank (CERT_or_NAME uses fuzzy match "Iland"~"Island") 

getHistory(CERT_or_NAME = "JP Morgan", fields =c("INSTNAME","CERT","PCITY","PSTALP","PZIP5"), CERT = FALSE)
```

### Summary


``` r
getSummary(c("West Virginia", "Delaware", "Alabama"), c(2015, 2016), c("ASSET", "INTINC"))
```

### Financial

``` r
library(fdicdata)
getFinancials(37,"ASSET")
```


``` r

getAllFinancials <- function(IDRSSD_or_CERT,metrics,limit=5){
  all_financials_banks <- data.frame()
  feds <- IDRSSD_or_CERT
  n_feds <- length(feds)
  for (j in 1:n_feds) {
    i <- feds[j]
    message(paste("Processing", i, "(", j, "of", n_feds, ")"))
    retry <- 0
    success <- FALSE
    while (!success && retry < 3) {
      tryCatch({
        suppressWarnings({
          all_financials_single_bank <- getFinancials(i, metrics, limit = limit)
        })
        all_financials_banks <- rbind(all_financials_single_bank, all_financials_banks)
        message(paste(i, "added to data"))
        success <- TRUE
      }, error = function(e) {
        message(paste("API rejected the request, retrying in 3 minutes..."))
        Sys.sleep( sample(1:30, 1))
        retry <<- retry + 1
      })
    }
    if (!success) {
      message(paste("Could not add", i, "to data after 3 tries"))
    }
  }
  return(all_financials_banks)
}
financial_taxonomy <- dataTaxonomy("financial")
# FDIC Bank Find Suite API limits the data user can pull at once
getAllFinancials(c(37,242),financial_taxonomy$Name[1:100])
```

### Failure

``` r
getFailures(c("CERT", "NAME", "FAILDATE", "CITY", "STATE"), range = c(2010, 2015))
```


