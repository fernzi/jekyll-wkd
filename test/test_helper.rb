# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "jekyll-wkd"

require "minitest/autorun"

def fixture_path name
  File.expand_path "fixtures/#{name}", __dir__
end

def fixture_site name, override = {}
  default = {
    "destination" => File.expand_path("_site", __dir__),
    "full_rebuild" => true,
    "source" => fixture_path(name)
  }
  config = Jekyll.configuration Jekyll::Utils.deep_merge_hashes(
    default, override
  )
  Jekyll::Site.new config
end
