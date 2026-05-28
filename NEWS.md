# fdicdata 0.1.2

* All FDIC API wrappers now fail gracefully with an informative `message()` and
  return `NULL` when the resource is unavailable, the request times out, or the
  server returns an HTTP error (CRAN policy on Internet resources).
* Added internal `.fetch_csv()` / `.fetch_raw()` helpers using `httr::GET()`
  with an explicit `timeout()` and HTTP status check.
* `getTaxonomy()` and `dataTaxonomy()` now propagate `NULL` on failure instead
  of writing an error response to disk.
* Examples that hit the FDIC API are wrapped in `\donttest{}`.
* Tests that require network access are skipped on CRAN and when the FDIC host
  is unreachable.
* Updated taxonomy endpoint from `banks.data.fdic.gov/docs/` to
  `api.fdic.gov/banks/docs/` after FDIC moved the documentation host;
  `dataTaxonomy()` now returns the parsed YAML again.

# fdicdata 0.1.0

* Added a `NEWS.md` file to track changes to the package.
* Notes solved.
