class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.40.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.40.1/agentsview_0.40.1_darwin_amd64.tar.gz"
      sha256 "f384084a95ff732c6bbde51fd6a0672a933c85a67247a7808bbcee78929781d9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.40.1/agentsview_0.40.1_darwin_arm64.tar.gz"
      sha256 "cd94f117bc55ce6300b3956b3480ad54bba6926cf9ba2eabfe1674fa08935ba1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.40.1/agentsview_0.40.1_linux_amd64.tar.gz"
      sha256 "d9a8dc63e6a3a09da8b0b033ca2088225faa542bd241330fdbcf2cb3826874cf"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.40.1/agentsview_0.40.1_linux_arm64.tar.gz"
      sha256 "31ea689e88422d8b7b096b8a24749d6a9f4cb3374755707f3b37e06e08db78b8"
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
