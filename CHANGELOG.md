# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.1] - 2026-09-05

### Added

- `PasswordForge::Generator` with keyword-argument constructor
  (`upper_case:`, `lower_case:`, `numeric_case:`, `special_case:`, `length:`)
  and a `SecureRandom`-backed `#generate`.
- `PasswordForge::Charset` value object exposing the `UPPER`, `LOWER`,
  `NUMERIC` and `SPECIAL` character sets and a `build` method.
- `PasswordForge::Validation` for charset selection and length checks.
- `PasswordForge::NoCharsetSelectedError`, raised when no character set is
  selected.
- `PasswordForge.generate` convenience wrapper.
- RSpec test suite, RuboCop configuration and README.

[Unreleased]: https://github.com/devandreacarratta/password-forge-ruby-gem/compare/v0.0.1...HEAD
[0.0.1]: https://github.com/devandreacarratta/password-forge-ruby-gem/releases/tag/v0.0.1
