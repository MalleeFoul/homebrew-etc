require_relative "../kdelib/cmake"

class Kcalendarcore < Formula
  desc "This library provides access to and handling of calendar data."
  homepage "https://api.kde.org/frameworks/kcalendarcore/html/index.html"
  url "https://invent.kde.org/frameworks/kcalendarcore/-/archive/v6.4.0/kcalendarcore-v6.4.0.tar.gz"
  sha256 "89bc8d6a9b15ecafd01a17d4a70ee7724d324c2fbbc3fd15da6f2bda1c542507"
  license :all_of ["BSD-3-Clause", "LGPL-2.0-or-later", "LGPL-3.0-or-later"]

  depends_on "cmake" => :build
  depends_on "qt"
  depends_on "libical"
  depends_on "vulkan-headers"
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
    # software. Run the test with `brew test kcalendarcore`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
