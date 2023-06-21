# frozen_string_literal: true

require "jekyll"
require "digest"

module JekyllWKD
  class KeyFile < ::Jekyll::StaticFile
    attr_reader :advanced, :fingerprint

    def initialize site, base, dir, name, fpr, adv = true
      @fingerprint = fpr
      @advanced = adv
      super site, base, dir, name
    end

    def destination dest
      @destination ||= {}
      @destination[dest] ||= @site.in_dest_dir(
        dest, PGP_PATH, advanced ? domain : "", "hu", hash
      )
    end

    def write dest
      dest_path = destination dest
      return false if File.exist?(dest_path) && !modified?

      self.class.mtimes[path] = mtime

      FileUtils.mkdir_p(File.dirname(dest_path))
      FileUtils.rm(dest_path) if File.exist?(dest_path)

      File.open(dest_path, "w") { |f| pgpkey.export output: f }
      true
    end

    def domain
      @domain ||= pgpkey.email.split("@").last
    end

    def username
      @username || pgpkey.email.split("@").first
    end

    def hash
      @hash ||= ZBase32.encode Digest::SHA1.digest username
    end

    private

    def pgpkey
      @pgpkey ||= GPGME::Key.get(fingerprint)
    end
  end
end
