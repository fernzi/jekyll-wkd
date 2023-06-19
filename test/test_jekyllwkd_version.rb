# frozen_string_literal: true

require "test_helper"

class JekyllWKD::TestZBase32 < Minitest::Test
  VERSION_MATCH = /\d+\.\d+\.\d+/

  def test_valid_version_number
    assert_match VERSION_MATCH, ::JekyllWKD::VERSION
  end
end
