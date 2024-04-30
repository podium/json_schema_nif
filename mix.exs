defmodule JsonSchemaNif.MixProject do
  use Mix.Project

  @project_url "https://github.com/podium/json_schema_nif"

  def project do
    [
      app: :json_schema_nif,
      name: "JSON Schema NIF",
      description: "A JSON Schema Validator via NIF bindings to Rust",
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      package: package()
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
      {:rustler, "~> 0.30.0", optional: true},
      {:rustler_precompiled, "~> 0.7"},

      # test
      {:mix_test_watch, "~> 1.1.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      "deps.get": ["deps.get", "deps.unlock --unused"]
    ]
  end
end
