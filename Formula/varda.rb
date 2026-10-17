class Varda < Formula
  desc "Routes markdown tasks to AI agents (Claude, Codex, Copilot) and tracks their lifecycle"
  homepage "https://github.com/nillebco/varda"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.4.1/varda-aarch64-apple-darwin.tar.xz"
      sha256 "dd0c1992bd2049711be5dff7eccbd8642cb71f149374111fac725b8f859ab874"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.4.1/varda-x86_64-apple-darwin.tar.xz"
      sha256 "1d43b4a9e180136db76a0b879cefb3b16e14edd28260d1788a8d9463b075f802"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.4.1/varda-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c941aa699de044fb7b537756415ab495c554660484fa18b4544519aff17be8f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.4.1/varda-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7c158d2ecf95863ebce97d84e5ab58bfe8dafb5f581d919994bf52cd2d9276c1"
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
