require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ssh2 < AbstractPhp70Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.1.2.tgz"
  sha256 "87618d6a0981afe8c24b36d6b38c21a0aa0237b62e60347d0170bd86b51f79fb"
  head "https://github.com/php/pecl-networking-ssh2.git"

  bottle do
    sha256 "f70a1064538ef194c183ab19be83bc8b74abaf9b4838b4523b399a15bb4c41c8" => :sierra
    sha256 "ef216adb7ef7a60839c87c11f87c38f0a6198149441bbadd9cb67d12d4c5879b" => :el_capitan
    sha256 "b7bdfb56ee24d0a889b6510c3f9834ccd050bf1e81eb323194458f438ba9268d" => :yosemite
  end

  depends_on "libssh2"

  def install
    Dir.chdir "ssh2-#{version}" unless build.head?
    
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-ssh2=#{Formula["libssh2"].opt_prefix}"
    system "make"
    prefix.install "modules/ssh2.so"
    write_config_file if build.with? "config-file"
  end
end
