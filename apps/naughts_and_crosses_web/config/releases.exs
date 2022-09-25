import Config

config :naughts_and_crosses_web, NaughtsAndCrossesWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base,
  server: true
