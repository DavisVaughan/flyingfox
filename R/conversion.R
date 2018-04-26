py_to_r.zipline.assets._assets.Equity <- function(x) {
  x_dict <- x$to_dict()

  converted <- lapply(
    X = x_dict,
    FUN = function(.x) {
      if (inherits(.x, "python.builtin.object")) {
        py_to_r(.x)
      } else {
        .x
      }
    }
  )

  converted <- lapply(converted, function(.x) {if(is.null(.x)) NA else .x})
  as.data.frame(converted)
}
