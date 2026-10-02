class Msgvault < Formula
  desc "Archive a lifetime of email and chat with offline search and analytics"
  homepage "https://github.com/kenn-io/msgvault"
  version "0.21.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.21.0/msgvault_0.21.0_darwin_amd64.tar.gz"
      sha256 "e9d55bfd841c9709132fb1a230615a8d1476c73579fac7d6b7d632f6089a7131"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.21.0/msgvault_0.21.0_darwin_arm64.tar.gz"
      sha256 "154d18774074ae9d043c2aee0dfdd7fe9166028aed64a2dfa8104650d50ffa04"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.21.0/msgvault_0.21.0_linux_amd64.tar.gz"
      sha256 "56b2438eab14f3cadd15b6edecc4ea30454b6584c1039c2d5593a0afa77d7497"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.21.0/msgvault_0.21.0_linux_arm64.tar.gz"
      sha256 "48720a42f2b7340480d32c6622c0d372a2e894ce90f2a4f7be025c77ccb40512"
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
