# ------------------------------------------------------------------------------
# Reexports

#' Convert an R object to Python
#'
#' This function is re-exported from the reticulate package.
#' See [reticulate::r_to_py()] for more details.
#'
#' @name r_to_py
#' @keywords internal
#' @seealso [reticulate::r_to_py()]
#' @export
#' @importFrom reticulate r_to_py
#'
NULL

#' Convert a Python object to R
#'
#' This function is re-exported from the reticulate package.
#' See [reticulate::py_to_r()] for more details.
#'
#' @name py_to_r
#' @keywords internal
#' @seealso [reticulate::py_to_r()]
#' @export
#' @importFrom reticulate py_to_r
#'
NULL

#' @importFrom rlang !!!

# ------------------------------------------------------------------------------
# Utils

as_integer <- function(x) {
  if(is.numeric(x)) {
    as.integer(x)
  } else {
    x
  }
}

ensure_zipline_py_interface_is_available <- function() {
  if(!zipline_interface_is_available()) {
    py_path <- system.file("python", "interface.py", package = "flyingfox")
    reticulate::source_python(py_path)
  }
}

zipline_interface_is_available <- function() {
  tryCatch({
    main$interface_is_available
  },
  error = function(e) {
    FALSE
  })
}
