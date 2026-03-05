class Roborev < Formula
  desc "Automatic code review daemon for git commits using AI agents"
  homepage "https://roborev.io"
  version "0.41.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/roborev-dev/roborev/releases/download/v#{version}/roborev_#{version}_darwin_amd64.tar.gz"
      sha256 "540b6165f0077a0b5c2f4ca6b92a13c7a921f00c73bdf4706b23c38908ec4e1f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/roborev-dev/roborev/releases/download/v#{version}/roborev_#{version}_darwin_arm64.tar.gz"
      sha256 "eb15e8f0f8a7ba855b2bed66b7b841db0535389ded439d14358897f3d4215c81"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/roborev-dev/roborev/releases/download/v#{version}/roborev_#{version}_linux_amd64.tar.gz"
      sha256 "80544147a0e36a10fdbe72b4df39c829f6bcd1ffcd7204a0eb87eed0b252479e"
    end
    if Hardware::CPU.arm?
      url "https://github.com/roborev-dev/roborev/releases/download/v#{version}/roborev_#{version}_linux_arm64.tar.gz"
      sha256 "030e69a8db1a832b50fbc3fe57ee58ef17c7224409e321e8323a2adb0ce3cb84"
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
