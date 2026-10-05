class Varda < Formula
  desc "Routes markdown tasks to AI agents (Claude, Codex, Copilot) and tracks their lifecycle"
  homepage "https://github.com/nillebco/varda"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.3.0/varda-aarch64-apple-darwin.tar.xz"
      sha256 "4251a72d3d94b3f3512b3c13785d02d17a6f9e7edf2b965c7e02a1419e16a165"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.3.0/varda-x86_64-apple-darwin.tar.xz"
      sha256 "337dadbf92b7b3928f21b8c27a9f1b6353e4c4b149fb2d5dc6d2105a3a0f1732"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.3.0/varda-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "67537f68ee6a57029429d5000c81916316a57ecb52ecc03d994163305fbd8e55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.3.0/varda-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d471b053a1332f2a347deca04aa1a91256f082bc0c29cde2a245c19e9a2bd3a0"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "varda"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "varda"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "varda"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "varda"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
