class ZipCodes::CityMap
  attr_accessor :map, :data_file

  def initialize(data_file)
    self.map = Hash.new
    self.data_file = data_file
  end

  def add(code, data)
    if map[code]
      update_existing(code, data)
    else
      add_new(code, data)
    end
  end

  def to_yaml
    map.to_yaml
  end

  def load!
    self.map = YAML::load_file(data_file)
  end

  def store!
    File.write(data_file, to_yaml)
  end

  private

  # allow multiple cities for one code
  def update_existing(code, data)
    map[code][:city] = [
      *data[:city].to_s.split(";"),
      map[code][:city]
    ].uniq.join(";")
  end

  def add_new(code, data)
    map[code] = {
      osm_id: data.fetch(:osm_id),
      code: code,
      city: data.fetch(:city),
      county: data.fetch(:county),
      state: data.fetch(:state)
    }
  end
end
