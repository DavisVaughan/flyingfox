#' @export
fly_history <- function(data, assets, fields = "price", bar_count = 100L, frequency = "1d") {
  bar_count <- as_integer(bar_count)
  data$history(assets = assets, fields = fields, bar_count = bar_count, frequency = frequency)
}
