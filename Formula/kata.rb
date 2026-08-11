class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.14.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.14.3/kata_0.14.3_homebrew_darwin_amd64.tar.gz"
      sha256 "6ed2e839ba3aafb08ca32ca314432d55a73907e39e620f359b03f923fe799e62"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.14.3/kata_0.14.3_homebrew_darwin_arm64.tar.gz"
      sha256 "746bc5f6483efea5944b18c92c7262f4868ae58ec2d94b9471c2441b92fa145a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.14.3/kata_0.14.3_homebrew_linux_amd64.tar.gz"
      sha256 "b6863cd24b91815794f50a3aeb7829f0cf18aa69589a05500f584172c5ea6bb6"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.14.3/kata_0.14.3_homebrew_linux_arm64.tar.gz"
      sha256 "ee120fc3cbcea9941d39d06236ab60d309c7ed696ed8bfdac919eb8ed2e06a3c"
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
