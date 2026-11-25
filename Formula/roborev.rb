class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.76.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.76.0/roborev_0.76.0_homebrew_darwin_amd64.tar.gz"
      sha256 "1f0cdcbdbcf872055588a9f58093b804afb2f9c378117f94df9b5bf263d41af6"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.76.0/roborev_0.76.0_homebrew_darwin_arm64.tar.gz"
      sha256 "751eaa5016a55e19a6081e1066c4ae627c5f20b376bd6a9594636723819ffa2a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.76.0/roborev_0.76.0_homebrew_linux_amd64.tar.gz"
      sha256 "376d66f2c964139809a95e60d2f3e66e04c7cb95c8dcc56286bb952785f49c03"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.76.0/roborev_0.76.0_homebrew_linux_arm64.tar.gz"
      sha256 "7e2237ebff8dfae7d7c9df51e3d62acb4b53f2015daf46c9e9305e692ca6bf41"
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
