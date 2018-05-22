import os
from zipline import run_algorithm

interface_is_available = True

def py_run(fly_initialize,
           fly_handle_data,
           start,
           end,
           capital_base,
           before_trading_start,
           analyze,
           data_frequency,
           data,
           bundle,
           bundle_timestamp,
           trading_calendar,
           metrics_set,
           default_extension,
           #extensions,
           strict_extensions #,
           #environ
           ):

    def initialize(context):
      fly_initialize(context)
      return

    def handle_data(context, data):
      fly_handle_data(context, data)
      return

    performance = run_algorithm(
      initialize = initialize,
      handle_data = handle_data,
      start = start,
      end = end,
      capital_base = capital_base,
      before_trading_start = before_trading_start,
      analyze = analyze,
      data_frequency = data_frequency,
      data = data,
      bundle = bundle,
      bundle_timestamp = bundle_timestamp,
      trading_calendar = trading_calendar,
      metrics_set = metrics_set,
      default_extension = default_extension,
      #extensions,
      strict_extensions = strict_extensions,
      environ = os.environ
    )

    return performance


