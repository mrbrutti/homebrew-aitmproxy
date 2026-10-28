require_relative "../lib/private_strategy"

cask "aitmproxy" do
  version "0.1"
  sha256 "007ae8de52622db9d6d047b851d895747be851b0a4a9b6cb05b89112445343b2"

  # Private repo: authenticated download (needs HOMEBREW_GITHUB_API_TOKEN).
  url "https://github.com/mrbrutti/homebrew-aitmproxy/releases/download/v0.1.0/Aitmproxy-#{version}.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Aitmproxy"
  desc "Native macOS operator UI for aitmproxy"
  homepage "https://github.com/mrbrutti/aitmproxy"

  depends_on arch: :arm64

  caveats <<~EOS
    This is a private tap: before installing, export a GitHub token with
    `repo` scope: export HOMEBREW_GITHUB_API_TOKEN=ghp_xxxxxxxx
  EOS

  app "Aitmproxy.app"

  zap trash: [
    "~/Library/Application Support/Aitmproxy",
  ]
end
