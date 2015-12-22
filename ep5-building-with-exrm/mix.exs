defmodule Test.Mixfile do
  use Mix.Project

  def project do
    [ app: :test,
      version: "0.0.3",
      elixir: "~> 1.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Test, [] },
     applications: [:logger]]
  end

  defp deps do
    [
      {:timex, "~> 0.15"},
      {:exrm, "~> 0.19"}
    ]
  end
end
