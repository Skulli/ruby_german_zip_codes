require 'yaml'
module ZipCodes
  VERSION = '0.2.1'

  require_relative 'zip-codes/city_map'
  require_relative 'zip-codes/converter'

  class << self
    def identify(code, like_search: false)
      if like_search
        like(code)
      else
        db[code]
      end
    end

    def codes(city)
      db.select {|key, hash| hash[:city] == city}.keys
    end

    def like(code)
      db.select{|key, hash| key && key.index(code) == 0 }
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
