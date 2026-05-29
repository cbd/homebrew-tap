class Clawchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cbd/clawchat"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.1.0/clawchat-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "f44bffd457d29420adce9af23a342b89357012769956d99983919e3e84a45266"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.1.0/clawchat-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "0f22db79a14201e9894a751b98e1db6fd87ffbf02213f3a98dcfb3b310a7d9e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.1.0/clawchat-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9cd0fa35e88f6427c586aacfc5c75fbec151f32e680a586707f8d2e52f7f5ef9"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.1.0/clawchat-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1cfa447576190a794b7df507a63ba0896b449f021c60ef70913fd288b786f6f3"
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
