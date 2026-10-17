class Varda < Formula
  desc "Routes markdown tasks to AI agents (Claude, Codex, Copilot) and tracks their lifecycle"
  homepage "https://github.com/nillebco/varda"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.4.0/varda-aarch64-apple-darwin.tar.xz"
      sha256 "b73e75baab68291b29a31014cc2f9800eb7638985409f0fb71ae77d697b5e1dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.4.0/varda-x86_64-apple-darwin.tar.xz"
      sha256 "b4b7059d067fb4b2226a39d306f95e56f23f2c6fb84aa5e5897816abd75ec2a6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nillebco/varda/releases/download/v0.4.0/varda-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5abc19d5f7728a63553e1227f2dcf4a9907921d03c670fd4ebfa5be593e0068a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nillebco/varda/releases/download/v0.4.0/varda-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1b44258dc43f7095b71edf2b935f6eecdfc78ab644bd52e09fdd88057725e827"
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
