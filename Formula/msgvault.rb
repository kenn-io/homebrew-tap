class Msgvault < Formula
  desc "Archive a lifetime of email and chat with offline search and analytics"
  homepage "https://github.com/kenn-io/msgvault"
  version "0.22.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.22.0/msgvault_0.22.0_darwin_amd64.tar.gz"
      sha256 "7d7a47a05b31ba8f580ec9868474129ea4df56bf70577177fcb91f24af4a32b3"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.22.0/msgvault_0.22.0_darwin_arm64.tar.gz"
      sha256 "3f7cb6c1828a785b741e2b229f7d45d4fbbd87fc4f4953032fc77eba7dfdb71f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.22.0/msgvault_0.22.0_linux_amd64.tar.gz"
      sha256 "3b146f1c1e78c626072d1f441ac59e916c96766472fb117d27a7098d822740a1"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.22.0/msgvault_0.22.0_linux_arm64.tar.gz"
      sha256 "905d9a84ca1d7e6c1ec759d9a5f9901ff2b37930e62760a52742d5ced16a06ba"
    end
  end

  def install
    bin.install "msgvault"
  end

  test do
    ENV["MSGVAULT_HOME"] = testpath
    port = free_port
    (testpath/"config.toml").write <<~TOML
      [server]
      api_port = #{port}
    TOML

    system bin/"msgvault", "init-db"
    assert_path_exists testpath/"msgvault.db"
    assert_match "<title>msgvault</title>", shell_output("curl --fail --silent http://127.0.0.1:#{port}/")
    system bin/"msgvault", "build-cache"
    assert_match(/Messages:\s+0/, shell_output("#{bin}/msgvault stats"))
  ensure
    system bin/"msgvault", "daemon", "stop"
  end
end
