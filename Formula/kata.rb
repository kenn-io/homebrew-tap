class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.24.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.24.0/kata_0.24.0_homebrew_darwin_amd64.tar.gz"
      sha256 "7e0a6f00102810c03b6fd75d7f037d6c109229c4752fd01e651c97b3e7978b8c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.24.0/kata_0.24.0_homebrew_darwin_arm64.tar.gz"
      sha256 "807ea9624e3e242bade56810754233b249d615e10f139980d62c70c1bcd38284"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.24.0/kata_0.24.0_homebrew_linux_amd64.tar.gz"
      sha256 "7ff3b706f99b999d190349ce4d947e5c1bcf9880b9e91778530d677705680571"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.24.0/kata_0.24.0_homebrew_linux_arm64.tar.gz"
      sha256 "d06270803e6431c7d32d20ca3cea80d617f639422e2b094b3d0bb1172cb78e30"
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
