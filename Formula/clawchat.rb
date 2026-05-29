class Clawchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cbd/clawchat"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.1.0/clawchat-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "b8f12b08f255cf874da79648971990cebcdeacf54e7ff58640482e1f30c67f28"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.1.0/clawchat-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "416ffe2a47a99663a5154e744d2728b193e867aeff3ff692fba654e7b6567610"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cbd/clawchat/releases/download/v0.1.0/clawchat-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e47bba422da80193700c27333b1b14672b0cebeecfa452286727b24727930b5"
    end
    on_intel do
      url "https://github.com/cbd/clawchat/releases/download/v0.1.0/clawchat-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "db26bce468b9394ae69b84db9aae1fe74b3278bd6def19544e02793e385e489c"
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
