class Agentsview < Formula
  desc "Local web viewer and analytics for AI coding agent sessions"
  homepage "https://agentsview.io"
  version "0.31.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v#{version}/agentsview_#{version}_darwin_amd64.tar.gz"
      sha256 "9d8d5ec095066c62d632532385cd03f706fe21c8a574ed99dd401b5a81fe33e9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v#{version}/agentsview_#{version}_darwin_arm64.tar.gz"
      sha256 "b6a23b955cc558b2a5d3404ab5b3657eb2d57a7f530a5e40a444f5d05aaecc6c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/agentsview/releases/download/v#{version}/agentsview_#{version}_linux_amd64.tar.gz"
      sha256 "da83efdef23818ddc52bc4e4ceeb4867214252eb1dd9c002bcce065c68b52bde"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/agentsview/releases/download/v#{version}/agentsview_#{version}_linux_arm64.tar.gz"
      sha256 "347db1791f3b692c4c7740bfc71a9860c3013cec2181607d077373047154ec02"
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
