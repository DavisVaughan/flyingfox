#' @export
install_zipline <- function(envname = "r-reticulate", method = c("auto", "virtualenv", "conda"), conda = "auto", ...) {
  reticulate::py_install("zipline", envname = envname, method = method, conda = conda, ...)
}

#' @export
fly_ingest <- function(name = "quandl", timestamp = NULL, show_progress = FALSE) {
  # I think there are still arguments to pass here

  if(name == "quandl") {
    # Check for key as an environment variable
    # ingest() will use this.
    quandl_get_api_key()
  }

  if(!is.null(timestamp)) {
    timestamp <- as_datetime(timestamp)
  }

  zipline$data$bundles$ingest(name = name, timestamp = timestamp, show_progress = show_progress)
}

quandl_get_api_key <- function() {
  token <- Sys.getenv("QUANDL_API_KEY")

  if(token == "") {
    stop("Please set your QUANDL_API_KEY as an environment variable in your .Renviron file. ",
         "An easy way to do this is with usethis::edit_r_environ().", call. = FALSE)
  }

  token
}
