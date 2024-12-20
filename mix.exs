defmodule ArgParse.MixProject do
  use Mix.Project

  @repo_url "https://github.com/paytonward6/argparse_ex"

  def project do
    [
      app: :argparse_ex,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      package: package(),
      description: description()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:spark, "~> 2.2.0"},
      {:igniter, "~> 0.5", only: [:dev, :test]},
      {:ex_doc, ">= 0.35.0", only: :dev},
    ]
  end

  defp description do
    "Elixir wrapper for Erlang's `:argparse` module"
  end

  defp package do
    [
      maintainers: ["Payton Ward"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @repo_url}
    ]
  end
end
