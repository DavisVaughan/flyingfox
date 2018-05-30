# Named arguments that get recorded at each tick

#' @export
fly_record <- function(...) {
  zipline$api$record(...)
}

#' @export
fly_fetch_csv <- function(
  pre_func = NULL,
  post_func = NULL,
  date_column = "date",
  date_format = NULL,
  timezone = "UTC",
  symbol = NULL,
  mask = TRUE,
  symbol_column = NULL,
  special_params_checker = NULL,
  ...) {

  zipline$api$fetch_csv(
    pre_func = pre_func,
    post_func = post_func,
    date_column = date_column,
    date_format = date_format,
    timezone = timezone,
    symbol = symbol,
    mask = mask,
    symbol_column = symbol_column,
    special_params_checker = special_params_checker,
    ...)
}
