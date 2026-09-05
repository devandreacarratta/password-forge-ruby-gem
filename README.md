# PasswordForge

[![Ruby](https://github.com/devandreacarratta/password-forge-ruby-gem/actions/workflows/main.yml/badge.svg)](https://github.com/devandreacarratta/password-forge-ruby-gem/actions/workflows/main.yml)

A configurable password generator for Ruby with selectable character sets.

`PasswordForge` builds passwords from four character categories — uppercase,
lowercase, numeric and special — that you switch on or off independently. All
categories are enabled by default, and a clear error is raised if you disable
every one of them. Randomness is provided by Ruby's `SecureRandom`.

This gem is also a showcase for building and shipping a Ruby gem the **Kiro
way**. Kiro skills, project steering, hooks and an MCP server are being added
incrementally (see the [Roadmap](#roadmap)).

## Installation

> **Not on RubyGems yet.** The first public release is planned for 0.1.0 (see
> the [Roadmap](#roadmap)). Until then, see [Trying it
> locally](#trying-it-locally) to run the gem from source or via a local path
> dependency.

Once published, install the gem and add it to the application's Gemfile by
executing:

```bash
bundle add password_forge
```

If Bundler is not being used to manage dependencies, install the gem by
executing:

```bash
gem install password_forge
```

## Usage

### Quick start

```ruby
require "password_forge"

# All character sets enabled, default length of 16
PasswordForge.generate
# => "aB3$xY7!qR2@kL9%"
```

### Using the generator directly

The constructor takes four boolean flags (all `true` by default) plus a
`length`. This mirrors the design of the original C# / NuGet package:

```ruby
generator = PasswordForge::Generator.new(
  upper_case:   true,  # include A-Z
  lower_case:   true,  # include a-z
  numeric_case: true,  # include 0-9
  special_case: true,  # include special characters
  length:       16
)

generator.generate # => "aB3$xY7!qR2@kL9%"
```

### Examples

```ruby
# A 20-character password using every character set
PasswordForge::Generator.new(length: 20).generate

# A 4-digit numeric PIN
PasswordForge::Generator.new(
  upper_case: false, lower_case: false, numeric_case: true, special_case: false, length: 4
).generate
# => "8391"

# Letters only (no digits, no symbols)
PasswordForge::Generator.new(
  numeric_case: false, special_case: false, length: 24
).generate
```

### Error handling

Disabling every character set raises `PasswordForge::NoCharsetSelectedError`:

```ruby
PasswordForge::Generator.new(
  upper_case: false, lower_case: false, numeric_case: false, special_case: false
)
# => raises PasswordForge::NoCharsetSelectedError
```

A non-positive or non-integer `length` raises `ArgumentError`.

## Character sets

| Flag           | Characters               |
| -------------- | ------------------------ |
| `upper_case`   | `A`–`Z`                  |
| `lower_case`   | `a`–`z`                  |
| `numeric_case` | `0`–`9`                  |
| `special_case` | `` !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~ `` |

## Trying it locally

You can run the gem without installing it from RubyGems:

- **From this repository:** `ruby examples/smoke_test.rb` prints a few sample
  passwords straight from the source tree.
- **From another project:** add `gem "password_forge", path:
  "/path/to/password-forge-ruby-gem"` to that project's `Gemfile`, run `bundle
  install`, then `require "password_forge"`. See
  [`examples/local-consumer/`](examples/local-consumer) for a working example.

Full instructions, including the interactive console and building a local
`.gem`, are in [docs/local-testing.md](docs/local-testing.md).

## Roadmap

`PasswordForge` is developed in incremental, tagged releases:

- **0.0.1** — Core generator, character sets, validation, tests, docs.
- **0.0.2** — Local-testing examples (`examples/`) and documentation (`docs/`).
- **0.1.0** — First public release on RubyGems.org via Trusted Publishing.
- **0.2.0** — Kiro skills for gem authors (feature TDD, version bump, release).
- **0.3.0** — Project `.kiro/` folder with steering and conventions.
- **0.4.0** — Kiro hooks (run specs on save, changelog reminders, and more).
- **0.5.0** — A Ruby MCP server exposing password generation as a tool.
- **0.6.0** — A fluent/builder API on top of the keyword-argument API.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then run
`bundle exec rake` to run the tests and the linter. You can also run
`bin/console` for an interactive prompt to experiment, or
`ruby examples/smoke_test.rb` for a quick check straight from source.

To install this gem onto your local machine, run `bundle exec rake install`. For
the full local workflow — including running it from a separate project and
uninstalling — see [docs/local-testing.md](docs/local-testing.md).

## Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/devandreacarratta/password-forge-ruby-gem>.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
