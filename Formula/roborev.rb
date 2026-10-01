class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.70.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.70.0/roborev_0.70.0_darwin_amd64.tar.gz"
      sha256 "c2f626d6cf72391562ead2af1d553f572ea459abd4a221766fe70e5c2c022412"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.70.0/roborev_0.70.0_darwin_arm64.tar.gz"
      sha256 "95782af5d0dff099426b49ac9c6b664753706184cb75383e913532242ebeec13"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.70.0/roborev_0.70.0_linux_amd64.tar.gz"
      sha256 "7b4e45bbb5c4f3fd736f41c3d25f3d44f6342d88c29b6436abf851ff07b6a1d2"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.70.0/roborev_0.70.0_linux_arm64.tar.gz"
      sha256 "2783d7ac8d1a5705835c3a892d96bfa9fd8855ab10cfc5a1f146f46ca945fdd5"
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
