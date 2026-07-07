require "yaml"
module ZipCodes
  require "zip-codes/version"
  require_relative "zip-codes/city_map"
  # require_relative "zip-codes/converter"

  class << self
    def identify(code, like_search: false)
      if like_search
        like(code)
      else
        db[code]
      end
    end

    def codes(city)
      city_index.fetch(city, []).dup
    end

    def like(code)
      db.select { |key, _| key.start_with?(code) }
    end

    def db
      @db ||= YAML.load_file(
        File.join(__dir__, "data", "DE.yml"),
        permitted_classes: [Symbol]
      )
    end

    def load
      db
    end

    private

    def city_index
      @city_index ||= db.each_with_object({}) do |(code, data), idx|
        (idx[data[:city]] ||= []) << code
      end
    end
  end
end
