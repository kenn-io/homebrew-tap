class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.66.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.66.0/roborev_0.66.0_darwin_amd64.tar.gz"
      sha256 "a6ac8900c5b7b3948913103edfaec317c9545048f3ba7614f54a4be0181f95a2"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.66.0/roborev_0.66.0_darwin_arm64.tar.gz"
      sha256 "f64a76715dd51179e1a4a95f011efdb20106b6826934b93f33dc1a26edf8354b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v0.66.0/roborev_0.66.0_linux_amd64.tar.gz"
      sha256 "3a57bda163559cf9b9062a3808c0979c4b46853ff712681d2160d676e2ea098a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v0.66.0/roborev_0.66.0_linux_arm64.tar.gz"
      sha256 "371accc17a7afa1e38f10ac7e2e0540681cdcd5d73bdfb670e51cc24d225862f"
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
