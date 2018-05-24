#' @export
fly_run_algorithm <- function(initialize,
                              handle_data,
                              start = NULL,
                              end = NULL,
                              capital_base = 10000,
                              before_trading_start = NULL,
                              analyze = NULL,
                              data_frequency = 'daily',
                              data = NULL,
                              bundle = "quandl",
                              bundle_timestamp = NULL,
                              trading_calendar = NULL,
                              metrics_set = 'default',
                              default_extension = TRUE,
                              #extensions=(),
                              strict_extensions = TRUE,
                              #environ=os.environ,
                              recursive_conversion = TRUE) {

  # Function validation
  validate_function_structure(initialize, handle_data)

  # Default dates
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
    before_trading_start = before_trading_start,
    analyze = analyze,
    data_frequency = data_frequency,
    data = data,
    bundle = bundle,
    bundle_timestamp = bundle_timestamp,
    trading_calendar = trading_calendar,
    metrics_set = metrics_set,
    default_extension = default_extension,
    #extensions,
    strict_extensions = strict_extensions #,
    #environ
  )

  if(recursive_conversion) {
    performance <- py_to_r_performance_tibble(performance)
  }

  # Currently reticulate does not convert date columns to POSIXct
  tryCatch(
    expr = {
      performance$date <- as.POSIXct(performance$date, tz = "UTC")
      performance <- tibbletime::as_tbl_time(performance, index = date)
    },
    error = function(e) {
      message("Could not convert the date column to POSIXct. A tibble will be returned.\n")
      warning(e)
    })

  performance
}

validate_function_structure <- function(initialize, handle_data) {

  if(!is.function(initialize) && !is.function(handle_data)) {
    stop("Both `initialize` and `handle_data` must be functions.", call. = FALSE)
  }

  validate_initialize_arguments(initialize)
  validate_handle_data_arguments(handle_data)
}


validate_initialize_arguments <- function(.f) {
  arg_names <- rlang::fn_fmls_names(.f)

  # In this case, assume the user has used purrr::partial() to add flexible arguments
  if(length(arg_names) == 1L && arg_names == "...") {
    return()
  }

  # Otherwise, enforce structure
  bad_args <- FALSE
  if(length(arg_names) != 1L) bad_args <- TRUE
  if(arg_names != "context") bad_args <- TRUE

  if(bad_args) {
    stop("There must be 1 argument to the `initialize()` function, and it must be named `context`.", call. = FALSE)
  }
}

validate_handle_data_arguments <- function(.f) {
  arg_names <- rlang::fn_fmls_names(.f)

  # In this case, assume the user has used purrr::partial() to add flexible arguments
  if(length(arg_names) == 1L && arg_names == "...") {
    return()
  }

  # Otherwise, enforce structure
  bad_args <- FALSE
  if(length(arg_names) != 2L) bad_args <- TRUE
  if(all(arg_names != c("context", "data"))) bad_args <- TRUE

  if(bad_args) {
    stop("There must be 2 arguments to the `handle_data()` function and they must be named `context` and `data`, in that order.", call. = FALSE)
  }
}
