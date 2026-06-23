class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.59.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v#{version}/roborev_#{version}_darwin_amd64.tar.gz"
      sha256 "7b1f2539b8bad0a33f8eaae1ae17382f48db0eaa164a58493e63c4abe69eda59"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v#{version}/roborev_#{version}_darwin_arm64.tar.gz"
      sha256 "49ece748620f2ea52233278bb07205c878b0749193f9b697309d4910848aec31"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v#{version}/roborev_#{version}_linux_amd64.tar.gz"
      sha256 "00fc72c13dcb073c738190e0921e3c555bc48a2662a0d5e62ffa5d9ecb708a93"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v#{version}/roborev_#{version}_linux_arm64.tar.gz"
      sha256 "81391d30f0d4df9348fab36e0c043c0f0b40125ffc037d8b186b9e2895ac2540"
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
