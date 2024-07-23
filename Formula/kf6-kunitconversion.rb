require_relative "../kdelib/cmake"

class Kf6Kunitconversion < Formula
  desc "Support for unit conversion"
  homepage "https://api.kde.org/frameworks/kunitconversion/html/index.html"
  url "https://invent.kde.org/frameworks/kunitconversion/-/archive/v6.4.0/kunitconversion-v6.4.0.tar.gz"
  version "6.4.0"
  sha256 "f10df8d251f3351070dbc6f08b9612edbca6850b45aba0391610c45b0cb7917d"
  head "https://invent.kde.org/frameworks/kunitconversion.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6UnitConversion REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
  