class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.17.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.17.2/kata_0.17.2_homebrew_darwin_amd64.tar.gz"
      sha256 "79f21c886af32c3aa7af006100bcdd26be5df3d07137ef0c99ad65e442d1d3b6"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.17.2/kata_0.17.2_homebrew_darwin_arm64.tar.gz"
      sha256 "c4044595dbe39676dd44c4cfdeacbe10b1a85adef441f9953321816960ff0d93"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.17.2/kata_0.17.2_homebrew_linux_amd64.tar.gz"
      sha256 "ea18c07f853a76cde21f972e4da2580cc66d09f7129fc73f0032d83be6eb248f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.17.2/kata_0.17.2_homebrew_linux_arm64.tar.gz"
      sha256 "46f9c9adc1b4b244eb96b4e54c7f91016eb4ec01a3336f1151f5dd566e1078e6"
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
