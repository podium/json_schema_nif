# JsonSchemaNif

Library for validating JSON instances against JSON schemas.

Provides a straightforward way to ensure that JSON data adheres to a predefined schema, enhancing the reliability and
consistency of data. Especially useful in contexts like Kafka.

## Installation

The package can be installed by adding `json_schema_nif` to your list of dependencies in `mix.exs`:

```elixir
defp deps do
  [
    {:json_schema_nif, "~> 0.1.0"}
  ]
end
```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md).

## Documentation

Documentation is available in [HexDocs](https://hexdocs.pm/json_schema_nif/readme.html).

## Releasing

Since we rely on RustlerPrecompiled actually building our Rust bindings in advance,
we need to follow their [recommended flow](https://hexdocs.pm/rustler_precompiled/precompilation_guide.html#recommended-flow):

1. Release a new tag
1. Push the code to your repository with the new tag: git push origin main --tags
1. Wait for all NIFs to be built
1. Run the `mix rustler_precompiled.download JsonSchemaNif --all`task (with the flag --all)
   release the package to Hex.pm (make sure your release includes the correct files).
   - Run `mix hex.build --unpack` to ensure checksum files exist
