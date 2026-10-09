class Docbank < Formula
  desc "Store, search, and export documents with version history"
  homepage "https://docbank.ai"
  version "0.15.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.1/docbank_0.15.1_darwin_amd64.tar.gz"
      sha256 "e38249c0518035c6e96ca3300fb386f88094940751ad320f2cee1274ce27e4f4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.1/docbank_0.15.1_darwin_arm64.tar.gz"
      sha256 "5b6974095eab0225a2549a744f0193f96441ebfcbeaf47b0800bd897af847f76"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.1/docbank_0.15.1_linux_amd64.tar.gz"
      sha256 "04db9e1101bdc9a983ed8a74d88c8d6b2d17a204c280a8cc9d279a6f3a75d990"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.1/docbank_0.15.1_linux_arm64.tar.gz"
      sha256 "a50f1655a81e9da7a0403d2922b1254b277ecef900132c5801d1336a60405f7f"
    end
  end

  def install
    bin.install "docbank"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docbank version")
  end
end
