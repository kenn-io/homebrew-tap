class Kata < Formula
  desc "Git-native issue tracking for agentic development"
  homepage "https://katatracker.com"
  version "0.22.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.22.0/kata_0.22.0_homebrew_darwin_amd64.tar.gz"
      sha256 "1515cb104e1c5f6f534f75410caa755c24a1df2d1460a7c4d147d48357cfec5a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.22.0/kata_0.22.0_homebrew_darwin_arm64.tar.gz"
      sha256 "c0795825069774983a0be2c76de2b3258103eda1392ec0a141cf88b5a0c5e0de"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kata/releases/download/v0.22.0/kata_0.22.0_homebrew_linux_amd64.tar.gz"
      sha256 "8f1ec53699781186a4730c570ed22e055a22045c0fc6f57386d706e7e4d591af"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kata/releases/download/v0.22.0/kata_0.22.0_homebrew_linux_arm64.tar.gz"
      sha256 "befcd703574e0cae83682714cd5ab793bba443ae55bfd147d71990b670e8849b"
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
