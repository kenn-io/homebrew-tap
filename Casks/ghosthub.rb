cask "ghosthub" do
  version "0.10.1"
  sha256 "13a31db39f96b586f8cba26d3f1b0326f42e4b00431e8b7bac33344356f6fce9"

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
