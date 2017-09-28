require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2017-03-08/1.tar.gz"
    sha256 "95f966e1ba0ebce75cf237c7776b76adb4c24dfc844f80617b4a257c353754d2"
    version "201703081"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2017-03-08/1.tar.gz"
      sha256 "c6549081e6bf40b01763c96ae192d555670d93ed06f5bb04c092b54998382e48"
      version "201703081"
    end
  end
  bottle do
    cellar :any_skip_relocation
    sha256 "1e1bbd69be7dafbba74f408c19253dd7da9f0a59a2b99dd8881a36ca51329f4d" => :sierra
    sha256 "1e1bbd69be7dafbba74f408c19253dd7da9f0a59a2b99dd8881a36ca51329f4d" => :el_capitan
    sha256 "1e1bbd69be7dafbba74f408c19253dd7da9f0a59a2b99dd8881a36ca51329f4d" => :yosemite
  end


  head do
    url "https://github.com/phacility/arcanist.git"

    resource "libphutil" do
      url "https://github.com/phacility/libphutil.git"
    end
  end

  depends_on PhpMetaRequirement

  def install
    libexec.install Dir["*"]

    resource("libphutil").stage do
      (buildpath/"libphutil").install Dir["*"]
    end

    prefix.install Dir["*"]

    bin.install_symlink libexec/"bin/arc" => "arc"
  end

  test do
    system "#{bin}/arc", "help"
  end
end
