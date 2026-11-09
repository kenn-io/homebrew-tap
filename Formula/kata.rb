class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.23.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.23.0/kata_0.23.0_homebrew_darwin_amd64.tar.gz"
      sha256 "851ab51f6718005846bf6c5c72c00359f0b09c785d6d71dfd9c7136247654ea9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.23.0/kata_0.23.0_homebrew_darwin_arm64.tar.gz"
      sha256 "0ead7712f8827c9cc6bd9e0d59228426db12031d6059168694c9ffaf17174916"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.23.0/kata_0.23.0_homebrew_linux_amd64.tar.gz"
      sha256 "4cd1632a97ebc8af4a0c90269a5e2428c15bb6d721b61f15f888a2068bb3ab31"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.23.0/kata_0.23.0_homebrew_linux_arm64.tar.gz"
      sha256 "1266a3773f11e81b4121c9cf6874e0f82ae72f4c1123640b0ba670ba9acb769c"
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
