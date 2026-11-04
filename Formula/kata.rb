class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.21.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.21.0/kata_0.21.0_homebrew_darwin_amd64.tar.gz"
      sha256 "5dcd06cea0373f21f71429a76a21cbf4d7512f8cfe4b456931b8c501ffcc324d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.21.0/kata_0.21.0_homebrew_darwin_arm64.tar.gz"
      sha256 "997d47c06bf592cf5a754dc55714435886893707c29b38e330989b15997f9cc1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.21.0/kata_0.21.0_homebrew_linux_amd64.tar.gz"
      sha256 "03bc541359343c0cc6152ddfaaa5ad4a98bf235fa39a18b256e19324fe91f6b8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.21.0/kata_0.21.0_homebrew_linux_arm64.tar.gz"
      sha256 "68578ce03495fd8d9e221d47708c067c29917a96d8f388fd785918aaeea3a870"
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
