class Msgvault < Formula
  desc "Archive a lifetime of email and chat with offline search and analytics"
  homepage "https://github.com/kenn-io/msgvault"
  version "0.24.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.24.0/msgvault_0.24.0_homebrew_darwin_amd64.tar.gz"
      sha256 "1ef6c3fb51ed90521366e6336303d0be9e876233ae016660b357f7eee8f45b55"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.24.0/msgvault_0.24.0_homebrew_darwin_arm64.tar.gz"
      sha256 "d2279764732bf447113ebbb2e4e30f6c56a0d05a1fc373d9885dc9c06c50c532"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.24.0/msgvault_0.24.0_homebrew_linux_amd64.tar.gz"
      sha256 "cad511703b3cb5a6e8f0aff702b3dcb193985ff61d333450c5462f5fafb956b2"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.24.0/msgvault_0.24.0_homebrew_linux_arm64.tar.gz"
      sha256 "ab47be6341494973b9422a51e7ca43d3bd805c44a426c3c0f11af38ee12f4fce"
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
