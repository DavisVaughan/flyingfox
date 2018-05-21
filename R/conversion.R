
# # With this enabled, we can't do auto conversion of zipline objects. (do we really want to?)
# # (this is fine! the user can do pyEquity$asset_name or whatever and that will auto convert)
# py_to_r.zipline.assets._assets.Equity <- function(x) {
#   x_dict <- x$to_dict()
#   x_list <- py_to_r(x_dict)
#
#   converted <- lapply(
#     X = x_list,
#     FUN = function(.x) {
#       if (inherits(.x, "python.builtin.object")) {
#         py_to_r(.x)
#       } else {
#         .x
#       }
#     }
#   )
#
#   converted <- lapply(converted, function(.x) {if(is.null(.x)) NA else .x})
#   tibble::as_tibble(converted)
# }

py_to_r_performance_tibble <- function(x) {

  df <- tibble::rownames_to_column(x, "date")
  x_tbl <- tibble::as_tibble(df)

  if("positions" %in% colnames(x_tbl)) {
    x_tbl$positions <- py_to_r_performance_column(x_tbl$positions)
  }

  if("orders" %in% colnames(x_tbl)) {
    x_tbl$orders <- py_to_r_performance_column(x_tbl$orders)
  }

  if("transactions" %in% colnames(x_tbl)) {
    x_tbl$transactions <- py_to_r_performance_column(x_tbl$transactions)
  }

  x_tbl
}

py_to_r_performance_column <- function(x) {

  lapply(x, function(all_x_on_day_j) {

    x_on_day_j_list <- lapply(all_x_on_day_j, function(x_i_on_day_j) {

      x_i_list <- lapply(x_i_on_day_j, function(x_ij_element) {

        if (inherits(x_ij_element, "python.builtin.object")) {
          py_to_r(x_ij_element)
        } else {
          x_ij_element
        }

      })

      if(length(x_i_list) > 0) {
        mixed_list_to_tibble(x_i_list)
      } else {
        tibble::tibble()
      }

    })

    if(length(x_on_day_j_list) > 0) {
      bind_rows_impl(x_on_day_j_list)
      #dplyr::bind_rows(x_on_day_j_list)
    } else {
      x_on_day_j_list
    }

  })
}


mixed_list_to_tibble <- function(.l) {

  .l_modified <- lapply(.l, function(.elem) {

    if(inherits(.elem, c("data.frame", "python.builtin.object"))) {

      list(.elem)

    } else if(inherits(.elem, "NULL")) {

      NA

    } else {

      .elem

    }

  })

  tibble::as_tibble(.l_modified)
}


bind_rows_impl <- function(row_list) {
  if(length(row_list) == 0) {
    return(NA)
  }

  if(length(row_list) == 1) {
    return(row_list[[1]])
  }

  .tbl <- row_list[[1]]
  row_list <- row_list[-1]

  for(row_tbl in row_list) {
    .tbl <- tibble::add_row(.tbl, !!! as.list(row_tbl))
  }

  .tbl
}
