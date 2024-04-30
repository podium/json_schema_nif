//! This module provides functionality for validating JSON instances against JSON schemas.
//! It is designed to be integrated into an Elixir project through Rustler, allowing
//! Elixir code to leverage Rust's performance for JSON validation tasks.

#[macro_use]
extern crate log;

use jsonschema::is_valid;
use rustler::Atom;
use serde_json::Value;

mod atoms {
    rustler::atoms! {
        bad_instance,
        bad_schema,
        matches_schema,
        violates_schema
    }
}

/// Validates a JSON instance against a JSON schema.
///
/// # Arguments
/// * `instance` - A string representation of the JSON instance to be validated.
/// * `schema` - A string representation of the JSON schema against which the instance is validated.
///
/// # Returns
/// * `Ok(atoms::matches_schema())` if the instance matches the schema.
/// * `Err(atoms::violates_schema())` if the instance does not match the schema.
/// * `Err(atoms::bad_instance())` if the instance string cannot be parsed as JSON.
/// * `Err(atoms::bad_schema())` if the schema string cannot be parsed as JSON.
#[rustler::nif]
fn validate_json(instance: String, schema: String) -> Result<Atom, Atom> {
    let instance_value = match serde_json::from_str::<Value>(&instance) {
        Ok(val) => val,
        Err(err) => {
            error!("Failed to parse JSON: {:?}", err);
            return Err(atoms::bad_instance());
        }
    };

    let schema_value = match serde_json::from_str::<Value>(&schema) {
        Ok(val) => val,
        Err(err) => {
            error!("Failed to parse schema: {:?}", err);
            return Err(atoms::bad_schema());
        }
    };

    if is_valid(&schema_value, &instance_value) {
        return Ok(atoms::matches_schema());
    } else {
        debug!(
            "JSON instance does not match schema:\nInstance: {:?}\nSchema: {:?}",
            &instance_value, &schema_value
        );
        return Err(atoms::violates_schema());
    }
}

rustler::init!("Elixir.JsonSchemaNif", [validate_json]);
