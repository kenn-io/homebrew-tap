class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.47.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.47.0/agentsview_0.47.0_homebrew_darwin_amd64.tar.gz"
      sha256 "0d41260cf741686986c1217a7f44e9ccc6c7f991fb79265e645197c44b1f90d1"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.47.0/agentsview_0.47.0_homebrew_darwin_arm64.tar.gz"
      sha256 "b5405748d6c36281ab0e903b35b51dfc3f004f40bbab381b578d3821271105a6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.47.0/agentsview_0.47.0_homebrew_linux_amd64.tar.gz"
      sha256 "3929c46105aa0633bbe41a60b0c16a52d7cb3612457b6bbc09a202605e5a0b15"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.47.0/agentsview_0.47.0_homebrew_linux_arm64.tar.gz"
      sha256 "870dace87a275a9d0f2a9bb873853e74ab2dd3670a152b05827338a7e57486b1"
    end
  end

  def install
    bin.install "agentsview"
  end

  def caveats
    <<~EOS
      To start the local web UI:
        agentsview serve

      To print token usage summaries:
        agentsview usage daily
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentsview version")
  end
end
