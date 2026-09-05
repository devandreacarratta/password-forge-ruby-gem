# Tech

## Stack

- **Language:** Ruby, `required_ruby_version >= 3.0.0`.
- **Test framework:** RSpec.
- **Linter:** RuboCop (config in `.rubocop.yml`, `TargetRubyVersion: 3.0`).
- **Randomness:** `SecureRandom` (standard library, no runtime dependencies).
- **Type signatures:** RBS stubs under `sig/`.

The gem has **no runtime dependencies**.

## Common commands

Run from the `password_forge/` directory:

```bash
bundle install            # install development dependencies
bundle exec rake          # default task: RSpec + RuboCop
bundle exec rspec         # run the test suite only
bundle exec rubocop       # run the linter only
bundle exec rubocop -A    # auto-correct safe offences
gem build password_forge.gemspec   # build the gem locally
bin/console               # interactive prompt with the gem loaded
```

## Development workflow

- **TDD.** Write the spec first, watch it fail, implement to green, then
  refactor. Keep the suite and RuboCop green before every commit.
- **Branches.** Do feature work on a `feature/vX.Y.Z-*` branch and merge to
  `main` per milestone. Never push directly to `main` for feature work.
- **Versioning.** Semantic Versioning. Bump `lib/password_forge/version.rb`,
  update `CHANGELOG.md` (Keep a Changelog format), then tag `vX.Y.Z`.

## Release process (Trusted Publishing)

Publishing is automated via OIDC — no API tokens are stored.

1. A one-time setup on RubyGems.org registers a trusted publisher:
   - RubyGem name: `password_forge`
   - Repository owner: `devandreacarratta`
   - Repository name: `password-forge-ruby-gem`
   - Workflow filename: `release.yml`
   - Environment: `release`
   For the very first publish (gem not yet on RubyGems), a **pending** trusted
   publisher is registered from the RubyGems profile before the gem exists.
2. `.github/workflows/release.yml` triggers on `v*` tags, uses
   `rubygems/release-gem@v1` with `contents: write` + `id-token: write` and the
   `release` GitHub environment.
3. Releasing = bump version, update CHANGELOG, merge to `main`, push the tag.

## Key decisions (recorded so they are not re-litigated)

- **Gem email removed.** `spec.email` is intentionally omitted from the gemspec
  (it is optional and would be public). The RubyGems account email is separate
  and private.
- **`Gemfile.lock` is not committed.** Committing it pinned `BUNDLED WITH 4.x`,
  which broke CI on Ruby < 3.2 (Bundler 4 requires Ruby 3.2+). Gems resolve the
  lockfile per environment, so it is git-ignored.
- **Gem name vs repo name differ on purpose** (`password_forge` vs
  `password-forge-ruby-gem`).
- **MFA required for pushes** via `rubygems_mfa_required = "true"` in the
  gemspec.
- **CI splits test and lint:** RSpec runs across Ruby 3.0–3.4; RuboCop runs once
  on 3.4 to avoid version-specific style noise.
- **Personal diary** lives in `private-notes/` (git-ignored), everything else is
  English and tracked.
