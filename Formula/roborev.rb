class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.65.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.65.0/roborev_0.65.0_darwin_amd64.tar.gz"
      sha256 "bb04a363cbc9dac1d9967efe61fbe2da7f57c9fb2ecd3eee9ced60862330789f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.65.0/roborev_0.65.0_darwin_arm64.tar.gz"
      sha256 "fd41e0a2551374e2bbafed0d4827a11a20e14f2f125af2b9d8b44a5211e20ae0"
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
