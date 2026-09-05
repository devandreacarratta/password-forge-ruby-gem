# frozen_string_literal: true

module PasswordForge
  # Validates the configuration of a password generator.
  #
  # Mirrors the validation responsibilities of the original C# design:
  # rejecting a configuration with no character set selected and rejecting
  # an invalid password length.
  module Validation
    # Ensures that at least one character set is selected.
    #
    # @param upper [Boolean] uppercase flag
    # @param lower [Boolean] lowercase flag
    # @param numeric [Boolean] numeric flag
    # @param special [Boolean] special flag
    # @raise [NoCharsetSelectedError] if every flag is false
    # @return [void]
    def self.validate_charset_selection(upper:, lower:, numeric:, special:)
      return if upper || lower || numeric || special

      raise NoCharsetSelectedError
    end

    # Ensures that the requested password length is a positive integer.
    #
    # @param length [Integer] the requested password length
    # @raise [ArgumentError] if length is not a positive integer
    # @return [void]
    def self.validate_length(length)
      raise ArgumentError, "length must be an Integer, got #{length.class}" unless length.is_a?(Integer)
      raise ArgumentError, "length must be a positive integer, got #{length}" unless length.positive?
    end
  end
end
