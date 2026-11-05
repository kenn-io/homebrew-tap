class Docbank < Formula
  desc "Store, search, and export documents with version history"
  homepage "https://docbank.ai"
  version "0.16.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/archive/refs/tags/v0.17.0.tar.gz"
      sha256 "b3b21950e5d2ae11e2d0dad8e5aaff94a20b7e4b5c16aa8746b71e2616594674"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.16.0/docbank_0.16.0_darwin_arm64.tar.gz"
      sha256 "1a6690265a78660830ea5c46b9b854db09e01bb10bb1094cb79b86f4044c3b9b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.16.0/docbank_0.16.0_linux_amd64.tar.gz"
      sha256 "b9f9ba7ac4a713e677d2d0ebc5d024b2a3d1bf53dc0894d576545c287ac52989"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.16.0/docbank_0.16.0_linux_arm64.tar.gz"
      sha256 "dab1c2aceb766215c329a728c35c4507267f67756e8e55b33f033d76f00732f6"
    end
  end

  def install
    bin.install "docbank"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docbank version")
  end
end
