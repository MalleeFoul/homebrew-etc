require_relative "../kdelib/cmake"

class Kf6Kcoreaddons < Formula
  desc "Qt addon library with a collection of non-GUI utilities"
  homepage "https://api.kde.org/frameworks/kcoreaddons/html/index.html"
  url "https://invent.kde.org/frameworks/kcoreaddons/-/archive/v6.4.0/kcoreaddons-v6.4.0.tar.gz"
  sha256 "71c9f3c825fd049cc8e5e24b8fa055f5a83145a96cd4bcc22b30190f9cd6b5b0"
  head "https://invent.kde.org/frameworks/kcoreaddons.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "qt"

  def install
    system "cmake", "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
  
  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6CoreAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end