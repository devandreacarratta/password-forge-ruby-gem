# Structure

## Directory layout

```
password_forge/
├── lib/
│   ├── password_forge.rb            # Entry point: requires all components
│   └── password_forge/
│       ├── version.rb               # VERSION constant
│       ├── errors.rb                # Error, NoCharsetSelectedError
│       ├── charset.rb               # Charset value object (character sets + build)
│       ├── validation.rb            # Validation module (selection + length)
│       └── generator.rb             # Generator class + PasswordForge.generate
├── spec/
│   ├── spec_helper.rb
│   ├── password_forge_spec.rb       # Top-level (version) spec
│   └── password_forge/
│       ├── charset_spec.rb
│       ├── validation_spec.rb
│       └── generator_spec.rb
├── sig/                             # RBS type signatures
├── .github/workflows/
│   ├── main.yml                     # CI: RSpec matrix + RuboCop
│   └── release.yml                  # Trusted Publishing on v* tags
├── .kiro/                           # Kiro steering / skills / hooks
├── private-notes/                   # Local-only, git-ignored (dev diary)
├── password_forge.gemspec
├── Gemfile
├── Rakefile
├── README.md
├── CHANGELOG.md
└── LICENSE.txt
```

## Architecture

The internal design mirrors the original C# separation of concerns while
staying idiomatic Ruby:

- **`PasswordForge::Charset`** — a module acting as a value object. Holds the
  frozen `UPPER`, `LOWER`, `NUMERIC` and `SPECIAL` constants and a `build`
  method that returns the pool of characters for the selected sets.
- **`PasswordForge::Validation`** — a module with `validate_charset_selection`
  (raises when no set is selected) and `validate_length` (positive integer).
- **`PasswordForge::NoCharsetSelectedError`** — the equivalent of the C#
  `InvalidCharSetException`; subclass of `PasswordForge::Error`.
- **`PasswordForge::Generator`** — the public class. The constructor validates
  input and builds the pool; `#generate` returns a `SecureRandom`-backed
  password.
- **`PasswordForge.generate(**options)`** — a top-level convenience wrapper.

## Public API conventions

- The `Generator` constructor uses keyword arguments:
  `upper_case:`, `lower_case:`, `numeric_case:`, `special_case:` (all `true`),
  and `length:` (default 16). This matches the C# constructor parameter names.
- A fluent/builder API is planned for v0.6.0 and must be **additive**: the
  keyword-argument API keeps working unchanged.

## Naming

- **Gem name:** `password_forge` (underscore) — what users `gem install`.
- **GitHub repo:** `password-forge-ruby-gem` (hyphens) — more descriptive for
  discovery. The two intentionally differ.
- Namespace all code under the `PasswordForge` module; one file per component
  under `lib/password_forge/`.
