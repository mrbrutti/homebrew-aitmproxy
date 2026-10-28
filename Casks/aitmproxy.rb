cask "aitmproxy" do
  version "0.1"
  sha256 "007ae8de52622db9d6d047b851d895747be851b0a4a9b6cb05b89112445343b2"

  url "https://github.com/mrbrutti/homebrew-aitmproxy/releases/download/v0.1.0/Aitmproxy-#{version}.dmg"
  name "Aitmproxy"
  desc "Native macOS operator UI for aitmproxy"
  homepage "https://github.com/mrbrutti/aitmproxy"

  depends_on arch: :arm64

  app "Aitmproxy.app"

  zap trash: [
    "~/Library/Application Support/Aitmproxy",
  ]
end
