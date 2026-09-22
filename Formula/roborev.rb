class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.68.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.2/roborev_0.68.2_darwin_amd64.tar.gz"
      sha256 "a2fba662db2b64f5929d6f1202e8065fa43cf636b79ceea30b9b49eb7ea33be2"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.2/roborev_0.68.2_darwin_arm64.tar.gz"
      sha256 "0fba1bb3db34732877a6393bcc5bbe66b2e16dbff36103342670f05f142b1f2b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.2/roborev_0.68.2_linux_amd64.tar.gz"
      sha256 "b0f123838e3ac441dcd9091a3fc8dbd849c10d81f9917e499999b55e53af3da0"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.2/roborev_0.68.2_linux_arm64.tar.gz"
      sha256 "16de8782c815d2b248c064233ea6bd9264cab9df793d8833b1a0acccdc8f246f"
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
