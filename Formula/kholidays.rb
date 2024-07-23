require_relative "../kdelib/cmake"

class Kholidays < Formula
  desc "Dates for holidays and other special events"
  homepage "https://api.kde.org/frameworks/kholidays/html/index.html"
  url "https://invent.kde.org/frameworks/kholidays/-/archive/v6.4.0/kholidays-v6.4.0.tar.gz"
  sha256 "8d176ce1833e58a815f14df75f1809c8872baff2f02c38b4894f1ae17d3b23af"


  depends_on "cmake" => :build
  depends_on "qt" => :build
  depends_on "extra-cmake-modules" => [:build, :test]

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
    # software. Run the test with `brew test kholidays`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
