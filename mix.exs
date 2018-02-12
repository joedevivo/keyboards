defmodule Keyboards.MixProject do
  use Mix.Project

  def project do
    [
      app: :keyboards,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :open_scad]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:open_scad, path: "../open_scad"}
    ]
  end
end
