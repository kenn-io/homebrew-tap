class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.46.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.46.0/agentsview_0.46.0_darwin_amd64.tar.gz"
      sha256 "bcbba1d3c92e9a4f25aac7fca8106e1cbc1f906f0668dda85bcc06d6112d0729"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.46.0/agentsview_0.46.0_darwin_arm64.tar.gz"
      sha256 "c345ac075fb61460104d72a2863515fc22f72227b85de0cd5b9d8404ca0d9881"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.46.0/agentsview_0.46.0_linux_amd64.tar.gz"
      sha256 "de36b670a1bf3fb4e0d7cc620370b70fea648db47322a61163e40aed5c3974c4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v0.46.0/agentsview_0.46.0_linux_arm64.tar.gz"
      sha256 "6839a02672b53c1b007dbaf78b7d36cef7e648d8c0d6911d007414e4c071156f"
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
