class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.69.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.69.0/roborev_0.69.0_darwin_amd64.tar.gz"
      sha256 "d517f007821f89f7204d643a8b424a998d9fe7e3185872fc3a1cb5c57aaf6461"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.69.0/roborev_0.69.0_darwin_arm64.tar.gz"
      sha256 "2ae7d00a6e3da7d8c115028d31d176c010b36ec59b9996caac1d6d094b7dddb6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.69.0/roborev_0.69.0_linux_amd64.tar.gz"
      sha256 "e7f58c97371fde2d64dae070cd66992451b907d24f8f6796f8f92603ae366847"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.69.0/roborev_0.69.0_linux_arm64.tar.gz"
      sha256 "da07503000e648063fbb0b818f99cc0e4085c425a33ba3eef16684aa36da8191"
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
