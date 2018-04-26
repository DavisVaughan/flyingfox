#' @export
fly_symbol <- function(symbol_str) {
  zipline$api$symbol(symbol_str = symbol_str)
}

# A list of symbols. list("AAPL", "MSFT")
# Alternatively could use zipline$api$symbols("AAPL", "MSFT") but
# hard to pass a large number of them

#' @export
fly_symbols <- function(symbol_list) {
  do.call(zipline$api$symbols, symbol_list)
}

#' @export
fly_future_symbol <- function(symbol) {
  zipline$api$future_symbol(symbol)
}

#' @export
fly_sid <- function(sid) {
  zipline$api$sid(sid)
}
