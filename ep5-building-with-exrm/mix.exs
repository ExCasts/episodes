defmodule Test.Mixfile do
  use Mix.Project

  def project do
    [ app: :test,
      version: "0.0.2",
      elixir: "~> 1.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Test, [] },
     applications: [:logger]]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:timex, "~> 0.15"},
      {:exrm, "~> 0.19"}
    ]
  end
end
