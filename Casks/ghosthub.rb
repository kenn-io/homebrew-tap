cask "ghosthub" do
  version "0.11.2"
  sha256 "425894036b2df19eb150e38456f0d645c575130c6ef217916b509e99daeba163"

  url "https://github.com/kenn-io/ghosthub/releases/download/v#{version}/Ghosthub_#{version}_macos_arm64.dmg"
  name "Ghosthub"
  desc "Native terminal for local and remote tmux fleets"
  homepage "https://ghosthub.ai/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Ghosthub.app"

  zap trash: [
    "~/.config/ghosthub",
    "~/.ghosthub",
    "~/Library/Caches/com.ghosthub",
    "~/Library/HTTPStorages/com.ghosthub",
    "~/Library/Preferences/com.ghosthub.plist",
    "~/Library/Saved Application State/com.ghosthub.savedState",
    "~/Library/WebKit/com.ghosthub",
  ]
end
