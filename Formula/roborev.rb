class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.65.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.65.0/roborev_0.65.0_darwin_amd64.tar.gz"
      sha256 "2435ac0cb5a00930d009a2162bc112106993d4e48fa3ed3b58c9bc7a454ce539"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.65.0/roborev_0.65.0_darwin_arm64.tar.gz"
      sha256 "b063326bdd341237e9df8215f54338ed5d8cdf151fe11ca4b955817f87dc5a8c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.65.0/roborev_0.65.0_linux_amd64.tar.gz"
      sha256 "b6b49fdd255d3e5bdaa09c73143f9547c3decc75ba75e09ec2a7dc82f9da935e"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.65.0/roborev_0.65.0_linux_arm64.tar.gz"
      sha256 "6a73d4bd275b81d6ba6fa033a8a1aa3569d5ef25622c2f0f7450505e618b743a"
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
