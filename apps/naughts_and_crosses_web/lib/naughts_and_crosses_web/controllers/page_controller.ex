defmodule NaughtsAndCrossesWeb.PageController do
  use NaughtsAndCrossesWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
