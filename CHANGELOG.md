# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.2] - 2026-09-05

### Added

- `examples/` folder with runnable local demos: `smoke_test.rb` (loads the gem
  from source and prints sample passwords) and `local-consumer/` (a minimal
  external project that depends on the gem via a `path:` reference).
- `docs/` folder with a documentation index (`docs/README.md`) and a
  local-testing guide (`docs/local-testing.md`).
- "Trying it locally" section in the README linking to the examples and docs.

### Changed

- Excluded `examples/` and `docs/` from the packaged gem.

### Fixed

- Corrected the directory tree and command paths in the Kiro steering docs
  (`structure.md`, `tech.md`), which still referenced a nested `password_forge/`
  root left over from an older project layout.

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

[Unreleased]: https://github.com/devandreacarratta/password-forge-ruby-gem/compare/v0.0.2...HEAD
[0.0.2]: https://github.com/devandreacarratta/password-forge-ruby-gem/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/devandreacarratta/password-forge-ruby-gem/releases/tag/v0.0.1
