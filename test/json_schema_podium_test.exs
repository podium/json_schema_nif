defmodule JsonSchemaNifTest do
  use ExUnit.Case, async: true

  doctest JsonSchemaNif

  describe "validate_json/2" do
    test "validates a matching JSON instance and schema" do
      instance = "{\"name\":\"John\"}"
      schema = "{\"type\":\"object\"}"
      assert {:ok, :matches_schema} = JsonSchemaNif.validate_json(instance, schema)
    end

    test "returns error for a non-matching JSON instance and schema" do
      instance = "{\"age\":30}"
      schema = "{\"type\":\"string\"}"

      assert {:error, :violates_schema} = JsonSchemaNif.validate_json(instance, schema)
    end

    test "returns error for invalid JSON instance" do
      instance = "not a json instance"
      schema = "{\"type\":\"object\"}"
      assert {:error, :bad_instance} = JsonSchemaNif.validate_json(instance, schema)
    end

    test "returns error for invalid JSON schema" do
      instance = "{\"name\":\"John\"}"
      schema = "not a json schema"
      assert {:error, :bad_schema} = JsonSchemaNif.validate_json(instance, schema)
    end
  end
end
