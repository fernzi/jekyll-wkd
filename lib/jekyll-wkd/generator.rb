# frozen_string_literal: true

require_relative "keyfile"
require_relative "policyfile"
require "jekyll"
require "gpgme"
require "set"
require "tmpdir"

module JekyllWKD
  class Generator < ::Jekyll::Generator
    safe true
    priority :normal

    CONF_KEY = "wkd"
    CONF_DEFAULT = {
      "path" => "keys",
      "exts" => %w[.asc .pub]
    }

    def generate site
      @site = site

      pgp_home = Dir.mktmpdir "jekyll-wkd-"
      GPGME::Engine.home_dir = pgp_home
      Jekyll::Hooks.register :site, :post_write do
        FileUtils.remove_dir pgp_home
      end

      domains = Set.new

      key_files.each do |file|
        File.open(file.path) do |data|
          GPGME::Key.import(data).imports.each do |key|
            kf = KeyFile.new(
              @site,
              @site.source,
              File.dirname(file.relative_path),
              File.basename(file.relative_path),
              key.fingerprint
            )
            domains << kf.domain
            @site.static_files << kf
          end
        end
      end

      domains.each do |domain|
        @site.pages << make_policy(domain)
      end
    end

    private

    def config
      @config ||= CONF_DEFAULT.merge @site.config.fetch(CONF_KEY, {})
    end

    def in_path? file
      File.exist? @site.in_source_dir(config["path"], file.name)
    end

    def key_files
      @key_files ||= @site.static_files.select do |file|
        in_path?(file) && file.relative_path.end_with?(*config["exts"])
      end
    end

    def make_policy domain
      path = File.join(PGP_PATH, domain, "policy")
      PolicyFile.new(@site, __dir__, "", path).tap do |page|
        page.content = "# Policy flags for domain `#{domain}`\n"
        page.data.merge!(
          "layout" => nil,
          "sitemap" => false
        )
      end
    end
  end
end
