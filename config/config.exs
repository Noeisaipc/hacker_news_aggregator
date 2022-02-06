# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :hacker_news_web, HackerNewsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aNKNLzasPXS3lEylYDOmt54i0XnNU4Jh37AU67UzyENPqXg48TMPXNaIWfL3b7Ww",
  render_errors: [view: HackerNewsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HackerNewsWeb.PubSub,
  live_view: [signing_salt: "WGoVT3AK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
import_config "#{Mix.env()}.exs"
