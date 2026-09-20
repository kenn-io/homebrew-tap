class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.68.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.0/roborev_0.68.0_darwin_amd64.tar.gz"
      sha256 "496b4f95354f1d1b1c985211acc514f88f39cfe754f207c976d630767202b133"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.0/roborev_0.68.0_darwin_arm64.tar.gz"
      sha256 "a91e7506b6211715ad90fd7a18a19fe33ef79342c725497a66fd7d606f892e8c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.0/roborev_0.68.0_linux_amd64.tar.gz"
      sha256 "36e80051e5e12620034a32aca9f67d09e2d68470ce291326515c94bfab5f0216"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.68.0/roborev_0.68.0_linux_arm64.tar.gz"
      sha256 "9ae3c3bb8b454406908bef9c6f37c1dda6ffb01e3c6e1d2804430b078cafd5cd"
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
