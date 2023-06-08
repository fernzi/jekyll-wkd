# frozen_string_literal: true

require "test_helper"

class JekyllWKD::Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::JekyllWKD::VERSION
  end

  def test_that_it_hashes_user_names
    require "digest"
    expected = "apr3aj3jqcf89yd69qd8pkjp3pzawxhx"
    encoded = ::JekyllWKD::ZBase32.encode Digest::SHA1.digest "example"
    assert expected == encoded
  end
end
