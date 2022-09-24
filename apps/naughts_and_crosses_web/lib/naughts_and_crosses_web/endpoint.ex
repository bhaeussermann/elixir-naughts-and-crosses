defmodule NaughtsAndCrossesWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :naughts_and_crosses_web

  socket "/socket", NaughtsAndCrossesWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :naughts_and_crosses_web, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_naughts_and_crosses_web_key",
    signing_salt: "s49dncH/",
    extra: "SameSite=Lax"

  plug NaughtsAndCrossesWeb.Router
end
