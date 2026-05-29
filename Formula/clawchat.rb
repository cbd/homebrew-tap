class Clawchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cbd/clawchat"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.2.1/clawchat-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "75e6598658a63d52e83867da1ef6b26d117e45936039ec24da3ce3816ccbdf1d"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.2.1/clawchat-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "6793a7cf49be07c28391d21288afe4d5f4064e65ca9dfdb0e2abe754bcdb5047"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.2.1/clawchat-v0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fd13c8bdb3d674d670be694e0211650c6b5c878434dd2e1710779800aadafd90"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.2.1/clawchat-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e22beffc79a0d3d445973c2a5daa8874923fb0ebdf5f9f390430d5f212be9cab"
    end
  end

  # `brew install --HEAD cbd/tap/clawchat` builds the latest from source instead.
  head do
    url "https://github.com/cbd/clawchat.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "build", "--release", "--locked", "-p", "clawchat-cli", "-p", "clawchat-server"
      bin.install "target/release/clawchat", "target/release/clawchat-server"
    else
      bin.install "clawchat", "clawchat-server"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clawchat --version")
    assert_match version.to_s, shell_output("#{bin}/clawchat-server --version")
  end
end
