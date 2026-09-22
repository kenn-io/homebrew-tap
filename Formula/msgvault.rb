class Msgvault < Formula
  desc "Archive a lifetime of email and chat with offline search and analytics"
  homepage "https://github.com/kenn-io/msgvault"
  version "0.20.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.20.0/msgvault_0.20.0_darwin_amd64.tar.gz"
      sha256 "2f0527f00be70f009d44e458cd322b3586f0649a47b5f81f3be9681ebeab3e14"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.20.0/msgvault_0.20.0_darwin_arm64.tar.gz"
      sha256 "427021a214475ba13997bf22dca0c5c99a9cc3a6fb5fcc158494c2d41315d5e1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.20.0/msgvault_0.20.0_linux_amd64.tar.gz"
      sha256 "6b99f03f41fe0b375f19b2f9202b35d72a11b30da1a51f50c48503b299305e0c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.20.0/msgvault_0.20.0_linux_arm64.tar.gz"
      sha256 "ef5ef302c480372749da971f712a076fe9813aef912d708bd00a15a988308c7c"
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
