#' Commission
#'
#' Control the commission model used for the backtest. Commission
#' can be calculated per trade, per share, or per dollar.
#'
#' @param us_equities The commission model to use for trading US equities
#' @param us_futures The commission model to use for trading US futures
#' @param cost The amount of commissions paid per dollar/share/trade.
#' @param min_trade_cost The minimum amount of commissions paid per trade.
#'
#' @section Zipline Documentation:
#'
#' - [`fly_set_commission()`](https://www.zipline.io/appendix.html#zipline.finance.commission.CommissionModel)
#' - [`PerShare()`](https://www.zipline.io/appendix.html#zipline.finance.commission.PerShare)
#' - [`PerTrade()`](https://www.zipline.io/appendix.html#zipline.finance.commission.PerTrade)
#' - [`PerDollar()`](https://www.zipline.io/appendix.html#zipline.finance.commission.PerDollar)
#'
#' @details
#'
#' - `fly_set_commission()` - Set the commission model for the backtest.
#'
#' - `PerShare()` - Calculates a commission for a transaction based on a per
#' share cost with an optional minimum cost per trade.
#'
#' - `PerTrade()` - Calculates a commission for a transaction based on a per
#' trade cost.
#'
#' - `PerDollar()` - Calculates a commission for a transaction based on a
#' per dollar cost.
#'
#' @name commission
#' @export
fly_set_commission <- function(us_equities = NULL, us_futures = NULL) {
  zipline$api$set_commission(us_equities = us_equities, us_futures = us_futures)
}

#' @rdname commission
#' @export
#'
PerShare <- function(cost = 0.001, min_trade_cost = 0.0) {
  zipline$finance$commission$PerShare(cost = cost,
                                      min_trade_cost = min_trade_cost)
}

#' @rdname commission
#' @export
#'
PerTrade <- function(cost = 0.0) {
  zipline$finance$commission$PerTrade(cost = cost)
}

#' @rdname commission
#' @export
#'
PerDollar <- function(cost = 0.0015) {
  zipline$finance$commission$PerDollar(cost = cost)
}
