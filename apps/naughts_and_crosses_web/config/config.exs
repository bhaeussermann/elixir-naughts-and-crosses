import Config

# General application configuration
config :naughts_and_crosses_web,
  namespace: NaughtsAndCrossesWeb

# Configures esbuild
config :esbuild, :version, "0.14.41"

# Configures Phoenix
config :phoenix, :json_library, Jason

# Configures the endpoint
config :naughts_and_crosses_web, NaughtsAndCrossesWeb.Endpoint,
  server: true,
  url: [host: "localhost"],
  render_errors: [view: NaughtsAndCrossesWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: NaughtsAndCrossesWeb.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :naughts_and_crosses_web, :generators,
  context_app: :naughts_and_crosses

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
