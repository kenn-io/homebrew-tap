class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.75.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.75.0/roborev_0.75.0_homebrew_darwin_amd64.tar.gz"
      sha256 "c6da28f2a1f7d8047080635ed204ddff9a9d1160702ed80b59a0c5f280c14204"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.75.0/roborev_0.75.0_homebrew_darwin_arm64.tar.gz"
      sha256 "d2490c766c0100fd678bde0f61afd82ffceeb9bd1a4a8bee4f2d972d224ea0eb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.75.0/roborev_0.75.0_homebrew_linux_amd64.tar.gz"
      sha256 "5944356799577a1a4e95c6a0b9fc73a06c04b72964037381d99d18cad04df02a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.75.0/roborev_0.75.0_homebrew_linux_arm64.tar.gz"
      sha256 "12dc2113e196f3ed62060be05b3f3814938aeaf17b7442be7b233e96a042866e"
    end
  end

  def install
    bin.install "roborev"
  end

  def caveats
    <<~EOS
      To initialize roborev in a git repository:
        cd your-repo
        roborev init

      The daemon starts automatically when needed.
      For more info: https://roborev.io/quickstart/
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/roborev version")
  end
end
