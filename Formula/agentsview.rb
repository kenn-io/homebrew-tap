class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.43.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.43.0/agentsview_0.43.0_darwin_amd64.tar.gz"
      sha256 "79d8ad3e06d04d6e847b0d9e53dd8ec85724c92f7ae3a5bbc6c51031195d876b"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.43.0/agentsview_0.43.0_darwin_arm64.tar.gz"
      sha256 "9c9c3ee0bad04f884b07816f23a7c58923ba5bd5a9a1057fa048198a53a4a37c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.43.0/agentsview_0.43.0_linux_amd64.tar.gz"
      sha256 "4520c6698772d2db7220212abf58d7d58c0966d7435f0a5ab134371f874df6d9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.43.0/agentsview_0.43.0_linux_arm64.tar.gz"
      sha256 "3c4141bc1356058246336ea8b49a2c846f3050e9a199aa8f732c8815c2dd4e50"
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
