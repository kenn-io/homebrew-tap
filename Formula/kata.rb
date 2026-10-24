class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.20.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.20.0/kata_0.20.0_homebrew_darwin_amd64.tar.gz"
      sha256 "95fcdd6f0dc600123481b9d83c5ecc6074ddfa1ba723853509c165e07c1ef3a0"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.20.0/kata_0.20.0_homebrew_darwin_arm64.tar.gz"
      sha256 "d3185037fb4a04fc13a765a8952a08a9c9d444f084592ed1648c6d8c6b5dcd76"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.20.0/kata_0.20.0_homebrew_linux_amd64.tar.gz"
      sha256 "b35781751cf36a1963be577c92b8f71a13b2a5ec934ded620e1b10e6a685ac6c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.20.0/kata_0.20.0_homebrew_linux_arm64.tar.gz"
      sha256 "de69dee8b87a3de7edf23dd6ba47adba347081c61c037320e09ed5aa83c17aa7"
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
