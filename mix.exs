defmodule AdventOfCode.MixProject do
  use Mix.Project

  @spec application() :: keyword
  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  @spec project() :: keyword
  def project do
    [
      app: :advent_of_code,
      version: "1.0.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  ################################################################################
  # Private
  ################################################################################

  @spec deps() :: list(tuple)
  defp deps() do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false}
    ]
  end
end
