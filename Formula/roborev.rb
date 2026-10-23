class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.73.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.73.0/roborev_0.73.0_darwin_amd64.tar.gz"
      sha256 "7d2d347502d5d2840db4ba1a93f0ffdcb367a9a4a085b0158363f628dd044f1f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.73.0/roborev_0.73.0_darwin_arm64.tar.gz"
      sha256 "fde3fd42d06c48f3cf4c30653c506077dfae9de56d331b5f89bc9602a26bdcf0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.73.0/roborev_0.73.0_linux_amd64.tar.gz"
      sha256 "904bc7f48e21fc49e2fc28ad2d4d209d5c015fd4c4f299e2dfdba302618bb74a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.73.0/roborev_0.73.0_linux_arm64.tar.gz"
      sha256 "24efcad225b108bfcaab09d53691df7fb0a411f6b8d783e159a04a8eddca6eae"
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
