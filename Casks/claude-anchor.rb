cask "claude-anchor" do
  version "0.3.2"
  sha256 "6588ce5f0052fb07b6d0f09d87b4e70b39608cf3612f903c1c24f18e725f22f8"

  url "https://github.com/SumithSB/claude-anchor/releases/download/v#{version}/ClaudeAnchor-#{version}.zip"
  name "Claude Anchor"
  desc "Routes Claude Code to the right account per folder, with limits and usage"
  homepage "https://github.com/SumithSB/claude-anchor"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Claude Anchor.app"

  # The app is ad-hoc signed, not notarized; clearing quarantine lets it open without a Gatekeeper block.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Claude Anchor.app"]
  end

  uninstall quit: "com.sumithsb.claude-anchor"

  zap trash: "~/.claude-anchor"

  caveats <<~EOS
    To route `claude` in the terminal, add this line to ~/.zshrc:
      source ~/.claude-anchor/anchor.zsh
    (The file is created the first time Claude Anchor opens.)

    `brew upgrade` quits Claude Anchor; open it again from Applications afterwards.

    `brew uninstall --zap` also deletes ~/.claude-anchor, including extra accounts' history.
  EOS
end
