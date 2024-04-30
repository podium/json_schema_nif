defmodule JsonSchemaNif do
  @moduledoc """
  Provides functionality for validating JSON instances against JSON schemas.

  This Elixir module interfaces with Rust-implemented functions via Rustler,
  leveraging Rust's performance for efficient JSON validation.
  """

  # version = Mix.Project.config()[:version]

  use Rustler, otp_app: :json_schema_nif, crate: "json_schema_nif"

  @doc """
  Validates a JSON instance against a JSON schema.

  This function is a wrapper for the Rust-implemented NIF (Native Implemented Function).

  ## Parameters

    - `instance`: The JSON instance to be validated.
    - `schema`: The JSON schema against which the instance is validated.

  ## Returns

  Returns `{:ok, :matches_schema}` if the JSON instance matches the schema, `{:error, :violates_schema}` if it violates
  the schema, or an appropriate error tuple for other failure modes.

  ## Examples

      iex> JsonSchemaNif.validate_json("{\\"name\\":\\"John\\"}", "{\\"type\\":\\"object\\"}")
      {:ok, :matches_schema}

      iex> JsonSchemaNif.validate_json("{\\"age\\":30}", "{\\"type\\":\\"string\\"}")
      {:error, :violates_schema}

  ## Note

  This function will raise an error if the NIF is not loaded, which typically indicates
  a compilation or deployment issue with the Rust code.
  """
  @spec validate_json(binary, binary) :: {:ok, :matches_schema} | {:error, atom()}
  def validate_json(instance, schema) when is_binary(instance) and is_binary(schema),
    do: nif_not_loaded()

  defp nif_not_loaded, do: :erlang.nif_error(:nif_not_loaded)
end
