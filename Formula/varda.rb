class Varda < Formula
  desc "Routes markdown tasks to AI agents (Claude, Codex, Copilot) and tracks their lifecycle"
  homepage "https://github.com/nillebco/varda"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.3.1/varda-aarch64-apple-darwin.tar.xz"
      sha256 "90bd9fb1c31dafcc1aad18b43676cb615f56bae54d3c1cb5887828a51b5973ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.3.1/varda-x86_64-apple-darwin.tar.xz"
      sha256 "2d792439553bfb3b0cc60fc6fc6f9140a817ab0bb726c8f710bce0b67af8957a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.3.1/varda-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bf3ab75e74379defb4659071913c0bce0672840d0900629b528325b5802e29c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.3.1/varda-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "30b2287cb21ec1331d623549aadf1a4b843cef076dfa6241624dc2f0ba3e4249"
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
