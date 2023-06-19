# frozen_string_literal: true

require "test_helper"

module JekyllWKD
  class TestGenerator < Minitest::Test
    def setup
      @site = fixture_site "site"
      @site.process
    end

    def test_generating_a_policy
      pol = @site.in_dest_dir PGP_PATH, "example.com/policy"
      assert File.exist? pol
    end

    def test_exporting_keys
      require "digest"
      keys = %w[
        tkg67ingrxkceoueajuffsyjesntau59
        wwq7w9d96wfsd4zkytndq84kpkjod3eb
      ]
      keys.each do |k|
        key = @site.in_dest_dir PGP_PATH, "example.com/hu", k
        assert File.exist? key
      end
    end
  end
end
