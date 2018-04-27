
<!-- README.md is generated from README.Rmd. Please edit that file -->

![lifecycle](https://img.shields.io/badge/lifecycle-hacked%20together-brightgreen.svg)

# flyingfox

The goal of `flyingfox` is to connect Quantopian’s `zipline` financial
backtesting package with R.

## Installation

You can install the released version of flyingfox from
[CRAN](https://CRAN.R-project.org) with:

``` r
# HA. Nice try.
install.packages("flyingfox")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DavisVaughan/flyingfox")
```

## Example

`zipline` backtests are run using a combination of two main functions.
`initialize()` sets up variables you might need during the backtest
along with giving you a chance to schedule functions to run
periodically. `handle_data()` is called at a daily/minutely frequency
and runs your algorithm, orders assets, and records data for future
inspection.

This runs on a custom version of `reticulate`. In the near future it
will be in the dev version of `reticulate`.

``` r
library(reticulate)
library(flyingfox)

# After setting up a Quandl data ingest and
# getting zipline installed on your computer...
```

First, set up an initialize function. It must take `context` as the
argument.

``` r
fly_initialize <- function(context) {

  # We want to track what day we are on. The mean reversion algo we use
  # should have at least 300 days of data before doing anything
  context$i = 0L

  # We want to trade apple stock
  context$asset = fly_symbol("AAPL")
}
```

Next, create a handle\_data function that accepts `context` and `data`.
This implements a moving average crossover algorithm.

``` r
fly_handle_data <- function(context, data) {

  # Increment day
  new_i <- py_to_r(context$i) + 1L
  context$i <- r_to_py(new_i)

  # While < 300 days, return
  if(context$i < 300L) {
    return()
  }

  # Calculate a short term (100 day) moving average
  # by pulling history for the asset (apple) and taking an average
  short_hist <- py_to_r(fly_history(data, context$asset, "price", bar_count = 100L, frequency = "1d"))
  short_mavg <- mean(short_hist)

  # Calculate a long term (300 day) moving average
  long_hist <- py_to_r(fly_history(data, context$asset, "price", bar_count = 300L, frequency = "1d"))
  long_mavg <- mean(long_hist)

  # If short > long, go 100% in apple
  if(short_mavg > long_mavg) {
    fly_order_target(context$asset, 100L)
  }
  # Else if we hit the crossover, dump all of apple
  else if (short_mavg < long_mavg) {
    fly_order_target(context$asset, 0L)
  }

  # Record today's data
  # We record the current apple price, along with the value of the short and long
  # term moving average
  fly_record(AAPL = data$current(context$asset, "price"),
            short_mavg = short_mavg,
            long_mavg = long_mavg)

}
```

Run the algo over a certain time period.

``` r
performance <- fly_run_algorithm(
  fly_initialize,
  fly_handle_data,
  as.Date("2013-01-01"),
  as.Date("2016-01-01")
)

tail(performance)
#> # A tibble: 6 x 41
#>   date      AAPL algo_volatility algorithm_period… alpha benchmark_period…
#>   <chr>    <dbl>           <dbl>             <dbl> <dbl>             <dbl>
#> 1 2015-12…  109.           0.339              1.53 0.217              1.35
#> 2 2015-12…  108.           0.339              1.53 0.217              1.34
#> 3 2015-12…  107.           0.339              1.53 0.218              1.34
#> 4 2015-12…  109.           0.339              1.53 0.216              1.36
#> 5 2015-12…  107.           0.338              1.53 0.217              1.35
#> 6 2015-12…  105.           0.338              1.53 0.218              1.32
#> # ... with 35 more variables: benchmark_volatility <dbl>, beta <dbl>,
#> #   capital_used <dbl>, ending_cash <dbl>, ending_exposure <dbl>,
#> #   ending_value <dbl>, excess_return <dbl>, gross_leverage <dbl>,
#> #   long_exposure <dbl>, long_mavg <dbl>, long_value <dbl>,
#> #   longs_count <dbl>, max_drawdown <dbl>, max_leverage <dbl>,
#> #   net_leverage <dbl>, orders <list>, period_close <dttm>,
#> #   period_label <chr>, period_open <dttm>, pnl <dbl>,
#> #   portfolio_value <dbl>, positions <list>, returns <dbl>, sharpe <dbl>,
#> #   short_exposure <dbl>, short_mavg <dbl>, short_value <dbl>,
#> #   shorts_count <dbl>, sortino <dbl>, starting_cash <dbl>,
#> #   starting_exposure <dbl>, starting_value <dbl>, trading_days <dbl>,
#> #   transactions <list>, treasury_period_return <dbl>
```
