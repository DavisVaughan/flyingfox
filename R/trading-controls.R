#' Trading controls
#'
#' These controls ensure that your algorithm is performing as expected.
#' The controls act as guards against certain actions such as ordering
#' black listed stocks, shorting, or exceeding a maximum leverage
#' threshold.
#'
#' @param restricted_list A list of assets that cannot be ordered.
#' @param on_error How to proceed on a control error. The default is
#' to stop the backtest. Another option is `"log"` to log the error
#' and continue.
#' @param asset An asset. If provided, guard only on positions in
#' the given asset.
#' @param max_count An integer. The maximum number of orders that can be placed
#' on a single day.
#' @param max_shares An integer. The maximum number of shares that can
#' be ordered at any one time.
#' @param max_notional The maximum value that can be ordered at any one time.
#'
#' @section Zipline Documentation:
#'
#' - [`fly_control_set_do_not_order_list()`](https://www.zipline.io/appendix.html#zipline.api.set_do_not_order_list)
#' - [`fly_control_set_long_only()`](https://www.zipline.io/appendix.html#zipline.api.set_long_only)
#' - [`fly_control_set_max_leverage()`](https://www.zipline.io/appendix.html#zipline.api.set_max_leverage)
#' - [`fly_control_set_max_order_count()`](https://www.zipline.io/appendix.html#zipline.api.set_max_order_count)
#' - [`fly_control_set_max_order_size()`](https://www.zipline.io/appendix.html#zipline.api.set_max_order_size)
#' - [`fly_control_set_max_position_size()`](https://www.zipline.io/appendix.html#zipline.api.set_max_position_size)
#'
#' @details
#'
#' - `fly_control_set_do_not_order_list()` - Place a restriction on which assets
#' can be ordered.
#'
#' - `fly_control_set_long_only()` - Specify that this algorithm cannot take
#' short positions.
#'
#' - `fly_control_set_max_leverage()` - Set a limit on the maximum leverage
#' allowed.
#'
#' - `fly_control_set_max_order_count()` - Set a limit on the number of orders
#' that can be placed in a single day.
#'
#' - `fly_control_set_max_order_size()` - Set a limit on the number of shares
#' and/or the dollar value of any single order placed for the specified
#' asset. Limits are treated as absolute values. Limits are only enforced at
#' the time of order, meaning it is possible to end up with more than the
#' max number of shares due to splits/dividends, and more than the max
#' notional due to price improvement.
#'
#' - `fly_control_set_max_position_size()` - Set a limit on the number of shares
#' and/or the dollar value held for a single asset.
#'
#' @name trading-controls
#' @export
fly_control_set_do_not_order_list <- function(restricted_list,
                                              on_error = "fail") {

  if(!inherits(restricted_list, "list")) {
    stop("`restricted_list` must be a list of assets.", call. = FALSE)
  }

  are_zipline_assets <- vapply(
    X = restricted_list,
    FUN = function(x) {is_zipline_asset(x)},
    FUN.VALUE = logical(1L)
  )

  if(any(!are_zipline_assets)) {
    idx <- paste(which(!are_zipline_assets), collapse = ", ")
    stop("All elements of `restricted_list` must be zipline assets.\n",
         "The following elements are not: ", idx, "\n",
         "Create them with fly_symbol().",
         call. = FALSE)
  }

  zipline$api$set_do_not_order_list(
    restricted_list = restricted_list,
    on_error = on_error
  )
}

#' @rdname trading-controls
#' @export
fly_control_set_long_only <- function(on_error = "fail") {
  zipline$api$set_long_only(on_error = on_error)
}

#' @rdname trading-controls
#' @export
fly_control_set_max_leverage <- function(max_leverage) {
  zipline$api$set_max_leverage(max_leverage = max_leverage)
}

#' @rdname trading-controls
#' @export
fly_control_set_max_order_count <- function(max_count, on_error = "fail") {
  max_count <- as_integer(max_count)
  zipline$api$set_max_order_count(max_count = max_count, on_error = on_error)
}

#' @rdname trading-controls
#' @export
fly_control_set_max_order_size <- function(asset = NULL,
                                           max_shares = NULL,
                                           max_notional = NULL,
                                           on_error = "fail") {

  max_shares <- as_integer(max_shares)

  zipline$api$set_max_order_size(
   asset = asset,
   max_shares = max_shares,
   max_notional = max_notional,
   on_error = on_error
  )

}

#' @rdname trading-controls
#' @export
fly_control_set_max_position_size <- function(asset = NULL,
                                              max_shares = NULL,
                                              max_notional = NULL,
                                              on_error = "fail") {

  max_shares <- as_integer(max_shares)

  zipline$api$set_max_position_size(
    asset = asset,
    max_shares = max_shares,
    max_notional = max_notional,
    on_error = on_error
  )

}




