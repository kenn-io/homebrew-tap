class Docbank < Formula
  desc "Store, search, and export documents with version history"
  homepage "https://docbank.ai"
  version "0.18.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.18.0/docbank_0.18.0_homebrew_darwin_amd64.tar.gz"
      sha256 "2f02764e819ffc16dc2be2910e585e2fc30e3c156a8d7c732c40c0bb31c21f61"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.18.0/docbank_0.18.0_homebrew_darwin_arm64.tar.gz"
      sha256 "b28dc918d288a2b6dbcceee302f58db4d85f3e821be45a43821daac173007abd"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.18.0/docbank_0.18.0_homebrew_linux_amd64.tar.gz"
      sha256 "b3d1784fa4163492fe5f2407095a91b612638908cc3ffca40e04b58150524b03"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.18.0/docbank_0.18.0_homebrew_linux_arm64.tar.gz"
      sha256 "8dcfcd0eb9dc4b95c3c2861359e0ab54fcd7f6be32b7402285ca2a95dc15bc3b"
    end
  end

  def install
    bin.install "docbank"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docbank version")
  end
end
