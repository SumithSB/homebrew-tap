cask "claude-anchor" do
  version "0.2.1"
  sha256 "bd059794168773361aedb8cafb8ffaeb4606d5ddb9ddd354c7952b065910e62f"

  url "https://github.com/SumithSB/claude-anchor/releases/download/v#{version}/ClaudeAnchor-#{version}.zip"
  name "Claude Anchor"
  desc "Menu bar switcher for Claude Code accounts"
  homepage "https://github.com/SumithSB/claude-anchor"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Claude Anchor.app"

  # The app is ad-hoc signed, not notarized; this lets it open without a Gatekeeper block.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Claude Anchor.app"]
  end

  uninstall quit: "com.sumithsb.claude-anchor"

  zap trash: "~/.claude-anchor"

  caveats <<~EOS
    To route `claude` in the terminal, add this line to ~/.zshrc:
      source ~/.claude-anchor/anchor.zsh
    (The file is created the first time Claude Anchor opens.)

    `brew uninstall --zap` also deletes ~/.claude-anchor, including extra accounts' history.
  EOS
end
