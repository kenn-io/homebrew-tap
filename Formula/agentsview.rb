class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.41.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_darwin_amd64.tar.gz"
      sha256 "67458c9f7e4bfb55e279f879c91b27746d47a2f6f06854cc9866adfba6ded312"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_darwin_arm64.tar.gz"
      sha256 "cc955d13033a6aaf8d317913e6130b8f203fa925c44c2646cf91f60ed4d480d3"
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
