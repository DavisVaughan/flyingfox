#' Lookup Equities
#'
#' Lookup an equity for use in a flyingfox algorithm. These are often assigned
#' to variables in `context` and are used in `handle_data()` to perform computations
#' on the equity's historical prices, or to make an order.
#'
#' @name assets
#'
#' @param symbol The string ticker symbol for the equity to lookup.
#' @param symbol_list The ticker symbols to lookup. Passed as a list like `list("AAPL", "MSFT")`.
#' @param dt The new symbol lookup date. A `Date` or `POSIXct` object.
#' @param sid The unique integer that identifies an asset.
#'
#' @section Zipline Documentation:
#'
#' - [`fly_symbol()`](https://www.zipline.io/appendix.html#zipline.api.symbol)
#' - [`fly_symbols()`](https://www.zipline.io/appendix.html#zipline.api.symbols)
#' - [`fly_future_symbol()`](https://www.zipline.io/appendix.html#zipline.api.future_symbol)
#' - [`fly_set_symbol_lookup_date()`](https://www.zipline.io/appendix.html#zipline.api.set_symbol_lookup_date)
#' - [`fly_sid()`](https://www.zipline.io/appendix.html#zipline.api.sid)
#'
#' @details
#'
#' - `fly_symbol()` - Lookup an Equity by its ticker symbol.
#'
#' - `fly_symbols()` - Lookup multiple Equities as a list.
#'
#' - `fly_future_symbol()` - Lookup a futures contract with a given symbol.
#'
#' - `fly_set_symbol_lookup_date()` - Set the date for which symbols will be
#' resolved to their assets (symbols may map to different firms or underlying
#' assets at different times)
#'
#' - `fly_sid()` - Lookup an Asset by its unique asset identifier.
#'
#' @export
fly_symbol <- function(symbol) {
  zipline$api$symbol(symbol_str = symbol)
}

#' @rdname assets
#' @export
fly_symbols <- function(symbol_list) {
  do.call(zipline$api$symbols, symbol_list)
}

#' @rdname assets
#' @export
fly_future_symbol <- function(symbol) {
  zipline$api$future_symbol(symbol)
}

#' @rdname assets
#' @export
fly_set_symbol_lookup_date <- function(dt) {
  dt <- as_datetime(dt)
  zipline$api$set_symbol_lookup_date(dt)
}

#' @rdname assets
#' @export
fly_sid <- function(sid) {
  sid <- as_integer(sid)
  zipline$api$sid(sid)
}
