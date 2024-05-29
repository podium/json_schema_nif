# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic
Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.1] 2024-05-28

Fix bug where `version` key needed to be set as module attribute `@version`
for `sed` to find it.

## [0.1.0] - 2024-05-15

Initial release.

### Added

- `JsonSchemaNif.validate_json/2` to validate a JSON instance against a provided JSON schema.
