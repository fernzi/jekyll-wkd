# frozen_string_literal: true

require "test_helper"

module JekyllWKD
  TEST_DOMAIN = "example.com"
  TEST_KEYS = %w[
    tkg67ingrxkceoueajuffsyjesntau59
    wwq7w9d96wfsd4zkytndq84kpkjod3eb
  ]

  class TestGenerator < Minitest::Test
    def setup
      @site = fixture_site "site"
      @site.process
    end

    def teardown
      FileUtils.remove_dir @site.dest
    end

    def test_generating_a_policy
      pol = @site.in_dest_dir PGP_PATH, TEST_DOMAIN, "policy"
      assert File.exist? pol
    end

    def test_exporting_keys
      require "digest"
      TEST_KEYS.each do |k|
        key = @site.in_dest_dir PGP_PATH, TEST_DOMAIN, "hu", k
        assert File.exist? key
      end
    end
  end
end
