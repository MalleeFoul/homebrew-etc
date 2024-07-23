require_relative "../kdelib/cmake"

class Kf6Kcodecs < Formula
  desc "String encoding library"
  homepage "https://api.kde.org/frameworks/kcodecs/html/index.html"
  url "https://invent.kde.org/frameworks/kcodecs/-/archive/v6.4.0/kcodecs-v6.4.0.tar.gz"
  version "6.4.0"
  sha256 "e2a51aa80c94d291ce431d990d8429d86520de364007cdb31fc7c7bd4c8f80e8"
  head "https://invent.kde.org/frameworks/kcodecs.git", branch: "master"
  conflicts_with "kde-mac/kde/kf5-kcodecs", because: :versioned_formula

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gperf" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Codecs REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
