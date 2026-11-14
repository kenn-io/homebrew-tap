class Msgvault < Formula
  desc "Archive a lifetime of email and chat with offline search and analytics"
  homepage "https://github.com/kenn-io/msgvault"
  version "0.23.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.23.0/msgvault_0.23.0_homebrew_darwin_amd64.tar.gz"
      sha256 "d0ca5d37e410e29c367a4879cb20b0630fae7caf5214b3a4c0ab20fece798594"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.23.0/msgvault_0.23.0_homebrew_darwin_arm64.tar.gz"
      sha256 "e32df0aa3175f2b0466485c297940619a1444d49903fcca291c49a550b3f5b59"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.23.0/msgvault_0.23.0_homebrew_linux_amd64.tar.gz"
      sha256 "fa12ea00c8232bac0e6820f705fa88aab346f7699eb09238727cbfbdadf46f9c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/msgvault/releases/download/v0.23.0/msgvault_0.23.0_homebrew_linux_arm64.tar.gz"
      sha256 "051b385d032d8e31cc55d6e97e6c667353b6f5e308586bb984f81219aed92b98"
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
