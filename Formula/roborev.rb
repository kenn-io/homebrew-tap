class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.64.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v#{version}/roborev_#{version}_darwin_amd64.tar.gz"
      sha256 "49bdcab049984220cebea98d3ade43c9bc7f79ab7aa7d5417a2d2f6995f72717"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v#{version}/roborev_#{version}_darwin_arm64.tar.gz"
      sha256 "d95b34df5fd7c1b82ef55176a549f75ad2394f6d02272d42f47fddca2ba5ff19"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/roborev/releases/download/v#{version}/roborev_#{version}_linux_amd64.tar.gz"
      sha256 "e97ea2b8fd9dfd7a580f731ca847aa170a5fa95387727b7ad2d6875b73b902e7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/roborev/releases/download/v#{version}/roborev_#{version}_linux_arm64.tar.gz"
      sha256 "429a986d1140d49106803e95d11646e9b32efc053ee58b65baf30e1e0a0f472d"
    end
  end

  def install
    bin.install "roborev"
  end

  def caveats
    <<~EOS
      To initialize roborev in a git repository:
        cd your-repo
        roborev init

      The daemon starts automatically when needed.
      For more info: https://roborev.io/quickstart/
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/roborev version")
  end
end
