defmodule JsonSchemaNif.MixProject do
  use Mix.Project

  @version "0.1.1"
  @project_url "https://github.com/podium/json_schema_nif"

  def project do
    [
      app: :json_schema_nif,
      name: "JSON Schema NIF",
      description: "A JSON Schema Validator via NIF bindings to Rust",
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      package: package(),
      test_coverage: [summary: [threshold: 33.33]],
      dialyzer: [
        plt_add_apps: [:mix],
        ignore_warnings: ".dialyzer.ignore-warnings"
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Podium"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @project_url,
        "Changelog" => "#{@project_url}/blob/master/CHANGELOG.md"
      },
      files: [
        "lib",
        "native/json_schema_nif/.cargo",
        "native/json_schema_nif/src",
        "native/json_schema_nif/Cargo*",
        "checksum-*.exs",
        "mix.exs",
        "README.md",
        "CHANGELOG.md"
      ]
    ]
  end

  defp deps do
    [
      {:rustler, "~> 0.36.0", optional: true},
      {:rustler_precompiled, "~> 0.7"},

      # test
      {:mix_test_watch, "~> 1.2.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      "deps.get": ["deps.get", "deps.unlock --unused"]
    ]
  end
end
