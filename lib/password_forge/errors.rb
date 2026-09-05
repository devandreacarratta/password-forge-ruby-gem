# frozen_string_literal: true

module PasswordForge
  # Base error class for all PasswordForge-specific errors.
  class Error < StandardError; end

  # Raised when a generator is configured with no character set selected,
  # mirroring the +InvalidCharSetException+ of the original C# design.
  class NoCharsetSelectedError < Error
    # Default message shown when no character set is selected.
    DEFAULT_MESSAGE = "At least one character set must be selected " \
                      "(upper_case, lower_case, numeric_case or special_case)."

    def initialize(message = DEFAULT_MESSAGE)
      super
    end
  end
end
