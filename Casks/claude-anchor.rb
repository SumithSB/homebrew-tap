cask "claude-anchor" do
  version "0.6.0"
  sha256 "43525f4de9f5b9e55007637b46d9c9ae05db46ec6858907ad7238f14a23eb47d"

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
