import Config

config :naughts_and_crosses_web, NaughtsAndCrossesWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  secret_key_base: "/hE/A2yqdaQLn0TRDay8iPqz7byA8398qLY5rg7RQFzR/ibbktUBzhcDr6ucfKp/",
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]
