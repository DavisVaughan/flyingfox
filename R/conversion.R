py_to_r.zipline.assets._assets.Equity <- function(x) {
  x_dict <- x$to_dict()

  converted <- lapply(
    X = x_dict,
    FUN = function(.x) {
      if (inherits(.x, "python.builtin.object")) {
        py_to_r(.x)
      } else {
        .x
      }
    }
  )

  converted <- lapply(converted, function(.x) {if(is.null(.x)) NA else .x})
  tibble::as_tibble(converted)
}

py_to_r_performance_tibble <- function(x) {
  df <- reticulate::py_to_r(x)
  df <- tibble::rownames_to_column(df, "date")
  x_tbl <- tibble::as_tibble(df)

  if("positions" %in% colnames(x_tbl)) {
    x_tbl$positions <- py_to_r_positions(x_tbl$positions)
  }

  if("orders" %in% colnames(x_tbl)) {
    x_tbl$orders <- py_to_r_positions(x_tbl$orders)
  }

  if("transactions" %in% colnames(x_tbl)) {
    x_tbl$transactions <- py_to_r_positions(x_tbl$transactions)
  }

  x_tbl
}

py_to_r_positions <- function(positions) {

  lapply(positions, function(positions_on_day) {

    positions_on_day_list <- lapply(positions_on_day, function(position) {

      position_list <- lapply(position, function(element) {

        if (inherits(element, "python.builtin.object")) {
          py_to_r(element)
        } else {
          element
        }

      })

      if(length(position_list) > 0) {
        mixed_list_to_tibble(position_list)
      } else {
        tibble::tibble()
      }

    })

    if(length(positions_on_day_list) > 0) {
      dplyr::bind_rows(positions_on_day_list)
    } else {
      positions_on_day_list
    }

  })
}


mixed_list_to_tibble <- function(x) {
  x_modified <- lapply(x, function(.x) {
    if(inherits(.x, "data.frame")) {
      list(.x)
    } else if(inherits(.x, "NULL")) {
      NA
    } else {
      .x
    }
  })

  tibble::as_tibble(x_modified)
}
