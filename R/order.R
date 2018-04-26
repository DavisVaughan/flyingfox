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
