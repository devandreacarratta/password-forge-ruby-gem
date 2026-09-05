# frozen_string_literal: true

RSpec.describe PasswordForge::Charset do
  describe "constants" do
    it "defines the uppercase set as A-Z" do
      expect(described_class::UPPER).to eq(("A".."Z").to_a)
    end

    it "defines the lowercase set as a-z" do
      expect(described_class::LOWER).to eq(("a".."z").to_a)
    end

    it "defines the numeric set as 0-9" do
      expect(described_class::NUMERIC).to eq(("0".."9").to_a)
    end

    it "defines a non-empty special set" do
      expect(described_class::SPECIAL).to be_an(Array)
      expect(described_class::SPECIAL).not_to be_empty
    end

    it "freezes the character set constants" do
      expect(described_class::UPPER).to be_frozen
      expect(described_class::LOWER).to be_frozen
      expect(described_class::NUMERIC).to be_frozen
      expect(described_class::SPECIAL).to be_frozen
    end
  end

  describe ".build" do
    it "returns the union of all sets when every flag is true" do
      pool = described_class.build(upper: true, lower: true, numeric: true, special: true)
      expected = described_class::UPPER + described_class::LOWER +
                 described_class::NUMERIC + described_class::SPECIAL
      expect(pool).to match_array(expected)
    end

    it "includes only the selected sets" do
      pool = described_class.build(upper: true, lower: false, numeric: true, special: false)
      expect(pool).to match_array(described_class::UPPER + described_class::NUMERIC)
    end

    it "excludes characters from unselected sets" do
      pool = described_class.build(upper: false, lower: true, numeric: false, special: false)
      expect(pool).to match_array(described_class::LOWER)
      expect(pool).not_to include(*described_class::UPPER)
      expect(pool).not_to include(*described_class::NUMERIC)
    end

    it "returns an empty array when no set is selected" do
      pool = described_class.build(upper: false, lower: false, numeric: false, special: false)
      expect(pool).to eq([])
    end

    it "returns a pool with no duplicate characters" do
      pool = described_class.build(upper: true, lower: true, numeric: true, special: true)
      expect(pool.uniq).to eq(pool)
    end
  end
end
