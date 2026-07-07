require "bundler/gem_tasks"
require "yaml"

task :convert do
  require_relative "lib/zip-codes/city_map"
  require_relative "lib/zip-codes/converter"
  converter = ZipCodes::Converter.new("DE", load: false)
  converter.convert
  converter.store!
  puts "Converted #{converter.map.map.size} zip codes → lib/data/DE.yml"
end
