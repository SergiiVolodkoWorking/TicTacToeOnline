defmodule Tictactoe.MixProject do
  use Mix.Project

  @test_envs [:test, :integration]

  def project do
    [
      app: :tictactoe,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_paths: test_paths(Mix.env()),
      aliases: ["test.all": ["test.unit", "test.integration"],
                "test.unit": &run_unit_tests/1,
                "test.integration": &run_integration_tests/1]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Tictactoe.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(env)when env in @test_envs, do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp test_paths(:integration), do: ["test/support", "test/integration"]
  defp test_paths(_), do: ["test/support", "test/unit"]

  def run_integration_tests(args), do: test_with_env("integration", args)
  def run_unit_tests(args), do: test_with_env("test", args)

  def test_with_env(env, args) do
    args = if IO.ANSI.enabled?, do: ["--color"|args], else: ["--no-color"|args]
    IO.puts "==> Running tests with `MIX_ENV=#{env}`"
    {_, res} = System.cmd "mix", ["test"|args],
      into: IO.binstream(:stdio, :line),
      env: [{"MIX_ENV", to_string(env)}]

    if res > 0 do
      System.at_exit(fn _ -> exit({:shutdown, 1}) end)
    end
  end


  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:faker, "~> 0.12", only: @test_envs },
      {:blacksmith, "~> 0.1", only: @test_envs },
      {:mockery, "~> 2.3.0", runtime: false},
      {:mox, "~> 0.3", only: @test_envs }
    ]
  end
end
