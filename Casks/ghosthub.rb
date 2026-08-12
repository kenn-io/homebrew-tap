cask "ghosthub" do
  version "0.8.2"
  sha256 "16897525303cd9e5c4e1a4849feb7fc82bc75fc898e2a31e486496c1236b4628"

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
