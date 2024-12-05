require_relative "../kdelib/cmake"

class Kalzium < Formula
  desc ""
  homepage ""
  url "https://invent.kde.org/education/kalzium/-/archive/v24.08.0/kalzium-v24.08.0.tar.gz"
  sha256 "45a8bd3622adb933ae451de0aa8894de56892890e69d6c88125e3da8b1f7b410"
  license ""

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ocaml"
  depends_on "open-babel"
  depends_on "eigen"
  depends_on "qt5"
  depends_on "gettext"
  depends_on
  depends_on

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
    # software. Run the test with `brew test Kalzium`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
