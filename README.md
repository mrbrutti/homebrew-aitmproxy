# homebrew-aitmproxy

Private Homebrew tap for [aitmproxy](https://github.com/mrbrutti/aitmproxy) — an
intercepting proxy for **authorized** security testing — and its native macOS
operator app. Apple Silicon, macOS 26+.

## Install

This is a **private** tap, so Homebrew needs a GitHub token to read it and to
download the release assets. Set one once (a classic PAT with `repo` scope, or a
fine-grained token that can read this repo):

```bash
export HOMEBREW_GITHUB_API_TOKEN=ghp_xxx   # add to ~/.zshrc to persist
```

Then:

```bash
brew tap mrbrutti/aitmproxy
brew install mrbrutti/aitmproxy/aitm            # the aitm binary: proxy + CLI + web + tui
brew install --cask mrbrutti/aitmproxy/aitmproxy  # the native macOS app
```

`brew` clones the tap over your `gh`/git credentials; the token above is what
lets it fetch the release `.tar.gz` / `.dmg` from this private repo.

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
