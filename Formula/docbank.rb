class Docbank < Formula
  desc "Store, search, and export documents with version history"
  homepage "https://docbank.ai"
  version "0.17.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.17.0/docbank_0.17.0_homebrew_darwin_amd64.tar.gz"
      sha256 "99bbaadbdef1e2e203733fc9d4d9585542cb1962e604960842a5c8cab4bd69b7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.17.0/docbank_0.17.0_homebrew_darwin_arm64.tar.gz"
      sha256 "1fe5259194bd1eb5f641bc4a2c6fe0b9081b9b3d5b018655981137d4f0963df6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/docbank/releases/download/v0.17.0/docbank_0.17.0_homebrew_linux_amd64.tar.gz"
      sha256 "0a725ec28221732ae1e1b96449d5a4061d680730657dd8bb1b6d3814c8b12c13"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/docbank/releases/download/v0.17.0/docbank_0.17.0_homebrew_linux_arm64.tar.gz"
      sha256 "156af963345b0685a39500e47e4fe07aaadb85c7d1f48f79c5b40649540585d4"
    end
  end

  def install
    bin.install "docbank"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docbank version")
  end
end
