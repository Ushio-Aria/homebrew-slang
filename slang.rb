# typed: false
# frozen_string_literal: true

class Slang < Formula
  desc "Shader language compiler with modern features for real-time graphics"
  homepage "https://shader-slang.org/"
  version "2026.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/shader-slang/slang/releases/download/v2026.1.2/slang-2026.1.2-macos-aarch64.zip"
      sha256 "4f087c4541377a9acac1cadef55744302cc5962d0dabc677ff93f180ef2e8fa5"
    end
    on_intel do
      url "https://github.com/shader-slang/slang/releases/download/v2026.1.2/slang-2026.1.2-macos-x86_64.zip"
      sha256 "4ec48a51469ff8bf5cfa11498c9522b743de584573fbf1185fd0fa4b1a89d457"
    end
  end

  def install
    bin.install Dir["bin/*"]
    lib.install Dir["lib/*"]
    include.install Dir["include/*"] if Dir.exist?("include")

    # Remove existing code signatures and re-sign with ad-hoc signature
    # This fixes "different Team IDs" error on macOS
    Dir[bin/"*", lib/"*.dylib"].each do |file|
      system "codesign", "--remove-signature", file if File.file?(file)
      system "codesign", "--sign", "-", "--force", file if File.file?(file)
    end
  end

  test do
    system "#{bin}/slangc", "--help"
  end
end
