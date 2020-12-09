# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :trade,
  ecto_repos: [Trade.Repo]

# Configures the endpoint
config :trade, TradeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oGBaZK8pg/5bcrSwyAsln/FBQkDUC0fYFKiJxLTieAAoQz/Pt73Lh0tL5WmArU9s",
  render_errors: [view: TradeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Trade.PubSub,
  live_view: [signing_salt: "uTtC5swt"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason



config :trade,Trade.Guardian ,
    issuer: "trade",
    secret_key: "vjzipYQfiuySdHzeycuQ836NRF01Io1tm3lh1EwCI4AFTlur33quvBMqJiEUEgaN"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
