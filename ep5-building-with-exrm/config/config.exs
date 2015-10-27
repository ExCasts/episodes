use Mix.Config

config :test,
  env: :wat,
  "debug_level": {:on, [:passive]}

config :sasl,
  errlog_type: :error

#config :logger,
  #handle_sasl_reports: true

import_config "config.#{Mix.env}.exs"
