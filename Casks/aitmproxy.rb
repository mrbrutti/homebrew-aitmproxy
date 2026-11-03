cask "aitmproxy" do
  version "0.5.18"
  sha256 "5287947095e2f1ffe83169f71778e6928f25620244bf91143a995aee9b30bb68"

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
