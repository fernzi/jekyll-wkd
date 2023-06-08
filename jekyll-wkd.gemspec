# frozen_string_literal: true

require_relative "lib/jekyll-wkd/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-wkd"
  spec.version = JekyllWKD::VERSION
  spec.authors = ["Fern Zapata"]

  spec.summary = "Jekyll plugin to generate an OpenPGP Web Key Directory (WKD)"
  spec.homepage = "https://github.com/fernzi/jekyll-wkd"
  spec.license = "LGPL-3.0-or-later"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) { `git ls-files -z lib`.split "\0" }
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", ">= 3.0", "< 5.0"
  spec.add_dependency "gpgme", "~> 2.0"
end
