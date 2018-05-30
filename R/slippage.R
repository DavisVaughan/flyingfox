#' Slippage
#'
#' Control the slippage model used for the backtest. Slippage
#' can be calculated as a fixed spread or as a function of the volume traded.
#'
#' @param us_equities The slippage model to use for trading US equities
#' @param us_futures The slippage model to use for trading US futures
#' @param spread `spread / 2` will be added to buys and subtracted from sells.
#' @param volume_limit The equity volume slippage limit.
#' @param price_impact The amount of impact the slippage has on price.
#'
#' @section Zipline Documentation:
#'
#' - [`fly_set_slippage()`](https://www.zipline.io/appendix.html#zipline.api.set_slippage)
#' - [`FixedSlippage()`](https://www.zipline.io/appendix.html#zipline.finance.slippage.FixedSlippage)
#' - [`VolumeShareSlippage()`](https://www.zipline.io/appendix.html#zipline.finance.slippage.VolumeShareSlippage)
#'
#' @details
#'
#' - `fly_set_slippage()` - Set the slippage model for the backtest.
#'
#' - `FixedSlippage()` - Model slippage as a fixed spread.
#'
#' - `VolumeShareSlippage()` - Model slippage as a function of the volume of contracts traded.
#'
#' @name slippage
#' @export
fly_set_slippage <- function(us_equities = NULL, us_futures = NULL) {
  zipline$api$set_slippage(us_equities = us_equities, us_futures = us_futures)
}

#' @rdname slippage
#' @export
#'
FixedSlippage <- function(spread = 0.0) {
  zipline$finance$slippage$FixedSlippage(spread = spread)
}

#' @rdname slippage
#' @export
#'
VolumeShareSlippage <- function(volume_limit = 0.025, price_impact = 0.1) {
  zipline$finance$slippage$VolumeShareSlippage(volume_limit = volume_limit,
                                               price_impact = price_impact)
}
