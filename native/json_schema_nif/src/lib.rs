//! This module provides functionality for validating JSON instances against JSON schemas.
//! It is designed to be integrated into an Elixir project through Rustler, allowing
//! Elixir code to leverage Rust's performance for JSON validation tasks.

#[macro_use]
extern crate log;

use jsonschema::is_valid;
use serde_json::Value;

mod atoms {
    rustler::atoms! {
        bad_instance,
        bad_schema,
        violates_schema
    }
}

enum ValidationResult {
    Ok,
    BadInstance,
    BadSchema,
    ViolatesSchema,
}

impl rustler::Encoder for ValidationResult {
    fn encode<'a>(&self, env: rustler::Env<'a>) -> rustler::Term<'a> {
        match self {
            ValidationResult::Ok => rustler::types::atom::ok().encode(env),
            ValidationResult::BadInstance => rustler::types::tuple::make_tuple(
                env,
                &[
                    rustler::types::atom::error().encode(env),
                    atoms::bad_instance().encode(env),
                ],
            ),
            ValidationResult::BadSchema => rustler::types::tuple::make_tuple(
                env,
                &[
                    rustler::types::atom::error().encode(env),
                    atoms::bad_schema().encode(env),
                ],
            ),
            ValidationResult::ViolatesSchema => rustler::types::tuple::make_tuple(
                env,
                &[
                    rustler::types::atom::error().encode(env),
                    atoms::violates_schema().encode(env),
                ],
            ),
        }
    }
}

/// Validates a JSON instance against a JSON schema.
///
/// # Arguments
/// * `instance` - A string representation of the JSON instance to be validated.
/// * `schema` - A string representation of the JSON schema against which the instance is validated.
///
/// # Returns
/// * `ValidationResult::Ok` if the instance matches the schema.
/// * `ValidationResult::ViolatesSchema` if the instance does not match the schema.
/// * `ValidationResult::BadInstance` if the instance string cannot be parsed as JSON.
/// * `ValidationResult::BadSchema` if the schema string cannot be parsed as JSON.
#[rustler::nif]
fn validate_json(instance: String, schema: String) -> ValidationResult {
    let instance_value = match serde_json::from_str::<Value>(&instance) {
        Ok(val) => val,
        Err(err) => {
            error!("Failed to parse JSON: {:?}", err);
            return ValidationResult::BadInstance;
        }
    };

    let schema_value = match serde_json::from_str::<Value>(&schema) {
        Ok(val) => val,
        Err(err) => {
            error!("Failed to parse schema: {:?}", err);
            return ValidationResult::BadSchema;
        }
    };

    if is_valid(&schema_value, &instance_value) {
        ValidationResult::Ok
    } else {
        debug!(
            "JSON instance does not match schema:\nInstance: {:?}\nSchema: {:?}",
            &instance_value, &schema_value
        );
        ValidationResult::ViolatesSchema
    }
}

rustler::init!("Elixir.JsonSchemaNif", [validate_json]);
