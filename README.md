# homebrew-aitmproxy

Public Homebrew tap for [aitmproxy](https://github.com/mrbrutti/aitmproxy) — an
intercepting proxy for **authorized** security testing — and its native macOS
operator app. Apple Silicon, macOS 26+. The binaries are hosted on this tap's
own releases; the source repository stays private.

## Install

```bash
brew tap mrbrutti/aitmproxy
brew install mrbrutti/aitmproxy/aitm              # the aitm binary: proxy + CLI + web + tui
brew install --cask mrbrutti/aitmproxy/aitmproxy  # the native macOS app
```

No token needed — the tap and its release assets are public.

## What you get

- **`aitm`** — one binary. `aitm` runs the proxy on `127.0.0.1:8080`; `aitm web`
  adds the web UI; `aitm tui` the terminal UI; `aitm <subcommand>` the CLI. The
  bundled `obscura` browser engine is installed beside it in `libexec`.
- **Aitmproxy.app** — the native SwiftUI operator app (Developer ID signed and
  notarized, so it opens with no Gatekeeper prompt).

## First steps

```bash
aitm ca install     # trust the MITM root CA in your login keychain
aitm                # start the proxy (Ctrl-C to stop)
```

Point a client at `http://127.0.0.1:8080`. Full guide: the `INSTALL.md` attached
to each GitHub Release.

## Releases

Formula and cask versions track the assets on this repo's
[Releases](https://github.com/mrbrutti/homebrew-aitmproxy/releases). After
publishing a new release, bump `version`/`sha256` in `Formula/aitm.rb` and
`Casks/aitmproxy.rb`.
