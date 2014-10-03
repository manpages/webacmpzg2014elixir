defmodule WebCamp.Mixfile do
  use Mix.Project

  def project do
    [app: :webacmpzg2014elixir,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :gproc],
     mod: {WebCamp, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [ {:cowboy, "~> 1.0.0"},
      {:plug,   "~> 0.8.0"},
      {:gproc,   git: "https://github.com/uwiger/gproc", branch: "master"},
    ]
  end
end
