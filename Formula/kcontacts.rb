require_relative "../kdelib/cmake"

class Kcontacts < Formula
  desc "Support for vCard contacts"
  homepage "https://api.kde.org/frameworks/kcontacts/html/index.html"
  url "https://invent.kde.org/frameworks/kcontacts/-/archive/v6.4.0/kcontacts-v6.4.0.tar.gz"
  sha256 "576b7c32fe6650100dc6891c035fd2e917f55ba3babd4264f40268dbd62e3159"
  license :all_of ["Unicode-DFS-2016", "CC0-1.0", "LGPL-2.0-or-later",  "MIT", "BSD-3-Clause"]

  depends_on "cmake" => :build
  depends_on "kf6-kconfig"
  depends_on "kf6-kcodecs"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test kcontacts`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
