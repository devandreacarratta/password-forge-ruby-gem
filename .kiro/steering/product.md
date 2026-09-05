# Product

## What this is

`password_forge` is a configurable password generator distributed as a Ruby gem.
It generates random passwords from four selectable character sets — uppercase,
lowercase, numeric and special — that can be switched on or off independently.
All sets are enabled by default, and an error is raised if every set is
disabled. Randomness comes from Ruby's `SecureRandom`.

The public API mirrors the design of an existing C# / NuGet package: a
constructor with four boolean flags plus a length, and a dedicated exception
when no character set is selected.

## Goals

1. **Learning vehicle.** This is the author's first Ruby gem. Code favours
   clarity and idiomatic Ruby over cleverness, and everything is built with TDD.
2. **Kiro evangelism in the Ruby world.** Beyond the gem itself, the project
   ships a full "Kiro-native" experience for Ruby gem authors: Kiro skills,
   project steering (this folder), hooks, and an MCP server. The repository is
   meant to be a reference example of building and shipping a gem the Kiro way.

## Audience

- Ruby developers who need a small, dependency-free password generator.
- Ruby developers curious about using Kiro to build and release gems.

## Language

All repository content (code, comments, docs, commit messages) is in **English**.
The only exception is the author's personal development diary, which is kept
locally in `private-notes/` and excluded from the repository.

## Release roadmap

The project ships in small, tagged increments. Each version is merged to `main`
before the next begins:

- **0.0.1** — Core generator, character sets, validation, tests, docs. (done)
- **0.1.0** — First public release on RubyGems.org via Trusted Publishing.
- **0.2.0** — Kiro skills for gem authors (feature TDD, version bump, release).
- **0.3.0** — Project `.kiro/` folder with full steering and conventions.
- **0.4.0** — Kiro hooks (run specs on save, changelog reminders, etc.).
- **0.5.0** — A Ruby MCP server exposing password generation as a tool.
- **0.6.0** — A fluent/builder API layered on top of the keyword-argument API.
