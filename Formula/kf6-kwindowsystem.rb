require_relative "../kdelib/cmake"

class Kf6Kwindowsystem < Formula
  desc "Access to the windowing system"
  homepage "https://api.kde.org/frameworks/kwindowsystem/html/index.html"
  url "https://invent.kde.org/frameworks/kwindowsystem/-/archive/v6.4.0/kwindowsystem-v6.4.0.tar.gz"
  version "6.4.0"
  sha256 "3181ce7e8749e8fbc9ed7d8a87ea2177cc68a4fd9ec382c0049f2ea1bac22a58"
  head "https://invent.kde.org/frameworks/kwindowsystem.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
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
    (testpath/"CMakeLists.txt").write("find_package(KF6WindowSystem REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
 