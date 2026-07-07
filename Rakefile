require "bundler/gem_tasks"
require "yaml"

task :convert do
  require_relative "lib/zip-codes/city_map"
  require_relative "lib/zip-codes/converter"
  converter = ZipCodes::Converter.new("DE", load: false)
  converter.convert
  converter.store!
  city_map = converter.map
  puts "Converted #{city_map.map.size} zip codes → lib/data/DE.yml"
end
