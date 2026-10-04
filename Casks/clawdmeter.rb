cask "clawdmeter" do
  version "0.4.0"
  sha256 "b283f5af05aaf5bb8a2b2e81c1b9ad2cfa7b82a09ea154abe101fdd9aa9c5eee"

  url "https://github.com/tangheng05/clawdmeter/releases/download/v#{version}/Clawdmeter.zip"
  name "Clawdmeter"
  desc "Menu bar status and usage limits for Claude Code"
  homepage "https://github.com/tangheng05/clawdmeter"

  depends_on macos: ">= :tahoe"

  app "Clawdmeter.app"

  # The app isn't notarized; this skips the "Open Anyway" step.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Clawdmeter.app"]
  end

  uninstall quit: "io.github.tangheng05.clawdmeter"

  # Removes Clawdmeter's hooks and status line from Claude Code before its files go.
  zap script: {
        executable:   "#{Dir.home}/.claude/clawdmeter/bin/clawdmeter",
        args:         ["uninstall"],
        must_succeed: false,
      },
      trash:  "~/Library/Preferences/io.github.tangheng05.clawdmeter.plist"
end
