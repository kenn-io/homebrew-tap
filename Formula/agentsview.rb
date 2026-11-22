class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.48.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.48.0/agentsview_0.48.0_homebrew_darwin_amd64.tar.gz"
      sha256 "8a080157c58a2318df18912d3cf54c49fed08dfa0b70e2a0370c28d69f7808f4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.48.0/agentsview_0.48.0_homebrew_darwin_arm64.tar.gz"
      sha256 "f2dfce1e9977685db4cd4da5cdfcf1467153f86db6e350fd0e5cef7e946e43ec"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.48.0/agentsview_0.48.0_homebrew_linux_amd64.tar.gz"
      sha256 "2485726eebcf4ebd9e1931bb38f6dee5fb21f2a2820698f33b35bc401078e1e9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.48.0/agentsview_0.48.0_homebrew_linux_arm64.tar.gz"
      sha256 "914434fa635715e58aa83bb5a8c0925ece156cced8c2eefc0d93ffb6948e6454"
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
