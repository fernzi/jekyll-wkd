# frozen_string_literal: true

require_relative "jekyll-wkd/generator"

module JekyllWKD
  PGP_PATH = ".well-known/openpgpkey"

  autoload :VERSION, "jekyll-wkd/version"
end
