cask "aitmproxy" do
  version "0.5.7"
  sha256 "1af0423107497af3cfe1a67aea88f099ee7dbb6f2382adef76cc4ec8faee76aa"

  # Public binary hosted on the tap repo's own release (the source repo stays private).
  url "https://github.com/mrbrutti/homebrew-aitmproxy/releases/download/v#{version}/Aitmproxy-#{version}.dmg"
  name "Aitmproxy"
  desc "Native macOS operator UI for aitmproxy"
  homepage "https://github.com/mrbrutti/aitmproxy"

  depends_on arch: :arm64

  app "Aitmproxy.app"

  zap trash: [
    "~/Library/Application Support/Aitmproxy",
  ]
end
