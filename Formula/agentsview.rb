class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.41.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.0/agentsview_0.41.0_darwin_amd64.tar.gz"
      sha256 "e44431835d92fcbbb4d60709735b35bc936b4623810e6d9861c486c342166056"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.0/agentsview_0.41.0_darwin_arm64.tar.gz"
      sha256 "22fd5d84b9b1ca32ab4d7d4e00eb9e56e9a7daf15a469ec4c07fe74b3ef826a7"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.0/agentsview_0.41.0_linux_amd64.tar.gz"
      sha256 "165b0fba91fa31fcff182c190ce7250d11c782d99d129afa22fbf7859bdfa983"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.0/agentsview_0.41.0_linux_arm64.tar.gz"
      sha256 "bca6692c61b4d526ae2d2b4c2e112271754e36b072bdfeb1adbde50d7cf4ea1d"
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
