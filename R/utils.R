as_integer <- function(x) {
  if(is.numeric(x)) {
    as.integer(x)
  } else {
    x
  }
}

interface_is_available <- function() {
  tryCatch({
    main$interface_is_available
  },
  error = function(e) {
    FALSE
  })
}

ensure_r_is_exported <- function() {
  is_exported <- tryCatch(
    expr  = { main$r; TRUE },
    error = function(e) { FALSE}
  )

  if(!is_exported) {
    export_r()
  }
}

# ------------------------------------------------------------------------------
# Hack to push r to the python side

# yoink <- function(package, symbol) {
#   do.call(":::", list(package, symbol))
# }

as_r_value <- function (x) {
  if (inherits(x, "python.builtin.object"))
    reticulate::py_to_r(x)
  else x
}

export_r <- function(envir = getOption("reticulate.engine.environment")) {
  reticulate::py_run_string("class R(object): pass")
  main <- reticulate::import_main(convert = FALSE)
  R <- main$R
  if (is.null(envir)) {
    envir <- globalenv()
  }
  getter <- function(self, code) {
    reticulate::r_to_py(eval(parse(text = as_r_value(code)), envir = envir))
  }
  setter <- function(self, name, value) {
    envir[[as_r_value(name)]] <<- as_r_value(value)
  }
  reticulate::py_set_attr(R, "__getattr__", getter)
  reticulate::py_set_attr(R, "__setattr__", setter)
  reticulate::py_set_attr(R, "__getitem__", getter)
  reticulate::py_set_attr(R, "__setitem__", setter)
  reticulate::py_run_string("r = R()")
}
