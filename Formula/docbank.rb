class Docbank < Formula
  desc "Store, search, and export documents with version history"
  homepage "https://docbank.ai"
  version "0.15.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.2/docbank_0.15.2_darwin_amd64.tar.gz"
      sha256 "3de0cdf0147f13e9ca303e7fdcaee46b52de948afe82129ffed4a4d1a5a117d7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.2/docbank_0.15.2_darwin_arm64.tar.gz"
      sha256 "0d2f82c1e337bab1086cf52cee367958bdeff488fe7b619f694dda52f989e2b4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.2/docbank_0.15.2_linux_amd64.tar.gz"
      sha256 "73a03e28259ba5709dc2a0c38df0aa801bd3cd4cc41b8e2ff3c72092f978c890"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.2/docbank_0.15.2_linux_arm64.tar.gz"
      sha256 "3db87a5c53ec1cfc0df6f69f2aee6a362c8473c5ecee4925110cbd8be4d71105"
    end
  end

  def install
    bin.install "docbank"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docbank version")
  end
end
