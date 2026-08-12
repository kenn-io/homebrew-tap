cask "ghosthub" do
  version "0.8.1"
  sha256 "efd3dc619162b694819262b0154f8b4869c53ed1940f915896f1cf9552ca8dbf"

  url "https://github.com/kenn-io/ghosthub/releases/download/v#{version}/Ghosthub_#{version}_macos_arm64.dmg",
      verified: "github.com/kenn-io/ghosthub/"
  name "Ghosthub"
  desc "Native terminal for local and remote tmux fleets"
  homepage "https://ghosthub.ai/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

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
