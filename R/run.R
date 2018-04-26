#' @export
fly_run_algorithm <- function(start = NULL, end = NULL, capital_base = 10000, bundle = "quandl") {

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

  main$py_run(
    start = start,
    end = end,
    capital_base = capital_base,
    bundle = bundle
  )
}
