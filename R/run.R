#' @export
fly_run_algorithm <- function(initialize, handle_data, start = NULL, end = NULL, capital_base = 10000, bundle = "quandl", attempt_conversion = TRUE) {

  # Function validation
  if(!is.function(initialize) && !is.function(handle_data)) {
    stop("Both `initialize` and `handle_data` must be functions.", call. = FALSE)
  }

  if(all(rlang::fn_fmls_names(initialize) != "context")) {
    stop("The argument to the `initialize` function must be named `context`.")
  }

  if(all(rlang::fn_fmls_names(handle_data) != c("context", "data"))) {
    stop("The arguments to the `handle_data` function must be named `context` and `data`.", call. = FALSE)
  }

  ensure_r_is_exported()

  if(is.null(start)) start <- Sys.Date() - 252
  if(is.null(end)) end <- Sys.Date()

  start <- as_datetime(start)
  end <- as_datetime(end)

  interface_is_available <- tryCatch(
    expr  = { reticulate::py_to_r(main$interface_is_available) },
    error = function(e) { FALSE }
  )

  if(!interface_is_available) {
    reticulate::source_python("inst/interface.py", convert = FALSE)
  }

  performance <- main$py_run(
    fly_initialize = initialize,
    fly_handle_data = handle_data,
    start = start,
    end = end,
    capital_base = capital_base,
    bundle = bundle
  )

  if(attempt_conversion) {
    py_to_r_performance_tibble(performance)
  } else {
    performance
  }
}
