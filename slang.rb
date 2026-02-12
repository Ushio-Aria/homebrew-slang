# typed: false
# frozen_string_literal: true

class Slang < Formula
  desc "Shader language compiler with modern features for real-time graphics"
  homepage "https://shader-slang.org/"
  version "2026.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/shader-slang/slang/releases/download/v2026.2/slang-2026.2-macos-aarch64.zip"
      sha256 "f80d76e42b9afe9238ac945d42276d4784967fe74c4a292bdbc35b1f0fa2ef39"
    end
    on_intel do
      url "https://github.com/shader-slang/slang/releases/download/v2026.2/slang-2026.2-macos-x86_64.zip"
      sha256 "715436f4c5b7463567fcad29d49f58100cf6c0cd7bc57eafb1147da1ef04c981"
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
