defmodule TelegramBot.Mixfile do
  use Mix.Project

  def project do
    [app: :telegram_bot,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {TelegramBot, []},
     applications: [:goth, :ffmpex, :nadia, :phoenix, :cowboy, :logger]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"},
     {:ffmpex, "~> 0.3.0"},
     {:temp, "~> 0.4.1"},
     {:goth, "~> 0.2.1"},
     {:dogma, "~> 0.1.9", only: [:dev, :test]},
     {:credo, "~> 0.4.12", only: [:dev, :test]},
     {:nadia, github: "zhyu/nadia"}]
  end
end
