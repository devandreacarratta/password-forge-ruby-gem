# frozen_string_literal: true

module PasswordForge
  # Value object holding the available character sets and building the pool
  # of characters from the selected sets.
  #
  # The four sets mirror the character categories of the original C# design:
  # uppercase (A-Z), lowercase (a-z), numeric (0-9) and special (punctuation).
  module Charset
    # Uppercase letters, from 'A' to 'Z'.
    UPPER = ("A".."Z").to_a.freeze

    # Lowercase letters, from 'a' to 'z'.
    LOWER = ("a".."z").to_a.freeze

    # Numeric digits, from '0' to '9'.
    NUMERIC = ("0".."9").to_a.freeze

    # Special (punctuation) characters.
    SPECIAL = %w[! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \\ ] ^ _ ` { | } ~].freeze

    # Builds the pool of characters from the selected sets.
    #
    # @param upper [Boolean] include uppercase letters (A-Z)
    # @param lower [Boolean] include lowercase letters (a-z)
    # @param numeric [Boolean] include numeric digits (0-9)
    # @param special [Boolean] include special characters
    # @return [Array<String>] the combined pool of unique characters
    def self.build(upper:, lower:, numeric:, special:)
      pool = []
      pool.concat(UPPER) if upper
      pool.concat(LOWER) if lower
      pool.concat(NUMERIC) if numeric
      pool.concat(SPECIAL) if special
      pool
    end
  end
end
