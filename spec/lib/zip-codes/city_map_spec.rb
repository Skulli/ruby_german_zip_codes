require "tmpdir"

RSpec.describe ZipCodes::CityMap do
  subject(:karte) { described_class.new(datei) }

  let(:datei) { File.join(Dir.tmpdir, "city_map_spec.yml") }
  let(:hamburg) { {osm_id: "62782", city: "Hamburg", county: "Hamburg-Mitte", state: "Hamburg"} }

  after { File.delete(datei) if File.exist?(datei) }

  describe "#add" do
    it "legt einen neuen Eintrag mit allen Feldern an" do
      karte.add("20535", hamburg)

      expect(karte.map["20535"]).to eq(
        osm_id: "62782", code: "20535", city: "Hamburg",
        county: "Hamburg-Mitte", state: "Hamburg"
      )
    end

    it "verlangt die Pflichtfelder" do
      expect { karte.add("20535", {city: "Hamburg"}) }.to raise_error(KeyError)
    end

    it "haengt eine zweite Stadt an denselben Code an" do
      karte.add("20535", hamburg)
      karte.add("20535", {city: "Altona"})

      expect(karte.map["20535"][:city]).to eq("Altona;Hamburg")
    end

    # Der Fall, der in DE.yml ein doppeltes "Koethel" erzeugt hat: ab der
    # zweiten Stadt ist der bestehende Wert selbst zusammengesetzt. Wird er
    # ungeteilt verglichen, erkennt uniq eine erneut gemeldete Stadt nicht.
    it "nimmt eine bereits eingetragene Stadt kein zweites Mal auf" do
      karte.add("20535", hamburg)
      karte.add("20535", {city: "Altona"})
      karte.add("20535", {city: "Hamburg"})

      expect(karte.map["20535"][:city]).to eq("Hamburg;Altona")
    end

    it "zerlegt auch mehrere Staedte in einer Angabe" do
      karte.add("20535", hamburg)
      karte.add("20535", {city: "Altona;Hamburg"})

      expect(karte.map["20535"][:city]).to eq("Altona;Hamburg")
    end
  end

  describe "#to_yaml" do
    it "gibt die Karte als YAML zurueck" do
      karte.add("20535", hamburg)

      expect(YAML.safe_load(karte.to_yaml, permitted_classes: [Symbol])).to eq(
        "20535" => {
          osm_id: "62782", code: "20535", city: "Hamburg",
          county: "Hamburg-Mitte", state: "Hamburg"
        }
      )
    end
  end

  describe "#store! und #load!" do
    it "schreibt die Karte und liest sie unveraendert zurueck" do
      karte.add("20535", hamburg)
      karte.store!

      gelesen = described_class.new(datei)
      gelesen.load!

      expect(gelesen.map).to eq(karte.map)
    end
  end
end
