#' @export
install_zipline <- function(envname = "r-reticulate", method = "auto", conda = "auto") {
  reticulate::py_install("zipline", envname = envname, method = method, conda = conda)
}
