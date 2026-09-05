#!/usr/bin/env ruby
# frozen_string_literal: true

# Smoke test for PasswordForge.
#
# Loads the gem straight from the local source tree (no install required) and
# prints a few sample passwords so you can eyeball that everything works.
#
# Run it from the repository root:
#
#     ruby examples/smoke_test.rb
#
require_relative "../lib/password_forge"

puts "PasswordForge v#{PasswordForge::VERSION} — smoke test"
puts "-" * 48

puts "Default (all sets, length 16):"
puts "  #{PasswordForge.generate}"

puts "Numeric PIN (length 4):"
puts "  #{PasswordForge::Generator.new(
  upper_case: false, lower_case: false, numeric_case: true, special_case: false, length: 4
).generate}"

puts "Letters only (length 24):"
puts "  #{PasswordForge::Generator.new(
  numeric_case: false, special_case: false, length: 24
).generate}"

puts "No character set selected (expected error):"
begin
  PasswordForge::Generator.new(
    upper_case: false, lower_case: false, numeric_case: false, special_case: false
  )
rescue PasswordForge::NoCharsetSelectedError => e
  puts "  raised #{e.class}: #{e.message}"
end
