# frozen_string_literal: true

require "test_helper"

module JekyllWKD
  class TestVersion < Minitest::Test
    VERSION_MATCH = /\d+\.\d+\.\d+/

    def test_valid_version_number
      assert_match VERSION_MATCH, VERSION
    end
  end
end
