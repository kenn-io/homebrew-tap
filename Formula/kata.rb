class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.14.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.14.2/kata_0.14.2_homebrew_darwin_amd64.tar.gz"
      sha256 "80f994f25d495cb29b7cbd035001c7bf62b7e1fc55ed36edca8b05f62abbb926"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.14.2/kata_0.14.2_homebrew_darwin_arm64.tar.gz"
      sha256 "1382eff2ac3533f40427109ced903cdfdab77953135e0f868006182f74fc0a12"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.14.2/kata_0.14.2_homebrew_linux_amd64.tar.gz"
      sha256 "a22a54a546a7f33c028ba3b2ab3fcc2b80cc4dd154c1b99ad3eedafa19c3f0c4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.14.2/kata_0.14.2_homebrew_linux_arm64.tar.gz"
      sha256 "3cf243ce275d40a9ef1aa71b2196956ad79cdf238d6be471ffefd9201d97ed79"
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
