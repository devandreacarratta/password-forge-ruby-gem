# frozen_string_literal: true

# Demo entry point for the local-consumer example project.
#
# This mimics an external application that depends on password_forge. Bundler
# resolves the gem from the local path declared in the Gemfile, so a plain
# `require "password_forge"` loads it as if it had been installed normally.
#
# Run it from this directory:
#
#     bundle install
#     bundle exec ruby run.rb
#
require "password_forge"

puts "Using password_forge v#{PasswordForge::VERSION} from a local path dependency."
puts "Generated password: #{PasswordForge.generate}"
