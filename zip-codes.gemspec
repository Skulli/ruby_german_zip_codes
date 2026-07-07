lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "zip-codes/version"

Gem::Specification.new do |spec|
  spec.name = "zip-codes"
  spec.version = ZipCodes::VERSION
  spec.authors = ["Sascha Skulima"]
  spec.email = ["sascha.skulima@symdok.de"]
  spec.description = "Gem to look up German zip codes (PLZ) — returns city, county, and federal state"
  spec.summary = "German zip code (PLZ) lookup gem"
  spec.homepage = "https://github.com/Skulli/ruby_german_zip_codes"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($RS)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard"

  spec.required_ruby_version = ">= 3.0.0"
end
