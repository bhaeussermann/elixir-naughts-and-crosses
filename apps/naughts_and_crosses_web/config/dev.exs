import Config

config :naughts_and_crosses_web, NaughtsAndCrossesWeb.Endpoint,
  http: [
    port: 4000
  ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]
