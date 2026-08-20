class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.15.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.15.1/kata_0.15.1_homebrew_darwin_amd64.tar.gz"
      sha256 "988fd3414d55f1daaf416831182e1f702943d974b93170e59da1fdf92677d788"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.15.1/kata_0.15.1_homebrew_darwin_arm64.tar.gz"
      sha256 "53cf2dd59b6b7ee920c864483329a933311beb8479266123bc76b5a1d858d086"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.15.1/kata_0.15.1_homebrew_linux_amd64.tar.gz"
      sha256 "9e4201385f01feaa180ae7cf428e3d1c3aca3dbc44f1da2f131564cbfbf37626"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.15.1/kata_0.15.1_homebrew_linux_arm64.tar.gz"
      sha256 "c3b93bbac4c0f9d12bb03c12fc1bc3726e5335e914ce9a9d08737de593879d22"
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
