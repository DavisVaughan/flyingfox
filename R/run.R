#' @export
fly_run_algorithm <- function(initialize, handle_data, start = NULL, end = NULL,
                              capital_base = 10000, bundle = "quandl",
                              recursive_conversion = TRUE) {

  # Function validation
  if(!is.function(initialize) && !is.function(handle_data)) {
    stop("Both `initialize` and `handle_data` must be functions.", call. = FALSE)
  }

  # be more flexible here! allow for kwargs to initialize and handle_data
  if(all(rlang::fn_fmls_names(initialize) != "context")) {
    stop("The argument to the `initialize` function must be named `context`.")
  }

  if(all(rlang::fn_fmls_names(handle_data) != c("context", "data"))) {
    stop("The arguments to the `handle_data` function must be named `context` and `data`.", call. = FALSE)
  }

  if(is.null(start)) start <- Sys.Date() - 252
  if(is.null(end)) end <- Sys.Date()

  # This should be taken care of when this issue closes https://github.com/rstudio/reticulate/issues/198
  # Then we can remove datetime from zzz.R
  start <- as_datetime(start)
  end <- as_datetime(end)

  ensure_zipline_py_interface_is_available()

  performance <- main$py_run(
    fly_initialize = initialize,
    fly_handle_data = handle_data,
    start = start,
    end = end,
    capital_base = capital_base,
    bundle = bundle
  )

  if(recursive_conversion) {
    performance <- py_to_r_performance_tibble(performance)
  }

  performance
}
