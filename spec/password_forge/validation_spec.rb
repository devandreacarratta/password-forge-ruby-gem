# frozen_string_literal: true

RSpec.describe PasswordForge::Validation do
  describe ".validate_charset_selection" do
    it "does not raise when at least one flag is true" do
      expect do
        described_class.validate_charset_selection(
          upper: false, lower: false, numeric: false, special: true
        )
      end.not_to raise_error
    end

    it "does not raise when all flags are true" do
      expect do
        described_class.validate_charset_selection(
          upper: true, lower: true, numeric: true, special: true
        )
      end.not_to raise_error
    end

    it "raises NoCharsetSelectedError when every flag is false" do
      expect do
        described_class.validate_charset_selection(
          upper: false, lower: false, numeric: false, special: false
        )
      end.to raise_error(PasswordForge::NoCharsetSelectedError)
    end

    it "raises with a descriptive message" do
      expect do
        described_class.validate_charset_selection(
          upper: false, lower: false, numeric: false, special: false
        )
      end.to raise_error(PasswordForge::NoCharsetSelectedError, /at least one character set/i)
    end
  end

  describe ".validate_length" do
    it "does not raise for a positive length" do
      expect { described_class.validate_length(16) }.not_to raise_error
    end

    it "raises ArgumentError for zero length" do
      expect { described_class.validate_length(0) }.to raise_error(ArgumentError)
    end

    it "raises ArgumentError for a negative length" do
      expect { described_class.validate_length(-1) }.to raise_error(ArgumentError)
    end

    it "raises ArgumentError for a non-integer length" do
      expect { described_class.validate_length("16") }.to raise_error(ArgumentError)
    end
  end
end
