#' Set the benchmark asset
#'
#' Which asset should be used as the benchmark? Any dividends payed out for that
#' benchmark asset will be automatically reinvested.
#'
#' @param benchmark An asset. The asset to be used as the benchmark in the
#' simulation.
#'
#' @section Zipline Documentation:
#'
#' - [`fly_set_benchmark()`](https://www.zipline.io/appendix.html#zipline.api.set_benchmark)
#'
#' @name simulation-parameters
#' @export
fly_set_benchmark <- function(benchmark) {
  zipline$api$set_benchmark(benchmark)
}
