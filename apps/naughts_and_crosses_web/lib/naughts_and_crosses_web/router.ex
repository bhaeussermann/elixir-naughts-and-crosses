defmodule NaughtsAndCrossesWeb.Router do
  use NaughtsAndCrossesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NaughtsAndCrossesWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/place", PageController, :place
  end
end
