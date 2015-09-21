require 'yaml'

module ZipCodes
  VERSION = '0.2.1'

  class << self
    def identify(code, like: false)
      if like
        like(code)
      else
        db[code]
      end
    end

    def codes(city)
      db.select {|key, hash| hash[:city] == city}.keys
    end

    def like(code)
      db.select{|key, hash| key.present? && key.starts_with?(code) }
    end

    def db
      @db ||= begin
        this_file = File.expand_path(File.dirname(__FILE__))
        us_data = File.join(this_file, 'data', 'DE.yml')
        YAML.load(File.open(us_data))
      end
    end

    def load
      db
    end
  end
end
