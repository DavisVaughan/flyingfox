is_zipline_asset <- function(x) {
  inherits(x, "zipline.assets._assets.Asset")
}
