defmodule NaughtsAndCrossesWeb.Mixfile do
  use Mix.Project

  def project do
    [
      app: :naughts_and_crosses_web,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {NaughtsAndCrossesWeb.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6"},
      {:phoenix_live_view, "~> 0.16.4"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_html, "~> 3.0"},
      {:gettext, "~> 0.11"},
      {:naughts_and_crosses, in_umbrella: true},
      {:plug_cowboy, "~> 2.1"},
      {:jason, "~> 1.0"},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    []
  end
end
