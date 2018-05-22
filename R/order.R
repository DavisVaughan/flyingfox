# ------------------------------------------------------------------------------
# Order placement

#' Order placement
#'
#' Place various types of orders according to amounts, percentages, and targets.
#' Orders can be specified as market, limit, stop, or stop-limit.
#'
#' @param asset The asset that this order is for.
#' @param amount An integer. The amount of shares to order. If amount is
#' positive, this is the number of shares to buy or cover. If amount is negative,
#' this is the number of shares to sell or short.
#' @param value If the requested asset exists, the requested value is divided by
#'  its price to imply the number of shares to transact. If the Asset being
#'  ordered is a Future, the ‘value’ calculated is actually the exposure,
#'  as Futures have no ‘value’. If positive, buy/cover. If negative, sell/short.
#' @param percent The percentage of the portfolio value to allocate to `asset`.
#' This is specified as a decimal, for example: `0.50` means 50 percent.
#' @param target The new `amount`, `value`, or `percent` to adjust to depending
#' on the order target function called.
#' @param limit_price Optional. The limit price for the order.
#' @param stop_price Optional. The stop price for the order.
#' @param style The execution style for the order. The default is `MarketOrder`.
#' See `?MarketOrder` for other execution styles.
#'
#' @section Zipline Documentation:
#'
#' - [`fly_order()`](https://www.zipline.io/appendix.html#zipline.api.order)
#' - [`fly_order_value()`](https://www.zipline.io/appendix.html#zipline.api.order_value)
#' - [`fly_order_percent()`](https://www.zipline.io/appendix.html#zipline.api.order_percent)
#' - [`fly_order_target()`](https://www.zipline.io/appendix.html#zipline.api.order_target)
#' - [`fly_order_target_value()`](https://www.zipline.io/appendix.html#zipline.api.order_target_value)
#' - [`fly_order_target_percent()`](https://www.zipline.io/appendix.html#zipline.api.order_target_percent)
#'
#' @details
#'
#' The limit_price and stop_price arguments provide shorthands for passing
#' common execution styles. Passing `limit_price=N` is equivalent to
#' `style=LimitOrder(N)`. Similarly, passing `stop_price=M` is equivalent to
#' `style=StopOrder(M)`, and passing `limit_price=N` and `stop_price=M`
#' is equivalent to `style=StopLimitOrder(N, M)`.
#' It is an error to pass both a style and limit_price or stop_price.
#'
#' - `fly_order()` - Place an order.
#'
#' - `fly_order_value()` - Place an order by desired value rather than desired
#'  number of shares.
#'
#' - `fly_order_percent()` - Place an order in the specified asset corresponding
#'  to the given percent of the current portfolio value.
#'
#' - `fly_order_target()`, `fly_order_target_value()`, `fly_order_target_percent()` - Place an order to adjust a position to a target
#' number of shares, value, or percent. If the position doesn’t already exist, this is equivalent
#' to placing a new order. If the position does exist, this is equivalent to
#' placing an order for the difference between the target number of shares, value, or percent
#' and the current number of shares, value, or percent.
#'
#' @name order-placement
#' @export
fly_order <- function(asset, amount, limit_price = NULL, stop_price = NULL, style = NULL) {

  amount <- as_integer(amount)

  zipline$api$order(
    asset = asset,
    amount = amount,
    limit_price = limit_price,
    stop_price = stop_price,
    style = style
  )
}

#' @rdname order-placement
#' @export
fly_order_value <- function(asset, value, limit_price = NULL, stop_price = NULL, style = NULL) {
  zipline$api$order_value(
    asset = asset,
    value = value,
    limit_price = limit_price,
    stop_price = stop_price,
    style = style
  )
}

#' @rdname order-placement
#' @export
fly_order_percent <- function(asset, percent, limit_price = NULL, stop_price = NULL, style = NULL) {
  zipline$api$order_percent(
    asset = asset,
    percent = percent,
    limit_price = limit_price,
    stop_price = stop_price,
    style = style
  )
}

#' @rdname order-placement
#' @export
fly_order_target <- function(asset, target, limit_price = NULL, stop_price = NULL, style = NULL) {

  target <- as_integer(target)

  zipline$api$order_target(
    asset = asset,
    target = target,
    limit_price = limit_price,
    stop_price = stop_price,
    style = style
  )
}

#' @rdname order-placement
#' @export
fly_order_target_value <- function(asset, target, limit_price = NULL, stop_price = NULL, style = NULL) {

  zipline$api$order_target_value(
    asset = asset,
    target = target,
    limit_price = limit_price,
    stop_price = stop_price,
    style = style
  )
}

#' @rdname order-placement
#' @export
fly_order_target_percent <- function(asset, target, limit_price = NULL, stop_price = NULL, style = NULL) {

  zipline$api$order_target_percent(
    asset = asset,
    target = target,
    limit_price = limit_price,
    stop_price = stop_price,
    style = style
  )
}

# ------------------------------------------------------------------------------
# Order execution styles

