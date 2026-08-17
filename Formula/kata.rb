class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.15.0/kata_0.15.0_homebrew_darwin_amd64.tar.gz"
      sha256 "64aec42f3c6f6ca4aca97946a9b83950ed04fb157704ed629883385e8160b08f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.15.0/kata_0.15.0_homebrew_darwin_arm64.tar.gz"
      sha256 "50fce98e7b5e3f6905ec2f619c863dcc7fa906a717b04b942fbde22415a138e0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.15.0/kata_0.15.0_homebrew_linux_amd64.tar.gz"
      sha256 "5d4ff333f1e0208b426da787b5c3b42603f91834468304ab3a2d9d46eb5d0638"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.15.0/kata_0.15.0_homebrew_linux_arm64.tar.gz"
      sha256 "8224660015eef1c4752ebf10183ff335e1b042b8f9dde4b76e0edf86bb461438"
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
