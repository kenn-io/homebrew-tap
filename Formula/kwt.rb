class Kwt < Formula
  desc "Git worktree manager with a terminal dashboard and scriptable CLI"
  homepage "https://github.com/kenn-io/kwt"
  version "0.9.6"
  license "Apache-2.0"

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kwt/releases/download/v0.9.6/kwt_0.9.6_darwin_amd64.tar.gz"
      sha256 "8c16fc908d65f9d56aec84ada51b4e3a9b4cc764568d9f684ff0b35b0d3eadbf"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kwt/releases/download/v0.9.6/kwt_0.9.6_darwin_arm64.tar.gz"
      sha256 "4b6527e01330474c004b7e363fead10b22daa1acb912f11c1f44532de66bcadb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kenn-io/kwt/releases/download/v0.9.6/kwt_0.9.6_linux_amd64.tar.gz"
      sha256 "9c9ba2260e480bbbba01edfcbe3315c2a603cdfca0d984723b97d279dae7728f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/kenn-io/kwt/releases/download/v0.9.6/kwt_0.9.6_linux_arm64.tar.gz"
      sha256 "8f926af83a8e4d5610ffbb2a830cfcf4e258ea98f0104062cc48743828d82c60"
    end
  end

  def install
    bin.install "kwt"
  end

  test do
    assert_match "kwt version v#{version}", shell_output("#{bin}/kwt version")

    system "git", "init", "--quiet", "--initial-branch=main", "repo"
    cd "repo" do
      system "git", "-c", "user.name=Test", "-c", "user.email=test@example.com",
             "commit", "--quiet", "--allow-empty", "--message=init"
      assert_match "Created worktree for branch 'feature'",
                   shell_output("#{bin}/kwt add -b feature --no-launch")
      assert_match "[feature]", shell_output("git worktree list")
    end
  ensure
    system bin/"kwt", "daemon", "stop"
  end
end
