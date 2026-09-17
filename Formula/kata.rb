class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.18.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.18.0/kata_0.18.0_homebrew_darwin_amd64.tar.gz"
      sha256 "efc250280bf2109706c587f0715f03f66611e141fbde982093ac5a80ef9ce6ab"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.18.0/kata_0.18.0_homebrew_darwin_arm64.tar.gz"
      sha256 "7b1548991c349d2fd6b29043c79715dc38f9e531ce48b0f8b3b765588f8485ee"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.18.0/kata_0.18.0_homebrew_linux_amd64.tar.gz"
      sha256 "9e012a12201b63a8ea6bb9db6536512538bbb933213996cde631e8c99a0dcbff"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.18.0/kata_0.18.0_homebrew_linux_arm64.tar.gz"
      sha256 "d7275cc45b01d5519b641bc4566717ca0c10bf5e92cc42b4716be87f687236c2"
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
