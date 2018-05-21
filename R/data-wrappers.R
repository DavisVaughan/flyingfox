#' Methods for the zipline `data` object
#'
#' `fly_data_history()` is used to retrieve historical data about the asset.
#' `fly_data_current()` is used to retrieve the data as of the current
#' trading date. See below for additional documentation.
#'
#' @param data The `data` object.
#' @param assets A zipline asset or list of assets. Often created from `fly_symbol()`.
#' @param fields A string field or vector of fields. Accepted fields are
#' `"low"`, `"close"`, `"volume"`, `"price"`, and `"last_traded"`.
#' @param bar_count Integer number of bars of historical trade data requested.
#' @param frequency Frequency of historical data requested.
#' `"1m"` for minutely data or `"1d"` for daily data.
#'
#' @section Zipline Documentation:
#'
#' * [fly_data_history()](https://www.zipline.io/appendix.html#zipline.protocol.BarData.history)
#' * [fly_data_current()](https://www.zipline.io/appendix.html#zipline.protocol.BarData.current)
#' * [fly_data_is_stale()](https://www.zipline.io/appendix.html#zipline.protocol.BarData.is_stale)
#' * [fly_data_can_trade()](https://www.zipline.io/appendix.html#zipline.protocol.BarData.can_trade)
#'
#' @name zipline-data
#'
#' @export
fly_data_history <- function(data, assets, fields = "price", bar_count = 100L, frequency = "1d") {
  bar_count <- as_integer(bar_count)
  data$history(assets = assets, fields = fields, bar_count = bar_count, frequency = frequency)
}

#' @rdname zipline-data
#' @export
fly_data_current <- function(data, assets, fields = "price") {
  data$current(assets = assets, fields = fields)
}

#' @rdname zipline-data
#' @export
fly_data_is_stale <- function(data, assets) {
  data$is_stale(assets = assets)
}

#' @rdname zipline-data
#' @export
fly_data_can_trade <- function(data, assets) {
  data$is_stale(assets = assets)
}
