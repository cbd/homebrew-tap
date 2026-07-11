class Clawchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cbd/clawchat"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.3.0/clawchat-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "62a4359a2535d988a4177aed68c9b5d0e266331798d68239b1f05f159a5fc8bf"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.3.0/clawchat-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "9ef7f880c404b2be1dd54bea04ec4776d738ac2f58af5ef9ba5013e535dd466f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.3.0/clawchat-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e2d0bc661349b24b890e9553fb9b44bee0d71252642fd09bbcb0eb1e99bc3a5e"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.3.0/clawchat-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9b63597ffea677b7eee318185d45790ce1fc403dc5d19df177423ce16ebb59cb"
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
