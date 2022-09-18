import Config

config :naughts_and_crosses_web, NaughtsAndCrossesWeb.Endpoint,
  load_from_system_env: true,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "elixir-naughts-and-crosses.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json"

import_config "prod.secret.exs"
