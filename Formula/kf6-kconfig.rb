require_relative "../kdelib/cmake"

class Kf6Kconfig < Formula
  desc "Persistent platform-independent application settings"
  homepage "https://api.kde.org/frameworks/kconfig/html/index.html"
  url "https://invent.kde.org/frameworks/kconfig/-/archive/v6.4.0/kconfig-v6.4.0.tar.gz"
  sha256 "40f4bc838194294f7bda50fb2f6cf82c2443cdd159fdb5a469ecf2d2512591a2"
  head "https://invent.kde.org/frameworks/kconfig.git", branch: "master"

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
    (testpath/"CMakeLists.txt").write("find_package(KF6Config REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
