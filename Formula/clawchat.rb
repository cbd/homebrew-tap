class Clawchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cbd/clawchat"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]
  deprecate! date: "2026-07-31",
    because: "was renamed to Cowchat",
    replacement_formula: "cowboyinc/tap/cowchat"

  on_macos do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.3.1/clawchat-v0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "5db1ec05acd7da429291106fd8ea766a9b7aaf9ca8b9bb768982bccfdb954514"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.3.1/clawchat-v0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "62520fad73601fec78431c89da48511e28c8249dabe6eaa06e22c947d823eb11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.3.1/clawchat-v0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b39d866bb7501df4ea70c32e6d830d73f8d2169ec47c77a0756ce944e76f6de6"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.3.1/clawchat-v0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b185a492f60bae1fb8ccb30628bb638a8ed39944ca0dd3758ea99a20e637230b"
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
