class Aitm < Formula
  desc "Intercepting proxy for authorized security testing (proxy, CLI, web, TUI)"
  homepage "https://github.com/mrbrutti/aitmproxy"
  version "0.1.0"
  url "https://github.com/mrbrutti/homebrew-aitmproxy/releases/download/v0.1.0/aitm-0.1.0-aarch64-apple-darwin.tar.gz"
  sha256 "469dfcc9a57ccca5787193df71b26b5781622eae80102363119a9ce385e679f0"
  license any_of: ["MIT", "Apache-2.0"]

  # Prebuilt Apple Silicon binary bundle: `aitm` plus the `obscura` browser
  # engine it drives. `aitm` finds `obscura` next to its own executable, so both
  # live in libexec and only `aitm` is linked onto the PATH.
  depends_on arch: :arm64
  depends_on :macos

  def install
    libexec.install "aitm", "obscura"
    bin.install_symlink libexec/"aitm"
  end

  def caveats
    <<~EOS
      Run the proxy:          aitm            (listens on 127.0.0.1:8080)
      Trust the MITM CA:      aitm ca install
      Web operator UI:        aitm web        (prints the URL + token)
      Terminal UI:            aitm tui

      The native macOS app is a separate cask:
        brew install --cask mrbrutti/aitmproxy/aitmproxy
    EOS
  end

  test do
    assert_match "web operator UI", shell_output("#{bin}/aitm web --help")
  end
end
