class Varda < Formula
  desc "Routes markdown tasks to AI agents (Claude, Codex, Copilot) and tracks their lifecycle"
  homepage "https://github.com/nillebco/varda"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.6.0/varda-aarch64-apple-darwin.tar.xz"
      sha256 "5ec2d9bcff47540983806e7de6c71c4e1f1e21e180b1faa7f7218e1f76bb1fef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.6.0/varda-x86_64-apple-darwin.tar.xz"
      sha256 "37f35445df36ef2927436173ead4b7f42eb41913eda3eb5c1b38b21cdb935290"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.6.0/varda-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3fc0543aa313b8aa2b3b28e8137eca6e2c4e4de4ab9a0ea060c9190946480d5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.6.0/varda-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "105b0ad22de654ceab687890e0bc96dfc6ddc11e3d1c49fd435d9d751d9e6612"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
