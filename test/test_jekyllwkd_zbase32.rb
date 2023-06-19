# frozen_string_literal: true

require "test_helper"

module JekyllWKD
  class TestZBase32 < Minitest::Test
    USERS = {
      "example" => "apr3aj3jqcf89yd69qd8pkjp3pzawxhx"
    }

    def test_hashing_user_names
      require "digest"

      USERS.each do |username, expects|
        encodes = ZBase32.encode Digest::SHA1.digest username
        assert_equal expects, encodes
      end
    end
  end
end
