import os
from zipline import run_algorithm

interface_is_available = True


# def initialize(context):
#     r.fly_initialize(context)
#     return
#
# def handle_data(context, data):
#     r.fly_handle_data(context, data)
#     return

def py_run(fly_initialize, fly_handle_data, start, end, capital_base, bundle):

    def initialize(context):
      fly_initialize(context)
      return

    def handle_data(context, data):
      fly_handle_data(context, data)
      return

    performance = run_algorithm(
      start = start,
      end = end,
      initialize = initialize, # found because in the global main() from R
      capital_base = capital_base,
      handle_data = handle_data, # found because in the global main() from R
      environ = os.environ,
      bundle = bundle
    )

    return performance


