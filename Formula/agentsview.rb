class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.44.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.44.0/agentsview_0.44.0_darwin_amd64.tar.gz"
      sha256 "95df0f56c039c394601d755301bbf523e56e0a8d2a648287b80cc203897f3fc2"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.44.0/agentsview_0.44.0_darwin_arm64.tar.gz"
      sha256 "b21fdf093e631237e39d33ab80fe50fbc799e0bac11ac8ede8e0dc988ae12303"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.44.0/agentsview_0.44.0_linux_amd64.tar.gz"
      sha256 "037ea7a46d52e06b20363b4aa7cd7f28e32f31d8215803d6e9a0c96bac5818e3"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.44.0/agentsview_0.44.0_linux_arm64.tar.gz"
      sha256 "6f3c76ebe119826a2def1ae226c3573b214d396a3ed7c477ef282b1063345b87"
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
