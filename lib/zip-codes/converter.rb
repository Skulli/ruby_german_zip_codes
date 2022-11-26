class ZipCodes::Converter
  require "csv"
  attr_accessor :map

  def initialize(locale, load: true)
    @locale = locale
    self.map = ZipCodes::CityMap.new(yaml_file)
    map.load! if load
  end

  def convert
    CSV.foreach(csv_file, default_csv_options) do |row|
      add_line(row)
    end
  end

  def store!
    map.store!
  end

  def csv_file
    @csv_file ||= File.join(base_file, "..", "data", "#{@locale.downcase}.csv")
  end

  def yaml_file
    @yaml_file ||= File.join(base_file, "..", "data", "#{@locale.upcase}.yml")
  end

  def base_file
    @base ||= __dir__
  end

  def default_csv_options
    {
      col_sep: ";",
      quote_char: '"',
      force_quotes: false,
      row_sep: "\n",
      headers: true
    }
  end

  def add_line(row)
    map.add(
      row[2],
      {
        osm_id: row[0],
        county: row[3],
        city: row[1],
        state: row[4]
      }
    )
  end
end
