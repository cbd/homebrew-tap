class Clawchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cbd/clawchat"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.2.0/clawchat-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "b50ed542b6112594e739fae558b6372b7ab47a508d2fa5854dff77c789a53063"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.2.0/clawchat-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "5baf0a6c6c18f4a3d2a6301c8913e1ce632795335508941b77108fa140265934"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.2.0/clawchat-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0111d4e28cef0334d23223c85843a57764bb1d593f527c4359b46a03ee1879c7"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.2.0/clawchat-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a87b2832b0c4c315a765481199dec66db442688bd872e9b2a5b3a75c335ae729"
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
