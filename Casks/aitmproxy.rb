cask "aitmproxy" do
  version "0.5.3"
  sha256 "923d0e91a6ed925dc5ed78c521f230a40ab101fe5add85426de9737f8aec995a"

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
