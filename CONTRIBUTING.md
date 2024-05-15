# Contributing

This library is kept intentionally simple.

That said, contributions (especially bug fixes!) are welcome. To contribute:

- Propose the changes as a GitHub Issue
- If feedback is supportive, create a new branch for your feature or bug fix
- Implement your changes
- Write tests for your changes
- Document your changes
- Ensure all tests pass
- Submit a merge request

# Building the Project

Build dependencies:

1. Elixir toolchain (default to asdf installation)
1. Rust toolchain

To force a compilation of the Rust portions locally, instead of relying
on pre-built artifacts, set `RUSTLER_PRECOMPILATION_FORCE_BUILD=true`.

```bash
cd native/json_schema_nif/
# If you need extra toolchains
rustup target add x86_64-apple-darwin
rustup target add aarch64-apple-darwin
rustup target add aarch64-unknown-linux-gnu

cargo build --target aarch64-unknown-linux-gnu --release
cargo build --target aarch64-apple-darwin --release
cargo build --target x86_64-apple-darwin --release
```

To generate the checksum file **after** the NIF files have been uploaded to GitHub,
run: `mix rustler_precompiled.download JsonSchemaNif --only-local`.

These files are required as part of the Hex package, but don't need to be tracked in VCS.
