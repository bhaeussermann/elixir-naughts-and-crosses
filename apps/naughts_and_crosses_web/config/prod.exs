import Config

config :naughts_and_crosses_web, NaughtsAndCrossesWeb.Endpoint,
url: [host: System.get_env("RENDER_EXTERNAL_HOSTNAME") || "localhost", port: 80],
cache_static_manifest: "priv/static/cache_manifest.json"
