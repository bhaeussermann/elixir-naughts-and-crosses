defmodule NaughtsAndCrossesWeb.Application do
  use Application

  def start(_type, _args) do
    children = [
      %{
        id: NaughtsAndCrossesWeb.Endpoint,
        start: {NaughtsAndCrossesWeb.Endpoint, :start_link, []}
      }
    ]

    opts = [strategy: :one_for_one, name: NaughtsAndCrossesWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NaughtsAndCrossesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
