cask "aitmproxy" do
  version "0.5.13"
  sha256 "8ace0241a0d7a8f06af6b58610f7ab0f10057b90733caa5960a5032694a03d1f"

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
