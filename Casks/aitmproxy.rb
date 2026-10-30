require_relative "../lib/private_strategy"

cask "aitmproxy" do
  version "0.5.0"
  sha256 "de7312e477afbe6fe8e4ca9160ce16e65f41b76610a52a74349af36c9d87778f"

  # The notarized DMG is a release asset of the main (currently private) repo:
  # authenticated download (needs HOMEBREW_GITHUB_API_TOKEN).
  url "https://github.com/mrbrutti/aitmproxy/releases/download/v#{version}/Aitmproxy-#{version}.dmg",
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
