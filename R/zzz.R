main     <- NULL
datetime <- NULL
pandas   <- NULL

#' @export
zipline  <- NULL

.onLoad <- function(libname, pkgname) {
  main     <<- reticulate::import("__main__", delay_load = TRUE, convert = TRUE)
  datetime <<- reticulate::import("datetime", delay_load = TRUE, convert = FALSE)
  pandas   <<- reticulate::import("pandas",   delay_load = TRUE, convert = FALSE)

  zipline <<- reticulate::import(
    module = "zipline",
    delay_load = TRUE,
    convert = TRUE
  )
}
