cask "clippeek" do
  version "0.2.1"
  sha256 "85ef25cb4617fc90458904c85d591054bfb1a9bd20018b387ab8ff5484be8a9e"

  url "https://github.com/tangheng05/clippeek/releases/download/v#{version}/Clippeek.zip"
  name "clippeek"
  desc "Menu bar app that sends screenshots and screen recordings to your Zipline server"
  homepage "https://github.com/tangheng05/clippeek"

  depends_on macos: :tahoe

  app "Clippeek.app"

  # The app isn't notarized; this skips the "Open Anyway" step.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/Clippeek.app"],
        must_succeed:   false,
        writable_paths: ["Clippeek.app"],
        writable_base:  :appdir
  end

  uninstall quit: "io.github.tangheng05.clippeek"

  zap trash: [
    "~/Library/Application Support/clippeek",
    "~/Library/Preferences/io.github.tangheng05.clippeek.plist",
  ]

  caveats <<~EOS
    Before uninstalling, turn off "Send screenshots" and "Send screen recordings" in clippeek
    so your previous screenshot settings are restored.
  EOS
end
