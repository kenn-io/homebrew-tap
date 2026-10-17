class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.19.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.19.0/kata_0.19.0_homebrew_darwin_amd64.tar.gz"
      sha256 "81fd3cb241391fb78c76fb87d5b7d13230e34e7678cad62655ca8d509cb3845c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.19.0/kata_0.19.0_homebrew_darwin_arm64.tar.gz"
      sha256 "babdd5e8f9c449b026a97d9c98bea318d413371cc371fd1a792b1340eff77f44"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.19.0/kata_0.19.0_homebrew_linux_amd64.tar.gz"
      sha256 "28da39a7b16b126c56345ddf9b49520a8c90c1eb12d73373cdf3de05621e8bfc"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.19.0/kata_0.19.0_homebrew_linux_arm64.tar.gz"
      sha256 "a59db6ef47e08d705e1d93de83d93304f221e496acd52b4cfdb556c34f224ef4"
    end
  end

  def install
    bin.install "kata"
  end

  test do
    info = shell_output("#{bin}/kata version --json")
    assert_match %Q("version":"v#{version}"), info
    assert_match '"distribution":"homebrew"', info
    system bin/"kata", "_web-assets-check"
    assert_match "brew upgrade kata", shell_output("#{bin}/kata update --yes 2>&1", 2)
  end
end
