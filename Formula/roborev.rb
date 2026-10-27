class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.74.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.74.0/roborev_0.74.0_homebrew_darwin_amd64.tar.gz"
      sha256 "274cba24239f15b7e50e89580a1638089a4f5a7a7ff819fd048fa9868ab46433"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.74.0/roborev_0.74.0_homebrew_darwin_arm64.tar.gz"
      sha256 "4e1a3607a5890508815f9aa1959b41912939d0309276cf929f52e0d9222a7d57"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.74.0/roborev_0.74.0_homebrew_linux_amd64.tar.gz"
      sha256 "a7a94f017220ffb3e9ff161bd8dd4e25a0a2e0cca23fbb9831cd5e8644964717"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.74.0/roborev_0.74.0_homebrew_linux_arm64.tar.gz"
      sha256 "43e75b9c43d1f00cf3f6a46ce7937ff5d36aa37e87be50c62b5c3202d645bd14"
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
