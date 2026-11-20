class Msgvault < Formula
  desc "Archive a lifetime of email and chat with offline search and analytics"
  homepage "https://github.com/kenn-io/msgvault"
  version "0.26.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.26.0/msgvault_0.26.0_homebrew_darwin_amd64.tar.gz"
      sha256 "e6ec7e004d30ea9156d5071c32493460c21b079d87adde665a19b365858c1903"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.26.0/msgvault_0.26.0_homebrew_darwin_arm64.tar.gz"
      sha256 "4fa9df2797a505089db832382f2e9fcfb622a7b841c032612f56c03241f76058"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.26.0/msgvault_0.26.0_homebrew_linux_amd64.tar.gz"
      sha256 "a61e0d779cc3f39b162d4802da2b1c229e5c32760b6c8b6e38ca8573e0434af6"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.26.0/msgvault_0.26.0_homebrew_linux_arm64.tar.gz"
      sha256 "6223810f7c5b0e79e9cff8e184acd0872f464f28db89364c196821210000af20"
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
