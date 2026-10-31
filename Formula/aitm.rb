class Aitm < Formula
  desc "Intercepting proxy for authorized security testing (proxy, CLI, web, TUI)"
  homepage "https://github.com/mrbrutti/aitmproxy"
  version "0.5.3"
  # Public binaries are hosted on the tap repo's own release; the source repo
  # stays private, so this points at mrbrutti/homebrew-aitmproxy, not the source.
  url "https://github.com/mrbrutti/homebrew-aitmproxy/releases/download/v#{version}/aitm-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "f7ae8c192e0f7d331b45a948a5840a05ec573730ec47f5d00dd0fc4940c5ca3b"
  license any_of: ["MIT", "Apache-2.0"]

  # Prebuilt Apple Silicon binary bundle: `aitm`, the standalone `aitm-tui`
  # operator UI, and the `obscura` browser engine `aitm` drives. `aitm` finds
  # `obscura` next to its own executable, so all three live in libexec and
  # `aitm` + `aitm-tui` are linked onto the PATH.
  depends_on arch: :arm64
  depends_on :macos

  def install
    libexec.install "aitm", "aitm-tui", "obscura"
    bin.install_symlink libexec/"aitm"
    bin.install_symlink libexec/"aitm-tui"
  end

  def caveats
    <<~EOS
      Run the proxy:          aitm            (listens on 127.0.0.1:8080)
      Trust the MITM CA:      aitm ca install
      Web operator UI:        aitm web        (prints the URL + token)
      Terminal UI:            aitm tui        (standalone, against a running proxy: aitm-tui --bus ...)

      The native macOS app is a separate cask:
        brew install --cask mrbrutti/aitmproxy/aitmproxy
    EOS
  end

  test do
    assert_match "web operator UI", shell_output("#{bin}/aitm web --help")
    assert_match "usage: aitm-tui", shell_output("#{bin}/aitm-tui --help 2>&1", 2)
  end
end
