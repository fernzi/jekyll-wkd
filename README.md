# Jekyll Web Key Directory

[![Gem Version](https://img.shields.io/gem/v/jekyll-wkd?label=Gem)][ruby-gem]
[![License: LGPLv3+](https://img.shields.io/badge/License-LGPLv3%2B-orange)][license]
[![CI](https://github.com/fernzi/jekyll-wkd/actions/workflows/main.yml/badge.svg)][ci-status]

[ruby-gem]:  https://rubygems.org/gems/jekyll-wkd
[license]:   https://www.gnu.org/licenses/
[ci-status]: https://github.com/fernzi/jekyll-wkd/actions/workflows/main.yml

A Jekyll plugin to generate an OpenPGP Web Key Directory (WKD).

[Web Key Directory](https://wiki.gnupg.org/WKD) is a standard and
decentralized way of distributing OpenPGP keys
without relying on the traditional public key servers, like SKS,
which have proven increasingly unreliable and prone to abuse
and impersonation.

Given a set of public keys, this plugin generates a directory with the
["advanced" format](https://lab.uberspace.de/guide_wkd/#advanced-method),
suitable for hosting under an `openpgpkey` subdomain,
e.g. `https://openpgpkey.example.com`.

## Installation

Add the plugin's gem to your site's Gemfile like so:

``` ruby
group :jekyll_plugins do
  gem "jekyll-wkd"
end
```

And install the newly added gem with the command:

``` shell
bundle install
```

Older versions of Jekyll might not automatically activate
the plugins under the `:jekyll_plugins` group.
If so, you'll need to add it into your site's `_config.yml` file:

``` yaml
plugins:
  - jekyll-wkd
```

## Usage

This plugin should work without any further configuration.
Just place the public keys you wish to export under the `keys`
directory within your site's source, and the plugin will
export them into the `.well-known/openpgpkey` directory
on the generated site.

The keys will still be regarded as static files by Jekyll,
so they'll also be copied over to the generated side under
the same directory they're in.

If you need to scan keys from a different directory,
or change which file extensions are considered as key files,
you can change these settings on your site's `_config.yml` file.
The default settings are:

``` yaml
wkd:
  path: 'keys'
  exts: ['.asc', '.pub']
```

Also note that if you change your site's `baseurl`,
PGP tools might not be able to find your published keys,
since the `.well-known` directory needs to be on the root
of the URL.
