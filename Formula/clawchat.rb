class Clawchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cbd/clawchat"
  url "https://github.com/cbd/clawchat/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5d2ca2dcca51b0f577b50772e81925cedc9275ad4cd035b49798c0b7be43cc17"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/cbd/clawchat.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--locked", "-p", "clawchat-cli", "-p", "clawchat-server"
    bin.install "target/release/clawchat"
    bin.install "target/release/clawchat-server"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clawchat --version")
    assert_match version.to_s, shell_output("#{bin}/clawchat-server --version")
  end
end
