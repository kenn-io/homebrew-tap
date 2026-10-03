class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.71.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.71.0/roborev_0.71.0_darwin_amd64.tar.gz"
      sha256 "5d250de694faf8239b6b04f330db82422d4120fb5821c9323111f18b0d8476cc"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.71.0/roborev_0.71.0_darwin_arm64.tar.gz"
      sha256 "3e0c9f753dc8e3717f21fcd971a8b50eaa998040ff6b0e88328b88a835a8d10a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.71.0/roborev_0.71.0_linux_amd64.tar.gz"
      sha256 "7758f5bc5b7551c16ea823b5a71711f8593503275df714f82e1e111c3eea52da"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.71.0/roborev_0.71.0_linux_arm64.tar.gz"
      sha256 "e793e931076defa17adcea6345cb434caf7281395e6e777bc13aceec26f5ce98"
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
