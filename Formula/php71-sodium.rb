require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Sodium < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.4.tar.gz"
  sha256 "872f21f90993b4cbecada0516e49371ca6914c90538e9e41d50fee1187b45f6d"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "a29ed699108b4c2385a0503e04efccdf1dfab11d2b415a76744540f606e03c56" => :el_capitan
    sha256 "4b352ca5a03e426612923b92cc906daf996a115c07453a7086788e309390873b" => :yosemite
    sha256 "44dc6ea867f8cc7e77d390fae41fa9593cedca3e779792482bc5dd8d517846c7" => :mavericks
  end

  depends_on "libsodium"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
