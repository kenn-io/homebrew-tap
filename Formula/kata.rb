class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.17.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.17.1/kata_0.17.1_homebrew_darwin_amd64.tar.gz"
      sha256 "0dc5431d01020cf6864460d2d91830af1e9d6416837e1ba6248caeb61ae880fa"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.17.1/kata_0.17.1_homebrew_darwin_arm64.tar.gz"
      sha256 "e0ef9be3ea21ade9e9ba19cb4e365eaa1fdf83bbd990018999e006387e824b30"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.17.1/kata_0.17.1_homebrew_linux_amd64.tar.gz"
      sha256 "e7d9a0e8aade3013b9dcde6ee94ce149d3aa50911100d94c4ae853b4a0b6ccb7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.17.1/kata_0.17.1_homebrew_linux_arm64.tar.gz"
      sha256 "f7f94157d29be650e7da1610de9409639f2fcaeb8ea1893cb859488752abbd07"
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
