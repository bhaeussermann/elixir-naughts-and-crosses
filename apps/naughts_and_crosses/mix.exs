defmodule NaughtsAndCrosses.MixProject do
  use Mix.Project

  def project do
    [
      app: :naughts_and_crosses,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      escript: escript(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
  
  def escript do
    [main_module: NaughtsAndCrosses]
  end
  
  defp deps do
    []
  end
end
