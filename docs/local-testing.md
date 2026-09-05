# Trying PasswordForge locally

This guide shows how to run the gem without publishing it, both from inside this
repository and from a separate project that depends on it via a local path.

All commands assume you start from the repository root
(`password-forge-ruby-gem/`) unless stated otherwise.

## 1. From this folder

### Run the smoke test

The quickest check. It loads the gem straight from `lib/` (no install needed)
and prints a few sample passwords:

```bash
ruby examples/smoke_test.rb
```

You should see a default password, a numeric PIN, a letters-only password, and
the `NoCharsetSelectedError` being raised on purpose.

### Use the interactive console

`bin/console` boots an IRB session with the gem already required:

```bash
bin/console
```

```ruby
PasswordForge.generate
PasswordForge::Generator.new(length: 32).generate
```

### Install it onto your machine

To install the current checkout as a normal gem on your system:

```bash
bundle exec rake install
```

After that, `require "password_forge"` works from any Ruby project on the same
machine.

## 2. From a different project (local path dependency)

This is how you consume the gem from another application while developing it,
without pushing anything to RubyGems.

In the other project's `Gemfile`, point Bundler at your checkout:

```ruby
# Gemfile of your other project
source "https://rubygems.org"

gem "password_forge", path: "/absolute/path/to/password-forge-ruby-gem"
```

Then, from that project:

```bash
bundle install
```

```ruby
require "password_forge"

PasswordForge.generate
```

Bundler resolves the gem from the given path, so a plain `require` works as if
the gem had been installed from RubyGems. Any edit you make in the gem source is
picked up on the next run — no reinstall needed.

### Ready-made example

A working example of this setup lives in
[`examples/local-consumer/`](../examples/local-consumer). It is a minimal
project whose `Gemfile` references the gem with a relative path (`../..`):

```bash
cd examples/local-consumer
bundle install
bundle exec ruby run.rb
```

## 3. Alternative: build and install a .gem

If you prefer to test the packaged artifact rather than a path dependency:

```bash
gem build password_forge.gemspec
gem install ./password_forge-0.0.2.gem
```

This installs the exact files that would ship to RubyGems (the `examples/` and
`docs/` folders are intentionally excluded from the package).

## 4. Uninstalling / switching to the published gem

If you installed the gem locally (via `rake install` or `gem install`) and want
to remove it, use `gem uninstall` rather than deleting files by hand:

```bash
gem uninstall password_forge
```

To see what is installed, or to target a specific version:

```bash
gem list password_forge
gem uninstall password_forge -v 0.0.2
```

Once the gem is published, switching to the RubyGems release is a plain
uninstall followed by a normal install:

```bash
gem uninstall password_forge
gem install password_forge
```

> **Note:** `password_forge` is not on RubyGems yet (the first public release is
> planned for 0.1.0 — see the roadmap in the [main README](../README.md)). Until
> then, `gem install password_forge` will not find it, so the local install and
> path-dependency approaches above are the way to try it.
>
> While developing, the path dependency in section 2 is usually the most
> convenient: there is nothing to install or uninstall, and source edits are
> picked up on the next run.
