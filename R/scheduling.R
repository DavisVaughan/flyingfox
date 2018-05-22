#' Schedule a function to be called according to some timed rules
#'
#' `fly_schedule_function()` allows you to schedule an R function to run at
#' timed iterations. Helpers are defined to declare the frequency at which
#' to execute the function.
#'
#' @param func The function to execute at timed intervals. Must take `context` and `data` as its first
#' and second arguments.
#' @param date_rule One of: `every_day()`, `month_end()`, `month_start()`, `week_start()`, or `week_end()`.
#' If `NULL`, the default is `every_day()`.
#' @param time_rule One of: `every_minute()`, `market_close()`, or `market_open()`.
#' If `NULL`, the default is `every_minute()`.
#' @param half_days A boolean. Should this rule fire on half days?
#' @param calendar Calendar used to reconcile date and time rules.
#'
#' @name scheduling
#'
#' @section Zipline Documentation:
#'
#' - [`fly_schedule_function()`](https://www.zipline.io/appendix.html#zipline.api.schedule_function)
#' - [Date Rules](https://www.zipline.io/appendix.html#zipline.api.date_rules)
#' - [Time Rules](https://www.zipline.io/appendix.html#zipline.api.time_rules)
#'
#' @examples
#'
#' # Just print i at each iteration
#' scheduled_fn <- function(context, data) {
#'   print(context$i)
#' }
#'
#' fly_initialize <- function(context) {
#'
#'   # Init to 0
#'   context$i = 0L
#'
#'   # No extra timing arguments means "Always" (every day / every minute)
#'   fly_schedule_function(scheduled_fn)
#' }
#'
#' fly_handle_data <- function(context, data) {
#'
#'   # Increment day
#'   context$i <- context$i + 1L
#' }
#'
#' # You should see the context$i variable printed at each day
#' performance <- fly_run_algorithm(
#'   fly_initialize,
#'   fly_handle_data,
#'   start = as.Date("2015-01-01"),
#'   end   = as.Date("2016-01-01")
#' )
#'
#' @export
fly_schedule_function <- function(func, date_rule = NULL, time_rule = NULL,
                                  half_days = TRUE, calendar = NULL) {
  zipline$api$schedule_function(
    func = func,
    date_rule = date_rule,
    time_rule = time_rule,
    half_days = half_days,
    calendar = calendar
  )
}

# ------------------------------------------------------------------------------
# Date Rules

#' @rdname scheduling
#' @export
every_day <- function() {
  zipline$api$date_rules$every_day()
}

#' @rdname scheduling
#' @export
month_end <- function(days_offset = 0L) {
  days_offset <- as_integer(days_offset)
  zipline$api$date_rules$month_end(days_offset)
}

#' @rdname scheduling
#' @export
month_start <- function(days_offset = 0L) {
  days_offset <- as_integer(days_offset)
  zipline$api$date_rules$month_start(days_offset)
}

#' @rdname scheduling
#' @export
week_end <- function(days_offset = 0L) {
  days_offset <- as_integer(days_offset)
  zipline$api$date_rules$week_end(days_offset)
}

#' @rdname scheduling
#' @export
week_start <- function(days_offset = 0L) {
  days_offset <- as_integer(days_offset)
  zipline$api$date_rules$week_start(days_offset)
}

# ------------------------------------------------------------------------------
# Time Rules

#' @rdname scheduling
#' @export
every_minute <- function() {
  zipline$api$time_rules$every_minute()
}

#' @rdname scheduling
#' @export
market_close <- function() {
  zipline$api$time_rules$market_close()
}

#' @rdname scheduling
#' @export
market_open <- function() {
  zipline$api$time_rules$market_open()
}
