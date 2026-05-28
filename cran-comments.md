## Resubmission

This is a resubmission of `fdicdata` after it was archived on CRAN. The
archival reason was that the package did not fail gracefully when the FDIC
Internet resource was unavailable.

This release addresses the policy:

* All functions that access `https://banks.data.fdic.gov/` (and the related S3
  download endpoint) now issue the request via `httr::GET()` with an explicit
  `timeout()`, check `http_error()` / `status_code()`, and capture both errors
  and warnings. On any failure they emit an informative `message()` and return
  `NULL` instead of producing a warning or error.
* `getTaxonomy()` no longer writes an error response to disk; it returns
  `NULL` when the resource is unreachable, and `dataTaxonomy()` propagates
  this.
* All `@examples` blocks that hit the FDIC API are wrapped in `\donttest{}`.
* Tests that require network access call `skip_on_cran()` and
  `skip_if_offline("banks.data.fdic.gov")`, and additionally `skip_if(is.null(df))`
  so a transient outage during interactive testing skips rather than fails.

## R CMD check results

0 errors | 0 warnings | 0 notes

Local `R CMD check --as-cran` is clean apart from the standard "New
submission / Package was archived on CRAN" notice, which is expected on
a resubmission.
