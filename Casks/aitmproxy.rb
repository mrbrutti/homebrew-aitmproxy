cask "aitmproxy" do
  version "0.5.16"
  sha256 "a162a9536b4dbaba3d10c41c069d95e879e7ccff8f7573318a7a43b871b54b34"

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
