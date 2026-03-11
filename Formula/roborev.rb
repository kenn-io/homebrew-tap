class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.46.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/roborev-dev/roborev/releases/download/v#{version}/roborev_#{version}_darwin_amd64.tar.gz"
      sha256 "8f880132e8b3bbbfd977afb781ad9daadd4fe5d383a7204c8477e75048aa6603"
    end
    if Hardware::CPU.arm?
      url "https://github.com/roborev-dev/roborev/releases/download/v#{version}/roborev_#{version}_darwin_arm64.tar.gz"
      sha256 "543fb8010040223914d1a07b0504c9b795e31c255cb695f7f3b646b1c249a038"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/roborev-dev/roborev/releases/download/v#{version}/roborev_#{version}_linux_amd64.tar.gz"
      sha256 "a3d4aacaa402784489a521cd4883a5ac6d2ac5db2d38c21ad7630c9fdc92b24c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/roborev-dev/roborev/releases/download/v#{version}/roborev_#{version}_linux_arm64.tar.gz"
      sha256 "0035459b2195f6166ff4e878e45e5a2104457790555e94007c15059db58efa3e"
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
