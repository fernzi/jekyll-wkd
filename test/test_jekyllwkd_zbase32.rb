# frozen_string_literal: true

require "test_helper"

module JekyllWKD
  class TestZBase32 < Minitest::Test
    def test_hashing_user_names
      require "digest"
      example = "example"
      expects = "apr3aj3jqcf89yd69qd8pkjp3pzawxhx"
      encodes = ZBase32.encode Digest::SHA1.digest example
      assert_equal expects, encodes
    end
  end
end