#' Order execution styles
#'
#' The execution style of the order to be placed. This can be a market,
#' limit, stop or stop-limit order. For use with `fly_order()`.
#'
#' @param exchange The exchange to execute the order on.
#' @param limit_price The limit price for the order.
#' @param stop_price The stop price for the order.
#'
#' @section Zipline Documentation:
#'
#' - [`MarketOrder()`](https://www.zipline.io/appendix.html#zipline.finance.execution.MarketOrder)
#' - [`LimitOrder()`](https://www.zipline.io/appendix.html#zipline.finance.execution.LimitOrder)
#' - [`StopOrder()`](https://www.zipline.io/appendix.html#zipline.finance.execution.StopOrder)
#' - [`StopLimitOrder()`](https://www.zipline.io/appendix.html#zipline.finance.execution.StopOrder)
#'
#' @details
#'
#' - `MarketOrder()` - Class encapsulating an order to be placed at the current market price.
#'
#' - `LimitOrder()` - Execution style representing an order to be executed at a
#' price equal to or better than a specified limit price.
#'
#' - `StopOrder()` - Execution style representing an order to be placed once the
#'  market price reaches a specified stop price.
#'
#' - `StopLimitOrder()` - Execution style representing a limit order to be
#' placed with a specified limit price once the market reaches a specified
#' stop price.
#'
#' @seealso [fly_order()]
#'
#' @name order-execution-style
#' @export
MarketOrder <- function(exchange = NULL) {
  zipline$finance$execution$MarketOrder(exchange)
}

#' @rdname order-execution-style
#' @export
LimitOrder <- function(limit_price, exchange = NULL) {
  zipline$finance$execution$LimitOrder(exchange)
}

#' @rdname order-execution-style
#' @export
StopOrder <- function(stop_price, exchange = NULL) {
  zipline$finance$execution$StopOrder(exchange)
}

#' @rdname order-execution-style
#' @export
StopLimitOrder <- function(limit_price, stop_price, exchange = NULL) {
  zipline$finance$execution$StopLimitOrder(exchange)
}

# ------------------------------------------------------------------------------
# Order utilities

#' Order utilities
#'
#' Get and cancel orders.
#'
#' @name order-utilities
#'
#' @param order_id The unique string identifier for the order.
#' @param asset An asset object. If passed and not `NULL`, return only the open orders for the given
#' asset instead of all open orders.
#' @param order_param The `order_id` or order object to cancel.
#'
#' @section Zipline Documentation:
#'
#' - [`fly_get_order()`](https://www.zipline.io/appendix.html#zipline.api.get_order)
#' - [`fly_get_open_orders()`](https://www.zipline.io/appendix.html#zipline.api.get_open_orders)
#' - [`fly_cancel_order()`](https://www.zipline.io/appendix.html#zipline.api.cancel_order)
#'
#' @details
#'
#' - `fly_get_order()` - Lookup an order based on the order id returned from one of the order functions.
#'
#' - `fly_get_open_orders()` - Retrieve all of the current open orders. If an asset
#' is passed, this will only return open orders for that asset.
#'
#' - `fly_cancel_order()` - Cancel an open order.
#'
#' @export
fly_get_order <- function(order_id) {
  zipline$api$get_order(order_id)
}

#' @rdname order-utilities
#' @export
fly_get_open_orders <- function(asset = NULL) {
  zipline$api$get_open_orders(asset)
}

#' @rdname order-utilities
#' @export
fly_cancel_order <- function(order_param) {
  zipline$api$cancel_order(order_param)
}

# ------------------------------------------------------------------------------
# Order cancellation

#' Order cancellation
#'
#' `fly_set_cancel_policy()` sets the cancellation policy for the entire
#' simulation.
#'
#' @name order-cancellation
#'
#' @param cancel_policy The cancellation policy to use. Either `EODCancel()` or
#' `NeverCancel()`.
#'
#' @section Zipline Documentation:
#'
#' - [`fly_set_cancel_policy()`](https://www.zipline.io/appendix.html#zipline.api.set_cancel_policy)
#'
#' @seealso [EODCancel()], [NeverCancel()]
#'
#' @export
fly_set_cancel_policy <- function(cancel_policy) {
  zipline$api$cancel_policy(cancel_policy)
}

# ------------------------------------------------------------------------------
# Order cancellation policies

#' Order cancellation policies
#'
#' For use with `fly_set_cancel_policy()`.
#'
#' @param warn_on_cancel A logical. Should a warning be raised if this causes an
#'  order to be cancelled?
#'
#' @section Zipline Documentation:
#'
#' - [`EODCancel()`](https://www.zipline.io/appendix.html#zipline.api.EODCancel)
#' - [`NeverCancel()`](https://www.zipline.io/appendix.html#zipline.api.NeverCancel)
#'
#' @seealso [fly_set_cancel_policy()]
#'
#' @name order-cancellation-policies
#' @export
EODCancel <- function(warn_on_cancel = TRUE) {
  zipline$api$EODCancel(warn_on_cancel)
}

#' @rdname order-cancellation-policies
#' @export
NeverCancel <- function() {
  zipline$api$NeverCancel()
}
