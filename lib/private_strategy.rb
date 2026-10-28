# Authenticated download strategy for a release asset in a PRIVATE GitHub repo.
#
# Homebrew removed its built-in GitHubPrivateRepository*DownloadStrategy classes,
# so this tap vendors one. Formula/aitm.rb and Casks/aitmproxy.rb both
# `require_relative` this file and pass `using:` it. A plain `url` 404s on a
# private repo because Homebrew's download is unauthenticated.
#
# How it works: the public `releases/download/<tag>/<file>` URL is never fetched
# directly (that path 404s without auth). Instead we look up the asset id via the
# GitHub REST API (authenticated with HOMEBREW_GITHUB_API_TOKEN), then point
# Homebrew's resolver at `…/releases/assets/<id>` with an `Accept:
# application/octet-stream` + token header. GitHub answers that with a 302 to a
# credential-free storage URL; Homebrew drops the headers on that cross-host
# redirect and downloads the asset from there.
require "download_strategy"
require "utils/github"

class GitHubPrivateRepositoryReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
    set_github_token
  end

  def parse_url_pattern
    url_pattern = %r{https://github\.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    unless @url =~ url_pattern
      raise CurlDownloadStrategyError, "Invalid URL pattern for a private GitHub release asset: #{@url}"
    end

    _, @owner, @repo, @tag, @filename = *@url.match(url_pattern)
  end

  def download_url
    "https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"
  end

  private

  def set_github_token
    @github_token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", nil)
    return if @github_token

    raise CurlDownloadStrategyError, <<~EOS
      HOMEBREW_GITHUB_API_TOKEN is required to install from the private tap mrbrutti/aitmproxy.
      Create a GitHub token with `repo` scope and export it, e.g.:
        export HOMEBREW_GITHUB_API_TOKEN=ghp_xxxxxxxx
    EOS
  end

  # Resolve the authenticated asset API URL instead of the public release URL.
  # Homebrew sends `meta[:headers]` with the HEAD it does here, follows the 302
  # to the (pre-signed) storage host, then drops these headers for the actual
  # download because that host differs — so no credentials leak to storage.
  def resolve_url_basename_time_file_size(url, timeout: nil)
    meta[:headers] = ["Accept: application/octet-stream", "Authorization: token #{@github_token}"]
    super(download_url, timeout:)
  end

  def asset_id
    @asset_id ||= resolve_asset_id
  end

  def resolve_asset_id
    assets = fetch_release_metadata["assets"].select { |asset| asset["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset '#{@filename}' not found in release '#{@tag}'." if assets.empty?

    assets.first["id"]
  end

  def fetch_release_metadata
    GitHub::API.open_rest("https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}")
  end
end
