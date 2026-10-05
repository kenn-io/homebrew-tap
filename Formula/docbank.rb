class Docbank < Formula
  desc "Store, search, and export documents with version history"
  homepage "https://docbank.ai"
  version "0.15.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.0/docbank_0.15.0_darwin_amd64.tar.gz"
      sha256 "3141817d4cb7dd3b9a7336a3bef9d24c263a1a4492312a60603b843b02df4d9c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.0/docbank_0.15.0_darwin_arm64.tar.gz"
      sha256 "174fda3400f1142e24ad1cd6418f0ecb3be3611c85e720b3603b5cf655c3b13c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.0/docbank_0.15.0_linux_amd64.tar.gz"
      sha256 "ed7aea113caa086d122888901923be8ede0f51f148696bb6b3100a2e44e8ea44"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.15.0/docbank_0.15.0_linux_arm64.tar.gz"
      sha256 "d4ff824056e18239add5c8e6ead57b6b04a0c3d7834b7590e2fb8dbc342e199e"
    end
  end

  def install
    bin.install "docbank"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docbank version")
  end
end
