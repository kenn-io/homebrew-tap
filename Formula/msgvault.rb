class Msgvault < Formula
  desc "Archive a lifetime of email and chat with offline search and analytics"
  homepage "https://github.com/kenn-io/msgvault"
  version "0.25.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.25.0/msgvault_0.25.0_homebrew_darwin_amd64.tar.gz"
      sha256 "124c8ee28d3265bf985eff21a20d3233a4d8bde4f60c88259ca77ba8f9ee7ff1"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.25.0/msgvault_0.25.0_homebrew_darwin_arm64.tar.gz"
      sha256 "d3f548dc14514edb5619d70e1627f5cbffdbbf929c0a006d989b3321de194b2e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.25.0/msgvault_0.25.0_homebrew_linux_amd64.tar.gz"
      sha256 "54eff2739ff71279aeeccb3e3ae48457bf092067e0d3965fb628fc0904934fef"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.25.0/msgvault_0.25.0_homebrew_linux_arm64.tar.gz"
      sha256 "21a1cdb3a82b2de7fd74f090272de9aecacf875f2557618f41d886f695f9d7f5"
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
