class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.68.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.1/roborev_0.68.1_darwin_amd64.tar.gz"
      sha256 "6ca9e99d683842008d0609425bc4d513e73336f0cd01ee5130f4a7eac196067d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.1/roborev_0.68.1_darwin_arm64.tar.gz"
      sha256 "2ee405245311f8b5f80e756f4a3fb278b1d320f6f1e1ff29510461e0d7d9bcdc"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.1/roborev_0.68.1_linux_amd64.tar.gz"
      sha256 "4c560a49c3738a59ce4d3ea1f663ca5d6235e8adec43d35f62c1eed60cde331d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.1/roborev_0.68.1_linux_arm64.tar.gz"
      sha256 "751a294d790f581a40fd1b89de0b7147646e2c5b45679c04d225337e06149fdb"
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
