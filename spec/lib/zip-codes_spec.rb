RSpec.describe ZipCodes do
  it "has a version number" do
    expect(ZipCodes::VERSION).to eq("0.2.1")
  end

  it "includes correct zip code" do
    expect(described_class.codes("Hamburg")).to include("20535")
  end

  it "has correct amount for hamburg" do
    expect(described_class.codes("Hamburg").count).to eq(98)
  end

  it "like search" do
    expect(described_class.like("205").count).to eq(3)
  end

  it "exact entry" do
    expect(described_class.identify("20535")).to eq({city: "Hamburg", code: "20535", county: nil, osm_id: "62782", state: "Hamburg"})
  end

  it "exact entry with bezirk" do
    expect(described_class.identify("13357")).to eq({city: "Berlin", code: "13357", county: "Mitte-Wedding-Tiergarten", osm_id: "62422", state: "Berlin"})
  end
end
