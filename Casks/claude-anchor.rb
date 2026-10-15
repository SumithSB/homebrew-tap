cask "claude-anchor" do
  version "0.4.0"
  sha256 "c5d233e8aea212171cae658894e2300397de1eecafa4fe8d468e464575fe3fed"

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
