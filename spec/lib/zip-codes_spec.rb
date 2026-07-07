RSpec.describe ZipCodes do
  it "has a version number" do
    expect(ZipCodes::VERSION).not_to be_nil
  end

  describe ".identify" do
    it "returns full entry for a known zip code" do
      expect(described_class.identify("20535")).to eq(
        city: "Hamburg",
        code: "20535",
        county: "Hamburg-Mitte",
        osm_id: "62782",
        state: "Hamburg"
      )
    end

    it "returns entry with Bezirk in county field" do
      expect(described_class.identify("13357")).to eq(
        city: "Berlin",
        code: "13357",
        county: "Mitte-Wedding-Tiergarten",
        osm_id: "62422",
        state: "Berlin"
      )
    end

    it "returns nil for unknown zip code" do
      expect(described_class.identify("00000")).to be_nil
    end

    it "delegates to like search when like_search: true" do
      result = described_class.identify("205", like_search: true)
      expect(result).to be_a(Hash)
      expect(result.keys).to all(start_with("205"))
    end
  end

  describe ".codes" do
    it "includes a known Hamburg zip code" do
      expect(described_class.codes("Hamburg")).to include("20535")
    end

    it "returns correct count for Hamburg" do
      expect(described_class.codes("Hamburg").count).to eq(98)
    end

    it "returns an Array" do
      expect(described_class.codes("Berlin")).to be_an(Array)
    end

    it "returns empty array for unknown city" do
      expect(described_class.codes("Atlantis")).to eq([])
    end
  end

  describe ".like" do
    it "returns all entries matching the prefix" do
      expect(described_class.like("205").count).to eq(3)
    end

    it "returns only entries starting with the prefix" do
      result = described_class.like("801")
      expect(result.keys).to all(start_with("801"))
    end

    it "returns empty hash for unknown prefix" do
      expect(described_class.like("99999")).to be_empty
    end
  end

  describe ".load" do
    it "preloads the database" do
      described_class.load
      expect(described_class.db).not_to be_nil
    end
  end
end
