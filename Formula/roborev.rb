class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.72.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.72.0/roborev_0.72.0_darwin_amd64.tar.gz"
      sha256 "57292085903d6b844a97e0f1736ec30d91057a698872f6befa6c3b481664d7ff"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.72.0/roborev_0.72.0_darwin_arm64.tar.gz"
      sha256 "51c831ecd5db79829d0df5df69504dcf11ef15baa867d88520749f266f97fecf"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.72.0/roborev_0.72.0_linux_amd64.tar.gz"
      sha256 "962a2c7eb4c65c262b31d06dd31fa8014af3ca78405180ceb651d64517d5e56e"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.72.0/roborev_0.72.0_linux_arm64.tar.gz"
      sha256 "fdb923d1c83ec3c67a87123aa2ee5d48b864212b8aaf19c8508239fe6825e956"
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
