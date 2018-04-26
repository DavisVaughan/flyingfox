# Named arguments that get recorded at each tick

#' @export
fly_record <- function(...) {
  zipline$api$record(...)
}
