# frozen_string_literal: true

require "securerandom"

module PasswordForge
  # Generates random passwords from selectable character sets.
  #
  # The constructor mirrors the original C# +PasswordGenerator+ design: four
  # boolean flags select the character sets, all enabled by default, and a
  # {NoCharsetSelectedError} is raised when none is selected.
  #
  # @example Generate a password with all character sets (default)
  #   PasswordForge::Generator.new.generate # => "aB3$xY7!qR2@kL9%"
  #
  # @example Generate a numeric-only PIN
  #   PasswordForge::Generator.new(
  #     upper_case: false, lower_case: false, numeric_case: true, special_case: false, length: 4
  #   ).generate # => "8391"
  class Generator
    # Default password length used when none is specified.
    DEFAULT_LENGTH = 16

    # @return [Integer] the configured password length
    attr_reader :length

    # @param upper_case [Boolean] include uppercase letters (A-Z)
    # @param lower_case [Boolean] include lowercase letters (a-z)
    # @param numeric_case [Boolean] include numeric digits (0-9)
    # @param special_case [Boolean] include special characters
    # @param length [Integer] the length of the generated password
    # @raise [NoCharsetSelectedError] if no character set is selected
    # @raise [ArgumentError] if length is not a positive integer
    def initialize(upper_case: true, lower_case: true, numeric_case: true, special_case: true,
                   length: DEFAULT_LENGTH)
      Validation.validate_charset_selection(
        upper: upper_case, lower: lower_case, numeric: numeric_case, special: special_case
      )
      Validation.validate_length(length)

      @length = length
      @pool = Charset.build(
        upper: upper_case, lower: lower_case, numeric: numeric_case, special: special_case
      )
    end

    # Generates a random password of the configured length.
    #
    # Uses {SecureRandom} for cryptographically secure randomness.
    #
    # @return [String] the generated password
    def generate
      Array.new(@length) { @pool[SecureRandom.random_number(@pool.length)] }.join
    end
  end

  # Convenience wrapper around {Generator#generate}.
  #
  # @see Generator#initialize
  # @return [String] the generated password
  def self.generate(**options)
    Generator.new(**options).generate
  end
end
