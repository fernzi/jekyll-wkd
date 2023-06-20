# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "jekyll-wkd"

require "minitest/autorun"
require "tmpdir"

def fixture_path name
  File.expand_path "fixtures/#{name}", __dir__
end

def fixture_site name, override = {}
  default = {
    "destination" => Dir.mktmpdir("jekyll-wkd-test-"),
    "full_rebuild" => true,
    "source" => fixture_path(name)
  }
  config = Jekyll::Utils.deep_merge_hashes default, override
  config = Jekyll.configuration config
  Jekyll::Site.new config
end
