main     <- NULL
datetime <- NULL
zipline  <- NULL

.onLoad <- function(libname, pkgname) {
  main     <<- reticulate::import("__main__", delay_load = TRUE, convert = FALSE)
  datetime <<- reticulate::import("datetime", delay_load = TRUE, convert = FALSE)
  pandas   <<- reticulate::import("pandas",   delay_load = TRUE, convert = FALSE)

  zipline <<- reticulate::import(
    module = "zipline",
    # Until RStudio fixes this, ensure R is over there
    delay_load = function() {
        export_r()
    },
    convert = FALSE
  )
}
