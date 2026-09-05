# frozen_string_literal: true

RSpec.describe PasswordForge::Generator do
  describe "#initialize" do
    it "defaults all character sets to true and length to 16" do
      generator = described_class.new
      password = generator.generate
      expect(password.length).to eq(16)
    end

    it "raises NoCharsetSelectedError when every set is disabled" do
      expect do
        described_class.new(
          upper_case: false, lower_case: false, numeric_case: false, special_case: false
        )
      end.to raise_error(PasswordForge::NoCharsetSelectedError)
    end

    it "raises ArgumentError for a non-positive length" do
      expect { described_class.new(length: 0) }.to raise_error(ArgumentError)
    end
  end

  describe "#generate" do
    it "returns a password of the requested length" do
      expect(described_class.new(length: 20).generate.length).to eq(20)
    end

    it "returns a String" do
      expect(described_class.new.generate).to be_a(String)
    end

    it "returns only digits when only the numeric set is enabled" do
      generator = described_class.new(
        upper_case: false, lower_case: false, numeric_case: true, special_case: false, length: 8
      )
      password = generator.generate
      expect(password).to match(/\A\d{8}\z/)
    end

    it "returns only uppercase letters when only the uppercase set is enabled" do
      generator = described_class.new(
        upper_case: true, lower_case: false, numeric_case: false, special_case: false, length: 12
      )
      expect(generator.generate).to match(/\A[A-Z]{12}\z/)
    end

    it "excludes characters from unselected sets" do
      generator = described_class.new(
        upper_case: true, lower_case: true, numeric_case: false, special_case: false, length: 50
      )
      expect(generator.generate).to match(/\A[A-Za-z]{50}\z/)
    end

    it "produces different passwords across calls (probabilistically)" do
      generator = described_class.new(length: 32)
      expect(generator.generate).not_to eq(generator.generate)
    end

    it "draws every character from the selected pool" do
      generator = described_class.new(length: 200)
      pool = PasswordForge::Charset.build(upper: true, lower: true, numeric: true, special: true)
      expect(generator.generate.chars.all? { |c| pool.include?(c) }).to be(true)
    end
  end

  describe "PasswordForge.generate" do
    it "is a convenience wrapper returning a password" do
      expect(PasswordForge.generate(length: 10)).to be_a(String)
      expect(PasswordForge.generate(length: 10).length).to eq(10)
    end

    it "forwards charset flags" do
      password = PasswordForge.generate(
        upper_case: false, lower_case: false, numeric_case: true, special_case: false, length: 6
      )
      expect(password).to match(/\A\d{6}\z/)
    end
  end
end
