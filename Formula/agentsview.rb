class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.41.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_darwin_amd64.tar.gz"
      sha256 "6be525e84abfd0cb26d679862d9ff4190dffc222e439c1a207c291d7ddf77493"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_darwin_arm64.tar.gz"
      sha256 "1f9bf7459c52e85e3049f705db10eb3c64b4d641295de7287e853dbc2ed4c63f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_linux_amd64.tar.gz"
      sha256 "0c326ca59cc4efa66676064288639bd1d93f6913d948fde42b51f0dc8e77bdd4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_linux_arm64.tar.gz"
      sha256 "8826c77f94197dfb995214f7b91ea9e60aa05cf42ca4a2e0594211a801ecf560"
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
